var e="undefined"!==typeof globalThis?globalThis:"undefined"!==typeof self?self:global;var t={};
/**!
 * easy-pie-chart
 * Lightweight plugin to render simple, animated and retina optimized pie charts
 *
 * @license 
 * @author Robert Fleischmann <rendro87@gmail.com> (http://robert-fleischmann.de)
 * @version 2.1.7
 **/(function(e,a){t=a()})(t,(function(){var CanvasRenderer=function(t,a){var n;var i=document.createElement("canvas");t.appendChild(i);"object"===typeof G_vmlCanvasManager&&G_vmlCanvasManager.initElement(i);var r=i.getContext("2d");i.width=i.height=a.size;var o=1;if(window.devicePixelRatio>1){o=window.devicePixelRatio;i.style.width=i.style.height=[a.size,"px"].join("");i.width=i.height=a.size*o;r.scale(o,o)}r.translate(a.size/2,a.size/2);r.rotate((-1/2+a.rotate/180)*Math.PI);var s=(a.size-a.lineWidth)/2;a.scaleColor&&a.scaleLength&&(s-=a.scaleLength+2);Date.now=Date.now||function(){return+new Date};var drawCircle=function(e,t,a){a=Math.min(Math.max(-1,a||0),1);var n=a<=0;r.beginPath();r.arc(0,0,s,0,2*Math.PI*a,n);r.strokeStyle=e;r.lineWidth=t;r.stroke()};var drawScale=function(){var e;var t;r.lineWidth=1;r.fillStyle=a.scaleColor;r.save();for(var n=24;n>0;--n){if(n%6===0){t=a.scaleLength;e=0}else{t=.6*a.scaleLength;e=a.scaleLength-t}r.fillRect(-a.size/2+e,0,t,1);r.rotate(Math.PI/12)}r.restore()};var l=function(){return window.requestAnimationFrame||window.webkitRequestAnimationFrame||window.mozRequestAnimationFrame||function(e){window.setTimeout(e,1e3/60)}}();var drawBackground=function(){a.scaleColor&&drawScale();a.trackColor&&drawCircle(a.trackColor,a.trackWidth||a.lineWidth,1)};(this||e).getCanvas=function(){return i};(this||e).getCtx=function(){return r};(this||e).clear=function(){r.clearRect(a.size/-2,a.size/-2,a.size,a.size)};(this||e).draw=function(e){if(!a.scaleColor&&!a.trackColor)this.clear();else if(r.getImageData&&r.putImageData)if(n)r.putImageData(n,0,0);else{drawBackground();n=r.getImageData(0,0,a.size*o,a.size*o)}else{this.clear();drawBackground()}r.lineCap=a.lineCap;var t;t="function"===typeof a.barColor?a.barColor(e):a.barColor;drawCircle(t,a.lineWidth,e/100)}.bind(this||e);(this||e).animate=function(t,n){var i=Date.now();a.onStart(t,n);var r=function(){var o=Math.min(Date.now()-i,a.animate.duration);var s=a.easing(this||e,o,t,n-t,a.animate.duration);this.draw(s);a.onStep(t,n,s);o>=a.animate.duration?a.onStop(t,n):l(r)}.bind(this||e);l(r)}.bind(this||e)};var EasyPieChart=function(t,a){var n={barColor:"#ef1e25",trackColor:"#f9f9f9",scaleColor:"#dfe0e0",scaleLength:5,lineCap:"round",lineWidth:3,trackWidth:void 0,size:110,rotate:0,animate:{duration:1e3,enabled:true},easing:function(e,t,a,n,i){t/=i/2;return t<1?n/2*t*t+a:-n/2*(--t*(t-2)-1)+a},onStart:function(e,t){},onStep:function(e,t,a){},onStop:function(e,t){}};if("undefined"!==typeof CanvasRenderer)n.renderer=CanvasRenderer;else{if("undefined"===typeof SVGRenderer)throw new Error("Please load either the SVG- or the CanvasRenderer");n.renderer=SVGRenderer}var i={};var r=0;var o=function(){(this||e).el=t;(this||e).options=i;for(var o in n)if(n.hasOwnProperty(o)){i[o]=a&&"undefined"!==typeof a[o]?a[o]:n[o];"function"===typeof i[o]&&(i[o]=i[o].bind(this||e))}"string"===typeof i.easing&&"undefined"!==typeof jQuery&&jQuery.isFunction(jQuery.easing[i.easing])?i.easing=jQuery.easing[i.easing]:i.easing=n.easing;"number"===typeof i.animate&&(i.animate={duration:i.animate,enabled:true});"boolean"!==typeof i.animate||i.animate||(i.animate={duration:1e3,enabled:i.animate});(this||e).renderer=new i.renderer(t,i);(this||e).renderer.draw(r);t.dataset&&t.dataset.percent?this.update(parseFloat(t.dataset.percent)):t.getAttribute&&t.getAttribute("data-percent")&&this.update(parseFloat(t.getAttribute("data-percent")))}.bind(this||e);(this||e).update=function(t){t=parseFloat(t);i.animate.enabled?(this||e).renderer.animate(r,t):(this||e).renderer.draw(t);r=t;return this||e}.bind(this||e);(this||e).disableAnimation=function(){i.animate.enabled=false;return this||e};(this||e).enableAnimation=function(){i.animate.enabled=true;return this||e};o()};return EasyPieChart}));var a=t;export default a;

