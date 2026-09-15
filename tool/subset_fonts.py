#!/usr/bin/env python3
"""Second step of the existing Dart → FontTools workflow; never subsets a subset."""
import argparse
import hashlib
import json
import shutil
import urllib.request
from pathlib import Path
from fontTools import subset
from fontTools.ttLib import TTFont

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'local/fonts/source'
REVISION = 'bf89c62d616373be66ef9cb28d970891dd48df02'
BASE = f'https://raw.githubusercontent.com/google/fonts/{REVISION}/ofl/wdxllubrifontsc/'
FILES = {
    'WDXLLubrifontSC-Regular.ttf': '0134ed261d56aab8fa1860df677858c5d0d3ca899b2aa5430581c458a752e914',
    'OFL.txt': '048eba87d28b5d74c432cfa38ca44737e86a5508cf912c1b2cc211c45944e1d9',
}
ROBO_HASH = '79e851404657dac2106b3d22ad256d47824a9a5765458edb72c9102a45816d95'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def sources(flutter_root):
    SOURCE.mkdir(parents=True, exist_ok=True)
    for name, digest in FILES.items():
        path = SOURCE / name
        if not path.exists():
            request = urllib.request.Request(BASE + name, headers={'User-Agent': 'ShadowPlusing-font-build'})
            with urllib.request.urlopen(request, timeout=60) as response:
                data = response.read()
            if hashlib.sha256(data).hexdigest() != digest:
                raise ValueError(f'Unexpected upstream checksum: {name}')
            path.write_bytes(data)
        if sha(path) != digest:
            raise ValueError(f'Source checksum mismatch: {path}')
    roboto = SOURCE / 'Roboto-Regular.ttf'
    if not roboto.exists():
        executable = shutil.which('flutter')
        sdk = Path(flutter_root) if flutter_root else (Path(executable).resolve().parent.parent if executable else None)
        if sdk is None:
            raise ValueError('Pass --flutter-root PATH or put Flutter 3.35.7 on PATH.')
        original = sdk / 'bin/cache/artifacts/material_fonts/Roboto-Regular.ttf'
        if sha(original) != ROBO_HASH:
            raise ValueError('Expected the Roboto source bundled with Flutter 3.35.7.')
        shutil.copyfile(original, roboto)
    if sha(roboto) != ROBO_HASH:
        raise ValueError('Roboto source checksum mismatch.')


def generate(source, wanted):
    font = TTFont(source, recalcTimestamp=False)
    available = set(font.getBestCmap())
    options = subset.Options()
    options.recalc_timestamp = False
    options.layout_features = ['*']
    options.name_IDs = [0, 1, 2, 3, 4, 5, 6, 13, 14]
    options.name_legacy = True
    sub = subset.Subsetter(options=options)
    sub.populate(unicodes=wanted & available)
    sub.subset(font)
    return font, wanted & available


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--flutter-root')
    parser.add_argument('--check', action='store_true', help='Check bundled font coverage without modifying assets.')
    args = parser.parse_args()
    wanted = set(map(ord, (ROOT / 'local/fonts/fontcontent.txt').read_text()))
    targets = [ROOT / 'assets/fonts/WDXLLubrifontSC-Regular.ttf', ROOT / 'assets/fonts/site/Roboto-Regular.ttf']
    if args.check:
        covered = set().union(*(set(TTFont(p).getBestCmap()) for p in targets))
        missing = wanted - covered
        if missing:
            raise ValueError('Uncovered characters: ' + ''.join(map(chr, sorted(missing))))
        print(f'PASS: all {len(wanted)} required characters are covered.')
        return
    sources(args.flutter_root)
    built = [generate(SOURCE / name, wanted) for name in ['WDXLLubrifontSC-Regular.ttf', 'Roboto-Regular.ttf']]
    missing = wanted - set().union(*(coverage for _, coverage in built))
    if missing:
        raise ValueError('Source fonts cannot cover: ' + ''.join(map(chr, sorted(missing))))
    report = {'required_characters': len(wanted), 'wdxl_revision': REVISION, 'fonts': []}
    for target, (font, coverage) in zip(targets, built):
        old_size = target.stat().st_size if target.exists() else 0
        temp = target.with_suffix('.tmp.ttf')
        target.parent.mkdir(parents=True, exist_ok=True)
        font.save(temp)
        verified = set(TTFont(temp).getBestCmap())
        if not coverage <= verified:
            temp.unlink()
            raise ValueError(f'Subset lost required characters: {target}')
        temp.replace(target)
        report['fonts'].append({'file': str(target.relative_to(ROOT)), 'previous_bytes': old_size,
            'subset_bytes': target.stat().st_size, 'characters': len(coverage), 'sha256': sha(target)})
    shutil.copyfile(SOURCE / 'OFL.txt', ROOT / 'assets/fonts/WDXL_LICENSE.txt')
    (ROOT / 'local/fonts/subset-report.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(report, indent=2))


if __name__ == '__main__':
    main()
