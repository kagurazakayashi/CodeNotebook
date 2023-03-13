var body = document.body;
body.onclick = function (event) {
console.log("clicked at (" + event.clientX + "," + event.clientY + ")");
};

imitateClick(body, 50, 370);

function imitateClick(oElement, iClientX, iClientY) {
var oEvent;
if (document.createEventObject) {
    //For IE
    oEvent = document.createEventObject();
    oEvent.clientX = iClientX;
    oEvent.clientY = iClientY;
    oElement.fireEvent("onclick", oEvent);
} else {
    oEvent = document.createEvent("MouseEvents");
    oEvent.initMouseEvent(
    "click",
    true,
    true,
    document.defaultView,
    0,
    0,
    0,
    iClientX,
    iClientY /*, false, false, false, false, 0, null*/
    );
    oElement.dispatchEvent(oEvent);
}
}