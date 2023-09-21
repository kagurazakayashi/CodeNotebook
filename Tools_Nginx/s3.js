// js_set $s3date s3.s3date;
// js_set $s3signature s3.s3signature;
var crypto = require('crypto');
function s3date(r) {
    var now = new Date();
    var nowS = now.toISOString();
    var nowA = nowS.split(".");
    nowS = nowA[0];
    nowS = nowS.replaceAll(":", "");
    nowS = nowS.replaceAll("-", "");
    return nowS + "Z";
}
function s3signature(r) {
    var string_to_sign = r.method.toString() + "\n\n\n\nx-amz-date:" + r.variables.s3date + "\n/" + r.variables.s3image_bucket_name + "/" + r.variables.file;
    var signature = crypto.createHmac('sha1', r.variables.s3image_secret_key).update(string_to_sign);
    return signature.digest('base64');
}
export default { s3signature, s3date }