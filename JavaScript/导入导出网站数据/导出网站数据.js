// 导出当前网站的 Local Storage、Session Storage 和 Cookies 到一个 JSON 文件中。

(function() {
    function getCookies() {
        const cookies = {};
        document.cookie.split(';').forEach(cookie => {
            const [name, value] = cookie.split('=');
            cookies[name.trim()] = decodeURIComponent(value);
        });
        return cookies;
    }
    function getLocalStorage() {
        const localStorageData = {};
        for (let i = 0; i < localStorage.length; i++) {
            const key = localStorage.key(i);
            localStorageData[key] = localStorage.getItem(key);
        }
        return localStorageData;
    }
    function getSessionStorage() {
        const sessionStorageData = {};
        for (let i = 0; i < sessionStorage.length; i++) {
            const key = sessionStorage.key(i);
            sessionStorageData[key] = sessionStorage.getItem(key);
        }
        return sessionStorageData;
    }
    const data = {
        cookies: getCookies(),
        localStorage: getLocalStorage(),
        sessionStorage: getSessionStorage()
    };
    console.log("Exported Data:", JSON.stringify(data, null, 2));
    const blob = new Blob([JSON.stringify(data, null, 2)], {type: 'application/json'});
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'exported_data.json';
    a.click();
})();
