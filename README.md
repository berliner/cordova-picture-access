# cordova-picture-access
Simple cordova plugin for access check to the camera roll or picture gallery

# Usage

$window.plugins.pictureAccess.checkAccess(
  function() {
    // Go ahead and access the picture, e.g. with cordova image picker
  },
  function() {
    // Inform the user that he has to give permission for access.
    // Ideally, ask for permission and try again.
  }
);