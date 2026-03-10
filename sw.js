// ── Gifts World Pro — Service Worker ──────────────────────────
// Версия меняется при каждом деплое → браузер подхватывает обновление
const SW_VERSION = 'v' + Date.now();
const CACHE_NAME = 'gwp-cache-' + SW_VERSION;

// Файлы для кеша (только статика, не HTML)
const STATIC_ASSETS = [
    'manifest.json',
];

// ── Установка: кешируем статику ───────────────────────────────
self.addEventListener('install', event => {
    // Сразу активируемся, не ждём закрытия старых вкладок
    self.skipWaiting();
    event.waitUntil(
        caches.open(CACHE_NAME).then(cache => cache.addAll(STATIC_ASSETS)).catch(() => {})
    );
});

// ── Активация: удаляем старые кеши ───────────────────────────
self.addEventListener('activate', event => {
    event.waitUntil(
        caches.keys().then(keys =>
            Promise.all(
                keys
                    .filter(key => key !== CACHE_NAME)
                    .map(key => caches.delete(key))
            )
        ).then(() => self.clients.claim()) // берём управление всеми вкладками
    );
});

// ── Fetch: Network First для HTML, Cache First для картинок ───
self.addEventListener('fetch', event => {
    const url = new URL(event.request.url);

    // Firebase и внешние запросы — всегда сеть, не кешируем
    if (
        url.hostname.includes('firebase') ||
        url.hostname.includes('googleapis') ||
        url.hostname.includes('emailjs') ||
        url.protocol === 'chrome-extension:'
    ) {
        return; // браузер обработает сам
    }

    // HTML страницы — всегда сеть (чтобы обновления применялись мгновенно)
    if (event.request.headers.get('accept')?.includes('text/html') ||
        url.pathname.endsWith('.html') ||
        url.pathname === '/' ||
        url.pathname.endsWith('/a')
    ) {
        event.respondWith(
            fetch(event.request, { cache: 'no-store' })
                .catch(() => caches.match(event.request)) // offline fallback
        );
        return;
    }

    // Картинки — cache first (быстро), с обновлением в фоне
    if (
        url.pathname.match(/\.(png|jpg|jpeg|gif|webp|svg|ico)$/)
    ) {
        event.respondWith(
            caches.match(event.request).then(cached => {
                const fetchPromise = fetch(event.request).then(response => {
                    if (response.ok) {
                        const clone = response.clone();
                        caches.open(CACHE_NAME).then(cache => cache.put(event.request, clone));
                    }
                    return response;
                }).catch(() => cached);
                return cached || fetchPromise;
            })
        );
        return;
    }

    // JS/CSS — network first
    event.respondWith(
        fetch(event.request, { cache: 'no-store' })
            .catch(() => caches.match(event.request))
    );
});

// ── Сообщение от страницы: принудительная активация ──────────
self.addEventListener('message', event => {
    if (event.data?.type === 'SKIP_WAITING') {
        self.skipWaiting();
    }
});
