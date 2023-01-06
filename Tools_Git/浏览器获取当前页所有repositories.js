// 前往 /repositories 页
const baseurl = 'git clone ' + window.location.href.replace('orgs/', '').replace('repositories', '').split('?')[0];
const repolist = document.getElementsByClassName('repo-list')[0];
const as = repolist.getElementsByTagName('a');
let giturls = [];
for (const key in as) {
    if (Object.hasOwnProperty.call(as, key)) {
        const a = as[key];
        if (a.getAttribute('itemprop') === 'name codeRepository') {
            giturls.push(baseurl + a.innerText.replace(' ', '') + '.git');
        }
    }
}
console.log(giturls.join('\n'));
