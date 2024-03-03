'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/android/assets/call.svg": "14148808733ca8c109f6b57dd246fa87",
"assets/android/assets/carousel1.svg": "e4537423bf781de1e7ad7d3787503b38",
"assets/android/assets/carousel2.svg": "b800f54e2163676045c402c313a5466b",
"assets/android/assets/carousel3.svg": "5a6fa66523e682d860f4d2be36ed16c6",
"assets/android/assets/controller.svg": "59831564da52d80cdaf4d8efea7c1907",
"assets/android/assets/doubt.svg": "e386ddcafcb594b9247ed27ebb4f2e3b",
"assets/android/assets/msg.svg": "5d2f0b089c10cf50c07ed24380a9d9eb",
"assets/android/assets/qr.svg": "6ea1b390b35a9a47e7db83026c672d21",
"assets/android/assets/refresh.svg": "973a5a2750140d8e9afa3b70dca9927b",
"assets/android/assets/seatingplan.svg": "60d4b36990664f51abe0e8fb407943d1",
"assets/android/assets/sheetsubmit.svg": "718e02e2503da58f4244269f0a52ffaa",
"assets/android/assets/signinpage.svg": "ec291e5b72197d315a56e745e3629a0d",
"assets/android/assets/supplementary.svg": "2bda7256007849561e5cd8f64613cf43",
"assets/android/assets/ufm.svg": "1987d461d9aa38a4b528e6f65540c58f",
"assets/AssetManifest.bin": "a44df97050a7eda39e12a5f4f8470be8",
"assets/AssetManifest.bin.json": "a8dcad5325611bf016c17d9c92935f9d",
"assets/AssetManifest.json": "67c9d56eeb05be83b937cfb9bee2672b",
"assets/assets/Examination%2520Guidelines%2520for%2520Control%2520Room%2520Supervisors%2520(CRS).pdf": "eda6a9e29ab54c24a9f0c1116631e3b6",
"assets/assets/Examination%2520Guidelines%2520for%2520Flying%2520Squad.pdf": "af9d67b1638112112e9d97498dabdc2e",
"assets/assets/Examination%2520Guidelines%2520for%2520Invigilators.pdf": "2f5f91f4ae840d10dd5b09fd57c3d7c6",
"assets/assets/home_art.png": "8883e3a39db0b8e6db79d872ad223863",
"assets/assets/upes_logo.png": "4759b8132b597891ee046700296f847a",
"assets/assets/upes_logo.svg": "3854e71b0ce4d9e08b674828f19dd993",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "0213f5e6cd6b85b9b08fce5ef145849e",
"assets/NOTICES": "483490900ab68ffd09f19311c89f05bd",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/fluttertoast/assets/toastify.css": "910ddaaf9712a0b0392cf7975a3b7fb5",
"assets/packages/fluttertoast/assets/toastify.js": "18cfdd77033aa55d215e8a78c090ba89",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "59a12ab9d00ae8f8096fffc417b6e84f",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "33d29159d749a59874356d4631787396",
"/": "33d29159d749a59874356d4631787396",
"main.dart.js": "f252086f9eed1aae1794b2cceb0ab9f1",
"manifest.json": "ed50e8a954db89c20b3af3c2eeb2084c",
"splash/img/dark-1x.png": "e279208c795a0c8adedd9c0972419c12",
"splash/img/dark-2x.png": "54bb791d7b6dd74f24e766124e28bca7",
"splash/img/dark-3x.png": "e556435d494bcc893bf48ade55b6f2ed",
"splash/img/dark-4x.png": "8b4bf0dbe6e2d5e43918138160d374c9",
"splash/img/light-1x.png": "e279208c795a0c8adedd9c0972419c12",
"splash/img/light-2x.png": "54bb791d7b6dd74f24e766124e28bca7",
"splash/img/light-3x.png": "e556435d494bcc893bf48ade55b6f2ed",
"splash/img/light-4x.png": "8b4bf0dbe6e2d5e43918138160d374c9",
"version.json": "a4eb71b1ba8a50d9431fb6befb54ad5e"};
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
