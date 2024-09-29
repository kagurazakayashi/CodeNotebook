// 从 JSON 文件导入 Local Storage、Session Storage 和 Cookies 

(function() {
    function setCookies(cookies) {
        Object.keys(cookies).forEach(name => {
            document.cookie = `${name}=${encodeURIComponent(cookies[name])}; path=/;`;
        });
    }
    function setLocalStorage(localStorageData) {
        Object.keys(localStorageData).forEach(key => {
            localStorage.setItem(key, localStorageData[key]);
        });
    }
    function setSessionStorage(sessionStorageData) {
        Object.keys(sessionStorageData).forEach(key => {
            sessionStorage.setItem(key, sessionStorageData[key]);
        });
    }
    function importData(jsonData) {
        const data = JSON.parse(jsonData);
        setCookies(data.cookies);
        setLocalStorage(data.localStorage);
        setSessionStorage(data.sessionStorage);
        console.log("Data imported successfully.");
    }
    const fileInput = document.createElement('input');
    fileInput.type = 'file';
    fileInput.accept = 'application/json';
    fileInput.onchange = (event) => {
        const file = event.target.files[0];
        const reader = new FileReader();
        reader.onload = (e) => {
            importData(e.target.result);
        };
        reader.readAsText(file);
    };
    fileInput.click();
})();
