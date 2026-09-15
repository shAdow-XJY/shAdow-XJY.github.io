#!/usr/bin/env python3
"""Local Flutter preview with byte ranges for native media seeking (no publishing)."""
import argparse
import functools
import re
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer


class PreviewHandler(SimpleHTTPRequestHandler):
    def send_head(self):
        self.remaining = None
        path = self.translate_path(self.path)
        range_header = self.headers.get('Range')
        if not range_header:
            return super().send_head()
        try:
            stream = open(path, 'rb')
        except (OSError, IsADirectoryError):
            return super().send_head()
        stream.seek(0, 2)
        size = stream.tell()
        match = re.fullmatch(r'bytes=(\d*)-(\d*)', range_header.strip())
        try:
            if not match or not any(match.groups()):
                raise ValueError
            start_text, end_text = match.groups()
            if start_text:
                start = int(start_text)
                end = min(int(end_text), size - 1) if end_text else size - 1
            else:
                suffix = int(end_text)
                if suffix <= 0:
                    raise ValueError
                start, end = max(0, size - suffix), size - 1
            if start > end or start >= size:
                raise ValueError
        except ValueError:
            stream.close()
            self.send_response(416)
            self.send_header('Content-Range', f'bytes */{size}')
            self.send_header('Content-Length', '0')
            self.end_headers()
            return None
        self.send_response(206)
        self.send_header('Content-Type', self.guess_type(path))
        self.send_header('Content-Range', f'bytes {start}-{end}/{size}')
        self.send_header('Content-Length', str(end - start + 1))
        self.end_headers()
        stream.seek(start)
        self.remaining = end - start + 1
        return stream

    def end_headers(self):
        self.send_header('Accept-Ranges', 'bytes')
        self.send_header('Cache-Control', 'no-cache')
        super().end_headers()

    def copyfile(self, source, outputfile):
        if self.remaining is None:
            return super().copyfile(source, outputfile)
        while self.remaining > 0:
            block = source.read(min(64 * 1024, self.remaining))
            if not block:
                break
            outputfile.write(block)
            self.remaining -= len(block)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', default='build/web')
    parser.add_argument('--port', type=int, default=8765)
    args = parser.parse_args()
    handler = functools.partial(PreviewHandler, directory=args.directory)
    server = ThreadingHTTPServer(('127.0.0.1', args.port), handler)
    print(f'Preview: http://127.0.0.1:{args.port}/', flush=True)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        server.server_close()
