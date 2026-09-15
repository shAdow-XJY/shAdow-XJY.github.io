'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "52c7036a234bb70b3508998ea3e9ec00",
"version.json": "d066d2faac6c5033a4146542420fcb0c",
"index.html": "6b4705d9c5d3b66a56d76c8181ad6acf",
"/": "6b4705d9c5d3b66a56d76c8181ad6acf",
"CNAME": "26a32788081a2e271330074e2b45d580",
"js/fullScreen.js": "fd34a628de94f4d73b9f0ca98429db60",
"main.dart.js": "93affab67c3da16fce916d75e86fac4e",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"favicon.png": "f94cedcfa8c0b730572a18e4e2cb9c32",
"icons/Icon-192.png": "c19e0d2d4277def438c834395399eb8e",
"icons/Icon-maskable-192.png": "c19e0d2d4277def438c834395399eb8e",
"icons/Icon-maskable-512.png": "051a13ea5e4f34ea7bb0274b74cbfc5f",
"icons/Icon-512.png": "051a13ea5e4f34ea7bb0274b74cbfc5f",
"manifest.json": "541e11cd3de0b564f5cb060a1fddbc90",
"assets/AssetManifest.json": "335af3a6937887d565de7f1c3ee82f09",
"assets/NOTICES": "eadb8d7d4ec2c68266d39dc1a5dd1ef5",
"assets/FontManifest.json": "0778ca6d57d41d9990a0dbd430e0e17a",
"assets/AssetManifest.bin.json": "c8f7705c89a484caf3f8d5c0c5b3d6bb",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "38db71a50ac32664d8417df939d84b38",
"assets/fonts/MaterialIcons-Regular.otf": "668436dca0adefca61721c773f727d49",
"assets/assets/music/KoheiTanaka_BeyondtheHappyEnd.mp3": "22b454b403809ce4668c2cb156472965",
"assets/assets/music/KoheiTanaka_FleetingFragmentofMemory.mp3": "b277d022777d7e1388da0d596286664a",
"assets/assets/music/KoheiTanaka_Smallguide.mp3": "9393216bc6d78dfc1ef23eec6d0524f0",
"assets/assets/music/KoheiTanaka_Ifyouarewithyou.mp3": "b99d00fa7a015cdd51761b513d228618",
"assets/assets/video/%25E5%25A4%258F%25E6%2597%25A5%25E9%25A2%2584%25E5%2591%258A%25E4%25BC%2581%25E5%2588%2592.mp4": "be617a1406c2f9cf33332e5e0f678ea3",
"assets/assets/image/video/%25E5%25A4%258F%25E6%2597%25A5%25E9%25A2%2584%25E5%2591%258A%25E4%25BC%2581%25E5%2588%2592.png": "0ddf640fb8e88ac302b6b97121b84c8e",
"assets/assets/image/favorite/wlop.jpg": "da9b4d33c7a5ed94cfa3fc6fab0c4481",
"assets/assets/image/favorite/run.jpg": "c391ba997b235c29f247d373119835ba",
"assets/assets/image/background.jpg": "66968c48060859187e9c2415018d4271",
"assets/assets/image/avatar.jpg": "bad48d4cb9b830e62ebe6fbc03a4a596",
"assets/assets/image/book/redesign/backend.webp": "b9ce065e9b27612d3ba5b94d266245d2",
"assets/assets/image/book/redesign/writing.webp": "74bd943eae5373b5ccf35c71a710d81f",
"assets/assets/image/book/redesign/font.webp": "d48f46182e3ca040adfba6d84f738c0c",
"assets/assets/image/book/redesign/reading.webp": "ec4e6152d6db09ec41f09505fcce2f3f",
"assets/assets/image/book/redesign/search.webp": "4b64c51b1ccd0de33d6e9028c3bdd8db",
"assets/assets/image/collections/novel.webp": "d59b8b963fa5cd10444a95d7036c0038",
"assets/assets/image/collections/game.webp": "5d13b5d100f5a7db9f2cb0e25a66c754",
"assets/assets/icon/gitee.png": "23017ec2444a84698d9e2768479a2d0f",
"assets/assets/icon/github.png": "6f0434f8c06ccff56e756b8703d5c811",
"assets/assets/icon/bilibili.png": "b158db1a6540de767c1d310fb7319fda",
"assets/assets/icon/screenFull.png": "76c802e76e7b062da1d87bcfe1401414",
"assets/assets/icon/screenBack.png": "6b14994457d7bf6c99e0fbf7d26d54b9",
"assets/assets/fonts/WDXLLubrifontSC-Regular.ttf": "e6a2d68abec3aba2955f054f26e8f3c2",
"assets/assets/fonts/WDXL_LICENSE.txt": "a470b78d9b039f059efaa99466af6854",
"assets/assets/fonts/site/Roboto-Regular.ttf": "9479a228d6da8f04c739e839de013464",
"assets/assets/fonts/site/Roboto_LICENSE.txt": "3b83ef96387f14655fc854ddc3c6bd57",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
