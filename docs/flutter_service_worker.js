'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/android/assets/attendancereport.svg": "b96bae534a340d6ff55732c7d3e277e6",
"assets/android/assets/call.svg": "14148808733ca8c109f6b57dd246fa87",
"assets/android/assets/carousel1.svg": "e4537423bf781de1e7ad7d3787503b38",
"assets/android/assets/carousel2.svg": "b800f54e2163676045c402c313a5466b",
"assets/android/assets/carousel3.svg": "5a6fa66523e682d860f4d2be36ed16c6",
"assets/android/assets/controller.svg": "59831564da52d80cdaf4d8efea7c1907",
"assets/android/assets/doubt.svg": "e386ddcafcb594b9247ed27ebb4f2e3b",
"assets/android/assets/examsummary.svg": "ef8493ae40cb2a7e05bf4550e27fb357",
"assets/android/assets/leaveduty.svg": "6a57fe572fbb8cdd39cc492648aea3bb",
"assets/android/assets/msg.svg": "5d2f0b089c10cf50c07ed24380a9d9eb",
"assets/android/assets/qr.svg": "6ea1b390b35a9a47e7db83026c672d21",
"assets/android/assets/refresh.svg": "973a5a2750140d8e9afa3b70dca9927b",
"assets/android/assets/seatingplan.svg": "60d4b36990664f51abe0e8fb407943d1",
"assets/android/assets/sheetsubmit.svg": "718e02e2503da58f4244269f0a52ffaa",
"assets/android/assets/signinpage.svg": "ec291e5b72197d315a56e745e3629a0d",
"assets/android/assets/studentlookup.svg": "430bbff3fa70a8ebe881ba5ea48dee96",
"assets/android/assets/supplementary.svg": "2bda7256007849561e5cd8f64613cf43",
"assets/android/assets/ufm.svg": "1987d461d9aa38a4b528e6f65540c58f",
"assets/AssetManifest.bin": "f50591ebf8adc1c117e1fc5fbf0ebcfe",
"assets/AssetManifest.bin.json": "234a009f014ef3568f9f7dcb01de2a27",
"assets/AssetManifest.json": "b09fc1fa275978d396355db8f9722095",
"assets/assets/Examination%2520Guidelines%2520for%2520Control%2520Room%2520Supervisors%2520(CRS).pdf": "eda6a9e29ab54c24a9f0c1116631e3b6",
"assets/assets/Examination%2520Guidelines%2520for%2520Flying%2520Squad.pdf": "af9d67b1638112112e9d97498dabdc2e",
"assets/assets/Examination%2520Guidelines%2520for%2520Invigilators.pdf": "2f5f91f4ae840d10dd5b09fd57c3d7c6",
"assets/assets/home_art.png": "8883e3a39db0b8e6db79d872ad223863",
"assets/assets/upes_logo.png": "4759b8132b597891ee046700296f847a",
"assets/assets/upes_logo.svg": "3854e71b0ce4d9e08b674828f19dd993",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "1e6f416c928156a8e91744d37d1a61b7",
"assets/NOTICES": "d74d627f30447c0e25686541c1bfb34f",
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
"index.html": "5a690f5245de204fab7e2f9bcda865a8",
"/": "5a690f5245de204fab7e2f9bcda865a8",
"main.dart.js": "e51b9a38f1632348c0d50eae88badc3f",
"manifest.json": "ed50e8a954db89c20b3af3c2eeb2084c",
"version.json": "70ed0b55ccbe2347bf979521a9f2c47f"};
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
