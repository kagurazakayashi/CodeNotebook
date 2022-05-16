const obj = {
    hash: userhash,
};
const elistener = {
    hash: '',
    fuc() {
        console.log('!!!', this.hash);
    },
};
deleteDialog.removeEventListener('confirm', this.confirmDeleteObj);
this.confirmDeleteObj = elistener.fuc.bind(obj);
deleteDialog.addEventListener('confirm', this.confirmDeleteObj);