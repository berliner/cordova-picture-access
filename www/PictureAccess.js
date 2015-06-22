/**
 * A simple plugin for Cordova to check access to the camera roll on iOS.
 *
 * Developed by berliner for markveys
 */

var PictureAccess = function() {

};

/*
*	success - success callback
*	fail - error callback
*/
PictureAccess.prototype.checkAccess = function(success, fail) {
  if (device.platform.toLowerCase() != 'ios') {
    success();
    return;
  }
  cordova.exec(success, fail, "PictureAccess", "checkAccess");
};
if(!window.plugins) {
    window.plugins = {};
}
if (!window.plugins.pictureAccess) {
    window.plugins.pictureAccess = new PictureAccess();
}

if (typeof module != 'undefined' && module.exports) {
  module.exports = PictureAccess;
}
