'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "6dbde154874291e393e5bc277dfb608b",
"assets/AssetManifest.json": "f5ab1e4046c9ebeda4ca231636bc5045",
"assets/assets/canvaskit-wasm@0.33.0/bin/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"assets/assets/canvaskit-wasm@0.33.0/bin/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"assets/assets/fonts/NotoSansSC-Regular.otf": "37980b530d69f66e75052464d54ad3a7",
"assets/assets/icon/bilibili.png": "b158db1a6540de767c1d310fb7319fda",
"assets/assets/icon/gitee.png": "23017ec2444a84698d9e2768479a2d0f",
"assets/assets/icon/github.png": "6f0434f8c06ccff56e756b8703d5c811",
"assets/assets/icon/repositories.png": "56457bcc4eaef8e202350774f124f429",
"assets/assets/icon/screenBack.png": "6b14994457d7bf6c99e0fbf7d26d54b9",
"assets/assets/icon/screenFull.png": "76c802e76e7b062da1d87bcfe1401414",
"assets/assets/icon/write/Flutter.png": "d76b154521f300430e0724c11e9cec9f",
"assets/assets/icon/write/Other.png": "20866ba69937c88ae5f5791452c8b8d0",
"assets/assets/icon/write/Talk.png": "d555420b9839691c75a1f6db3078d6aa",
"assets/assets/icon/write/UnrealEngine.png": "58936349fe19057d1d53c9dcab16bf8a",
"assets/assets/icon/write/Vue.png": "723d392c2159191d4fff4fad56cced57",
"assets/assets/icon/write/Web.png": "0347cd9e8cd81295bd36279662cbaac9",
"assets/assets/image/avatar.jpg": "bad48d4cb9b830e62ebe6fbc03a4a596",
"assets/assets/image/background.jpg": "66968c48060859187e9c2415018d4271",
"assets/assets/image/favorite/run.jpg": "c391ba997b235c29f247d373119835ba",
"assets/assets/image/favorite/wlop.jpg": "da9b4d33c7a5ed94cfa3fc6fab0c4481",
"assets/assets/image/video/%25E5%25A4%258F%25E6%2597%25A5%25E9%25A2%2584%25E5%2591%258A%25E4%25BC%2581%25E5%2588%2592.png": "0ddf640fb8e88ac302b6b97121b84c8e",
"assets/assets/music/KoheiTanaka_BeyondtheHappyEnd.mp3": "22b454b403809ce4668c2cb156472965",
"assets/assets/music/KoheiTanaka_FleetingFragmentofMemory.mp3": "b277d022777d7e1388da0d596286664a",
"assets/assets/music/KoheiTanaka_Ifyouarewithyou.mp3": "b99d00fa7a015cdd51761b513d228618",
"assets/assets/music/KoheiTanaka_Smallguide.mp3": "9393216bc6d78dfc1ef23eec6d0524f0",
"assets/assets/program/flutter_pub%2520blur_glass.md": "9588ee1beb74f6628e82cf03dab3f9ff",
"assets/assets/program/flutter_pub%2520twolevel_list.md": "150b81cfc89980e7097fedf70b386621",
"assets/assets/program/github_blog.md": "494047e3199321c164728baaeee88c1b",
"assets/assets/program/Program.md": "608c579f4ad047ce8db1fd940aaa807f",
"assets/assets/programIndex/programIndex.txt": "3a73bf525833c919e0e1d5b1f00aba61",
"assets/assets/video/%25E5%25A4%258F%25E6%2597%25A5%25E9%25A2%2584%25E5%2591%258A%25E4%25BC%2581%25E5%2588%2592.mp4": "be617a1406c2f9cf33332e5e0f678ea3",
"assets/assets/videoIndex/%25E5%25A4%258F%25E6%2597%25A5%25E9%25A2%2584%25E5%2591%258A%25E4%25BC%2581%25E5%2588%2592.bilibili": "490d7d75dc55eee916e616ffe671591a",
"assets/assets/videoIndex/%25E5%25A4%258F%25E6%2597%25A5%25E9%25A2%2584%25E5%2591%258A%25E4%25BC%2581%25E5%2588%2592.youtube": "3d5a57b3556e1bd4d9dcca9f43a1c8aa",
"assets/assets/videoIndex/videoIndex.txt": "667430eeebd293be0f029f5b63d80a7e",
"assets/assets/write/Flutter/Flutter%2520package%2520publish.md": "eede06e51cb3902b500bcbd674f3e131",
"assets/assets/write/Flutter/Flutter.md": "0d380cbe4b2b69533d256ed981513ca8",
"assets/assets/write/Other/markdown%25E7%25BC%2596%25E8%25BE%2591%25E5%2599%25A8%25E2%2580%2594%25E2%2580%2594MarkText.md": "e999fc0791efa307682afc152c513ae9",
"assets/assets/write/UnrealEngine/UnrealEngine.md": "649e9e6e6ff49dcdd6d1f015594e30fe",
"assets/assets/write/Vue/Vue.md": "649e9e6e6ff49dcdd6d1f015594e30fe",
"assets/assets/write/Web/Web.md": "649e9e6e6ff49dcdd6d1f015594e30fe",
"assets/assets/writeIndex/Flutter.txt": "d6fec9b53c6f6b6e1700347a9b20a64d",
"assets/assets/writeIndex/Other.txt": "8c881f8575e63cce61ae3e04b65a9e78",
"assets/assets/writeIndex/UnrealEngine.txt": "5a62f566e2b8f7762ef52673e9c427fe",
"assets/assets/writeIndex/Vue.txt": "9158a600a4a8310f4e69c36d5865828c",
"assets/assets/writeIndex/Web.txt": "6b5670ff60a3562b7756db47bb1b8b2c",
"assets/assets/writeIndex/writeCategory.txt": "42e983f20aebb4eea2eda2fc17a0e4c2",
"assets/FontManifest.json": "3a6a37c450c06de501679286dc3bfab1",
"assets/fonts/MaterialIcons-Regular.otf": "0aac91170a1070c507f300f8bad5d719",
"assets/NOTICES": "0f274056032432f6128b53600e1c3507",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "45bec3a754fba62b2d8f23c38895f029",
"canvaskit/canvaskit.wasm": "e5b1f72690096075e25fe1f481cb6ce6",
"canvaskit/chromium/canvaskit.js": "6bdd0526762a124b0745c05281c8a53e",
"canvaskit/chromium/canvaskit.wasm": "347841c04107bb5a17164bee251d8307",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/skwasm.js": "831c0eebc8462d12790b0fadf3ab6a8a",
"canvaskit/skwasm.wasm": "2cb965595f656f0c58ad6bb5988f8280",
"canvaskit/skwasm.worker.js": "7ec8c65402d6cd2a341a5d66aa3d021f",
"CNAME": "26a32788081a2e271330074e2b45d580",
"favicon.png": "f94cedcfa8c0b730572a18e4e2cb9c32",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "c19e0d2d4277def438c834395399eb8e",
"icons/Icon-512.png": "051a13ea5e4f34ea7bb0274b74cbfc5f",
"icons/Icon-maskable-192.png": "c19e0d2d4277def438c834395399eb8e",
"icons/Icon-maskable-512.png": "051a13ea5e4f34ea7bb0274b74cbfc5f",
"index.html": "8b010b0ba60306982fe1ede67f59c8d5",
"/": "8b010b0ba60306982fe1ede67f59c8d5",
"js/fullScreen.js": "10c0399bfaa7ab7dc143affebfc074b7",
"main.dart.js": "6b6f6d94dfef110633b678aea27f7a95",
"manifest.json": "801a76987e825ec91939a1fd48081b42",
"README.md": "633b0e7f1da14ff3ec0fd5e3157f504f",
"version.json": "d066d2faac6c5033a4146542420fcb0c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
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
