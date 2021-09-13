'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "21c55016d83d238e005d3e2b58af850f",
"index.html": "62542aad8f3c205e2d7fca3f4c5e2137",
"/": "62542aad8f3c205e2d7fca3f4c5e2137",
"firebase-messaging-sw.js": "7e2da43b0582cc4d5d906e53c2495381",
"main.dart.js": "773123752a615a3f0fbace97709f3dbb",
"favicon.png": "005ad18be1f92424bf895699d9f76490",
"icons/Icon-192.png": "65e801371e87d88add7789361406788a",
"icons/Icon-512.png": "9afb09ee8cfad3618890b9948ecd3f7c",
"manifest.json": "00d0099a7333075678a5a56f83378efc",
"assets/AssetManifest.json": "f57464277a4f1fbf90f1a0ee1644bf08",
"assets/NOTICES": "e93d41bc822678ac0eae57b0e0736c58",
"assets/FontManifest.json": "137f3b453a9ed90e40c4611a0af8932e",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/assets/images/scaner.png": "cc56383717366976ba3d47bed2f37914",
"assets/assets/images/arrow_right.png": "56c89fe258ac71a5fba3c005b6aa1746",
"assets/assets/images/telegram.png": "72ba5e5511944cff264340045b2d601b",
"assets/assets/images/wallet.png": "fd2e453b5465fec43180efac1e0fc176",
"assets/assets/images/crypto_currency.png": "f60b8875037340573233e8833066ff4f",
"assets/assets/images/in_web.png": "98548173df7c38a8b32261d55b0cc707",
"assets/assets/images/number.png": "81638a492d12560e86fcd0ad746b77cd",
"assets/assets/images/settings.png": "18ecf9691840956243f9dc0daff6a6c0",
"assets/assets/images/key.png": "ece727a73339d0fe4fa3550fc092886b",
"assets/assets/images/fire.png": "b33afa1ac12bf05f7b7c52d2fb9fe6dc",
"assets/assets/images/lock.png": "485c261ae0d4d0b66474f6fe3adc5673",
"assets/assets/images/bell_notification.png": "eefb0fd50bfaaf97086a3dfe9b43d9bb",
"assets/assets/images/white_wallet.png": "11fa198383187e837ab820e4a8ddb635",
"assets/assets/images/keyhole_circle.png": "4b8f530d6f1dd61f8219c4106e4c91cf",
"assets/assets/images/logo.png": "bffc56853f4b4c64ceff50303c935963",
"assets/assets/images/twitter.png": "2fff9c1d05cfcc2c92debd233c9cd590",
"assets/assets/images/group_switch.png": "bf0e4fea59d439c141698f094e6b2eab",
"assets/assets/images/share.png": "d98030353f3beda6da98e8fb75b4e90c",
"assets/assets/images/earth_home.png": "1bca11f44a264443c4f205409d1f8451",
"assets/assets/images/language_translate.png": "b1431e6f38bd4d98004a0e3f669bbde7",
"assets/assets/images/convert.png": "541b8b2f6ae6e924de907d2753f618c7",
"assets/assets/images/plus_add.png": "f59393f00c2140846c2970d852a11f9c",
"assets/assets/images/splash_logo.png": "3aa3ac14cb5f0cfe1c834c139beaf449",
"assets/assets/images/copy.png": "f81735c6eb6bf84647f8b4661bf2975e",
"assets/assets/fonts/ibm_plex_sans_light.ttf": "29047654270fd882ab9e9ec10e28f7c5",
"assets/assets/fonts/ibm_plex_sans_medium.ttf": "ee83103a4a777209b0f759a4ff598066",
"assets/assets/fonts/ibm_plex_sans_regular.ttf": "c02b4dc6554c116e4c40f254889d5871",
"assets/assets/fonts/ibm_plex_sans_bold.ttf": "5159a5d89abe8bf68b09b569dbeccbc0",
"assets/assets/fonts/ibm_plex_sans_thin.ttf": "969246a285e76a59329d5e003f1a28a0"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
