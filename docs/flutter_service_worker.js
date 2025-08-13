'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "90dd7ae1d50a183b3d92d34e192edaa6",
"version.json": "d066d2faac6c5033a4146542420fcb0c",
"index.html": "6b4705d9c5d3b66a56d76c8181ad6acf",
"/": "6b4705d9c5d3b66a56d76c8181ad6acf",
"CNAME": "26a32788081a2e271330074e2b45d580",
"js/fullScreen.js": "fd34a628de94f4d73b9f0ca98429db60",
"main.dart.js": "045161a8a8125f7567a00dbf0d92141b",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"favicon.png": "f94cedcfa8c0b730572a18e4e2cb9c32",
"icons/Icon-192.png": "c19e0d2d4277def438c834395399eb8e",
"icons/Icon-maskable-192.png": "c19e0d2d4277def438c834395399eb8e",
"icons/Icon-maskable-512.png": "051a13ea5e4f34ea7bb0274b74cbfc5f",
"icons/Icon-512.png": "051a13ea5e4f34ea7bb0274b74cbfc5f",
"manifest.json": "541e11cd3de0b564f5cb060a1fddbc90",
"assets/AssetManifest.json": "d9da80bb32ca2ccf063c7943d49a0a8a",
"assets/NOTICES": "5a971393af3e0e993d0e311fb30dc15c",
"assets/FontManifest.json": "174c71210739787f814730ea13519b4d",
"assets/AssetManifest.bin.json": "113593f8f8fdada9cf914317863487fa",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "c816f0a1472bcd31d0549d68e28fe5bd",
"assets/fonts/MaterialIcons-Regular.otf": "b0c07bb620d6601e0623727fbf9740da",
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
"assets/assets/image/book/novel_read.png": "2fa32fb0989779ce0a3b4d140a9a314e",
"assets/assets/image/book/back_end.png": "1912c280d22e2306e6dcd0925c33c0ec",
"assets/assets/image/book/writing_writer.jpg": "6e034920eac181e0cda7f585cea24a4a",
"assets/assets/image/book/custom_search.png": "750f301a5d98b89ad18092f66da170cf",
"assets/assets/image/book/sub_font.png": "daa255589761c0dc17bad89bf88f61d1",
"assets/assets/image/program/gameCenter.png": "a10a5affc052fc3bc088b7f07fc8846a",
"assets/assets/image/program/novelCenter.png": "45c52d6d80846327563f0de9b82ee92d",
"assets/assets/icon/gitee.png": "23017ec2444a84698d9e2768479a2d0f",
"assets/assets/icon/github.png": "6f0434f8c06ccff56e756b8703d5c811",
"assets/assets/icon/bilibili.png": "b158db1a6540de767c1d310fb7319fda",
"assets/assets/icon/screenFull.png": "76c802e76e7b062da1d87bcfe1401414",
"assets/assets/icon/screenBack.png": "6b14994457d7bf6c99e0fbf7d26d54b9",
"assets/assets/icon/repositories.png": "56457bcc4eaef8e202350774f124f429",
"assets/assets/fonts/WDXLLubrifontSC-Regular.ttf": "3e1bb2676522984051ea4b5ba69b3801",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
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
