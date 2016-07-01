var MTUserId='1310fa1b-3e86-4c91-a228-bee73a98ee9e';
var MTFontIds = new Array();

MTFontIds.push("1475500"); // Avenir® W04 35 Light 
MTFontIds.push("1475524"); // Avenir® W04 55 Roman 
MTFontIds.push("1475548"); // Avenir® W04 85 Heavy 

(function() {
  var mtTracking = document.createElement('script');
  mtTracking.type = 'text/javascript';
  mtTracking.async = 'true';
  mtTracking.src = '/assets/pixeladmin/fonts/mtiFontTrackingCode.js';

  (document.getElementsByTagName('head')[0]||document.getElementsByTagName('body')[0]).appendChild(mtTracking);
})();