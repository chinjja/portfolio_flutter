'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "a5f9e9c409744142d2edd19baece497f",
"assets/assets/images/banner.jpg": "445cdb3d357c1734cb578e4d97869057",
"assets/assets/images/me.jpg": "8cbb18a3fbecd8dba5df7fed00a5b9ce",
"assets/assets/projects/instagram/10.jpg": "4fc9c6dd2daa498959bc8f289aab2792",
"assets/assets/projects/instagram/4.jpg": "5ba021f852128e5c5a678aef6c4eb61f",
"assets/assets/projects/instagram/7.jpg": "05cf7b03e776ac78f78f5ba36e2ba1b4",
"assets/assets/projects/instagram/3.jpg": "c97f667cdec78c7e1354b08c168a6363",
"assets/assets/projects/instagram/9.jpg": "6e71f112a903030d2dfe22bad7e74437",
"assets/assets/projects/instagram/2.jpg": "68f1e325a25795413e89c96bb5f6538c",
"assets/assets/projects/instagram/11.jpg": "fee3310683ae0982606d5de3cadc6310",
"assets/assets/projects/instagram/6.jpg": "ed1f769f1608f6e40c25f13d51262a04",
"assets/assets/projects/instagram/README.md": "b0575815db8f7ee1c463b2df89fea3ef",
"assets/assets/projects/instagram/5.jpg": "33aaa236637859a81f78ab2ce9313044",
"assets/assets/projects/instagram/1.jpg": "1ffd4b01762bf1a51fe08c38b302ee15",
"assets/assets/projects/instagram/8.jpg": "b25c89a2b4d737710b45c56d24119177",
"assets/assets/projects/sketch/2.png": "a1ef394361383073404973c785b56c72",
"assets/assets/projects/sketch/3.png": "d3b2e10cd9b07c5185a47fce4e67046e",
"assets/assets/projects/sketch/1.png": "c20cb87692ee709ae70b96b901345526",
"assets/assets/projects/sketch/README.md": "bd211304edfe92aef17314dc46c93267",
"assets/assets/projects/talk/2.png": "d386671f855b71276dd4ede448435904",
"assets/assets/projects/talk/4.png": "ac70628ae41f9cf92c3c4c1f92573f53",
"assets/assets/projects/talk/3.png": "5d2cb5177135f10ab059c16da82613f0",
"assets/assets/projects/talk/1.png": "24d1a618ec6d058d18255928169dabc3",
"assets/assets/projects/talk/README.md": "cea7b2bf9e361f9e19baa47d6cdf627d",
"assets/assets/projects/calendar/drawer.png": "793a40a73637af243e3dd255a6fcc98a",
"assets/assets/projects/calendar/today.png": "324f02c0446e3f254bde1fdba06d8fa2",
"assets/assets/projects/calendar/day1.png": "57308373193c5bd4f337f6feb79bebde",
"assets/assets/projects/calendar/viewer.png": "dfc3319aeacb4d546b68a02023c17a5d",
"assets/assets/projects/calendar/editor.png": "8e0f5f7b5626bf39db606e2dcd21baa5",
"assets/assets/projects/calendar/month.png": "462208f3ea0d6713b1a6fe53fcc099b2",
"assets/assets/projects/calendar/README.md": "1083b7d81452915a37bb151e01dfd6a9",
"assets/assets/projects/calendar/day2.png": "def3ba468d98b8b8668bf12c2371d2bd",
"assets/assets/projects/daf/2.png": "803948f05167fee1aa2a833abe66eef4",
"assets/assets/projects/daf/4.png": "6b80c50df162976fdd60f5087d63d37a",
"assets/assets/projects/daf/5.png": "31d79f3c903ccb255ec4deddd97942c6",
"assets/assets/projects/daf/3.png": "b21f3da30a1c8d2b02d15137cbbc366e",
"assets/assets/projects/daf/1.png": "6a3ea5b23b0172aa82786930f455f762",
"assets/assets/projects/daf/README.md": "088061fe25b10a23c0b635422d298d3c",
"assets/assets/projects/daf/7.png": "2d958accae6f9fed2e75764364ccbd4e",
"assets/assets/projects/daf/6.png": "daf12f5f2bbd23dd61aa52fd22565428",
"assets/assets/projects/dtk/2.png": "bea164a8f1838969fdd94433bea25338",
"assets/assets/projects/dtk/4.png": "88287842c3de016a7ddc54a4659d6c2c",
"assets/assets/projects/dtk/5.png": "8844981fcc3b6ea33c372e679c38a9b6",
"assets/assets/projects/dtk/3.png": "5f9db525777ecda0c241c530bc3534a4",
"assets/assets/projects/dtk/1.png": "b7f2cfe959b06ea95eea1a5c5be18b34",
"assets/assets/projects/dtk/README.md": "29ae8233516fb9c3f28df747b27b165d",
"assets/assets/projects/dtk/9.png": "5fabe381316c9728956af15397a797a2",
"assets/assets/projects/dtk/7.png": "7123de72a4d06f9492662cac4313ccdc",
"assets/assets/projects/dtk/6.png": "da5669b7756e3424a0612463b3ff7399",
"assets/assets/projects/dtk/8.png": "ffbc383e65590a0ecfcca2ce9c139f7c",
"assets/assets/projects/portfolio/2.png": "9b4b1f665dc11a1fd3700520095e40f4",
"assets/assets/projects/portfolio/4.png": "9a09734b8f2b018c170467aff0e54c8e",
"assets/assets/projects/portfolio/5.png": "7bc70491f646e9817bd0c64e8187a57f",
"assets/assets/projects/portfolio/3.png": "309eff2c12e177f5040cf57d612d8883",
"assets/assets/projects/portfolio/1.png": "a3adf84ffc1b339fb428c3429a0f08cc",
"assets/assets/projects/portfolio/README.md": "b3c82fc8f3e20e548e73d9f4d1c7d522",
"assets/assets/logos/android.png": "502737779a3d747c2f13bfb04d1bb632",
"assets/assets/logos/github.png": "a9dba215ebb679b3fc9606b08bef38d8",
"assets/assets/logos/sqlite.png": "6d17dc420a4483b9b059acd4c8f9a484",
"assets/assets/logos/spring.png": "9ebc4611ab18f5911bef5b7797e8bcf4",
"assets/assets/logos/boj.png": "d6ed5e367000617be30c0f3370a1c62c",
"assets/assets/logos/git.png": "c6a75af7e6af9b3a3fc3dd49365099af",
"assets/assets/logos/java.png": "f12c42d5c2f7fdb802f05ef8e686c153",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "6776cbda833178863a943930bd60a0c2",
"assets/NOTICES": "aa639cca41f14eeff1d0e63b2dd1499d",
"assets/AssetManifest.bin": "99bd1d42cf8df6acd2c8675d7a0486c5",
"assets/AssetManifest.json": "13a44bb9aeffe2d0983fd77ff5c688a2",
"assets/fonts/MaterialIcons-Regular.otf": "7743bc5d97bfb362fb4027fffb864db3",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"flutter.js": "f31737fb005cd3a3c6bd9355efd33061",
"index.html": "9dd2eab09cca169cf6591d10a73419f0",
"/": "9dd2eab09cca169cf6591d10a73419f0",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.js": "5fda3f1af7d6433d53b24083e2219fa0",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "87325e67bf77a9b483250e1fb1b54677",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.js": "9fa2ffe90a40d062dd2343c7b84caf01",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"manifest.json": "d40c47d1c161f94dbcb13094d37f1f55",
"main.dart.js": "e4d1ea17c61e8f48509d53e3fb90cd64",
"version.json": "009c9e65172e010890f7f65fde438006"};
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
