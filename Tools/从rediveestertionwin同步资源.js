// https://redive.estertion.win/card/full/
var ee_names = document.getElementsByClassName("name");
var ee_paths = [];
for (let i = 0; i < ee_names.length; i++) {
    const ee_namei = ee_names[i];
    const filename = ee_namei.getAttribute("data-original");
    const chrname = ee_namei.innerHTML;
    const extname = filename.split('.')[1]
    const cmd = 'wget -nc "' + window.location.href + filename + '" -O "' + chrname + '.' + extname + '"';
    ee_paths[i] = cmd;
}
console.log(ee_paths.join('\n'));

// https://redive.estertion.win/movie/
var ee_div = document.getElementsByTagName("div")[1];
var ee_a = ee_div.getElementsByTagName("a");
ee_div = ee_div.getElementsByTagName("div");
var ee_paths = [];
var ee_dirs = [];
for (let i = 0; i < ee_a.length; i++) {
    const nowa = ee_a[i];
    const filepath = nowa.getAttribute("href");
    const filepatharr = filepath.split('/');
    if (filepatharr.length >= 2) {
        const dir = 'mkdir "' + filepatharr[0] + '"';
        if (ee_dirs.indexOf(dir) < 0) {
            ee_dirs.push(dir);
        }
    }
    const durl = window.location.href + filepath;
    const cmd = 'wget -nc "' + durl + '" -O "' + filepath + '"';
    ee_paths[i] = cmd;
}
console.log(ee_dirs.join('\n') + '\n' + ee_paths.join('\n'));

// https://redive.estertion.win/icon/item/
var ee_paths = [];
var ee_a = document.getElementsByTagName("a");
for (let i = 0; i < ee_a.length; i++) {
    const nowa = ee_a[i];
    const filepath = nowa.getAttribute("href");
    const durl = window.location.href + filepath;
    const cmd = 'wget -nc "' + durl + '"';
    ee_paths[i] = cmd;
}
console.log(ee_paths.join('\n'));