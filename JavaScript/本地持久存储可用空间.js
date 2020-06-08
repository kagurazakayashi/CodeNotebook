function localStorageUse() {
    if (!window.localStorage) return 0;
    var size = 0;
    for(item in window.localStorage) {
        if(window.localStorage.hasOwnProperty(item)) {
            size += window.localStorage.getItem(item).length;
        }
    }
    return size / 1024;
}
function localStorageFree() {
    var storageSize = 0;
    for (var i = 0, data = "m"; i < 100; i++) {
        try {
            localStorage.setItem("TESTDATA", data);
            data = data + data;
        } catch(e) {
            storageSize = JSON.stringify(localStorage).length / 1024;
            break;
        }
    }
    localStorage.removeItem("TESTDATA");
    return storageSize;
}
function localStorageInfo() {
    const free = localStorageFree();
    const use = localStorageUse();
    const all = free + use;
    const perc = (use / all) * 100;
    return [use.toFixed(2),free.toFixed(2),all.toFixed(2),perc.toFixed(2)];
}