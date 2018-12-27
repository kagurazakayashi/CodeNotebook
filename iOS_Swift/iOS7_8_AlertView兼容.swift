var device : UIDevice = UIDevice.currentDevice()!;
var systemVersion = device.systemVersion;
var iosVerion : Float = systemVersion.bridgeToObjectiveC().floatValue;
if(iosVerion < 8.0) {
    let alert = UIAlertView()
    alert.title = "Noop"
    alert.message = "Nothing to verify"
    alert.addButtonWithTitle("Click")
    alert.show()
} else {
    var alert : UIAlertController = UIAlertController(title: "Noop", message: "Nothing to verify", preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "Click", style:.Default, handler: nil))
    self.presentViewController(alert, animated: true, completion: nil)
}
