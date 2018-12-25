const fac = $(".footer-avatar-ac");
var factimer;
function facdo() {
    fac.click();
}
function facstart() {
    factimer = self.setInterval("facdo()",1);
}
function facstop() {
    factimer = window.clearInterval(factimer);
}