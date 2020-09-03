// 卡面 https://redive.estertion.win/card/full/
// 剧情立绘 https://redive.estertion.win/card/story/
// 加载小漫画 https://redive.estertion.win/comic/
// 角色 https://redive.estertion.win/icon/unit/
// 暗影角色 https://redive.estertion.win/icon/unit_shadow/
// 角色plate https://redive.estertion.win/icon/plate/
// 资料背景普通 https://redive.estertion.win/card/profile/
// 资料背景现实 https://redive.estertion.win/card/actual_profile/
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

// 装备图标 https://redive.estertion.win/icon/equipment/
// 物品图标 https://redive.estertion.win/icon/item/
// 技能图标 https://redive.estertion.win/icon/skill/
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

// 视频 https://redive.estertion.win/movie/
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