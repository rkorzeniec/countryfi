var e={};Object.defineProperty(e,"__esModule",{value:true});const t={svg:"http://www.w3.org/2000/svg",xmlns:"http://www.w3.org/2000/xmlns/",xhtml:"http://www.w3.org/1999/xhtml",xlink:"http://www.w3.org/1999/xlink",ct:"http://gionkunz.github.com/chartist-js/ct"};const s=8;const i={"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#039;"};function ensureUnit(e,t){return"number"===typeof e?e+t:e}function quantity(e){if("string"===typeof e){const t=/^(\d+)\s*(.*)$/g.exec(e);return{value:t?+t[1]:0,unit:(null===t||void 0===t?void 0:t[2])||void 0}}return{value:Number(e)}}
/**
 * Generates a-z from a number 0 to 26
 * @param n A number from 0 to 26 that will result in a letter a-z
 * @return A character from a-z based on the input number n
 */function alphaNumerate(e){return String.fromCharCode(97+e%26)}const a=2221e-19;
/**
 * Calculate the order of magnitude for the chart scale
 * @param value The value Range of the chart
 * @return The order of magnitude
 */function orderOfMagnitude(e){return Math.floor(Math.log(Math.abs(e))/Math.LN10)}
/**
 * Project a data length into screen coordinates (pixels)
 * @param axisLength The svg element for the chart
 * @param length Single data value from a series array
 * @param bounds All the values to set the bounds of the chart
 * @return The projected data length in pixels
 */function projectLength(e,t,s){return t/s.range*e}
/**
 * This helper function can be used to round values with certain precision level after decimal. This is used to prevent rounding errors near float point precision limit.
 * @param value The value that should be rounded with precision
 * @param [digits] The number of digits after decimal used to do the rounding
 * @returns Rounded value
 */function roundWithPrecision(e,t){const i=Math.pow(10,t||s);return Math.round(e*i)/i}
/**
 * Pollard Rho Algorithm to find smallest factor of an integer value. There are more efficient algorithms for factorization, but this one is quite efficient and not so complex.
 * @param num An integer number where the smallest factor should be searched for
 * @returns The smallest integer factor of the parameter num.
 */function rho(e){if(1===e)return e;function gcd(e,t){return e%t===0?t:gcd(t,e%t)}function f(e){return e*e+1}let t=2;let s=2;let i;if(e%2===0)return 2;do{t=f(t)%e;s=f(f(s))%e;i=gcd(Math.abs(t-s),e)}while(1===i);return i}
/**
 * Calculate cartesian coordinates of polar coordinates
 * @param centerX X-axis coordinates of center point of circle segment
 * @param centerY X-axis coordinates of center point of circle segment
 * @param radius Radius of circle segment
 * @param angleInDegrees Angle of circle segment in degrees
 * @return Coordinates of point on circumference
 */function polarToCartesian(e,t,s,i){const a=(i-90)*Math.PI/180;return{x:e+s*Math.cos(a),y:t+s*Math.sin(a)}}
/**
 * Calculate and retrieve all the bounds for the chart and return them in one array
 * @param axisLength The length of the Axis used for
 * @param highLow An object containing a high and low property indicating the value range of the chart.
 * @param scaleMinSpace The minimum projected length a step should result in
 * @param onlyInteger
 * @return All the values to set the bounds of the chart
 */function getBounds(e,t,s){let i=arguments.length>3&&void 0!==arguments[3]&&arguments[3];const n={high:t.high,low:t.low,valueRange:0,oom:0,step:0,min:0,max:0,range:0,numberOfSteps:0,values:[]};n.valueRange=n.high-n.low;n.oom=orderOfMagnitude(n.valueRange);n.step=Math.pow(10,n.oom);n.min=Math.floor(n.low/n.step)*n.step;n.max=Math.ceil(n.high/n.step)*n.step;n.range=n.max-n.min;n.numberOfSteps=Math.round(n.range/n.step);const r=projectLength(e,n.step,n);const o=r<s;const l=i?rho(n.range):0;if(i&&projectLength(e,1,n)>=s)n.step=1;else if(i&&l<n.step&&projectLength(e,l,n)>=s)n.step=l;else{let t=0;for(;;){if(o&&projectLength(e,n.step,n)<=s)n.step*=2;else{if(o||!(projectLength(e,n.step/2,n)>=s))break;n.step/=2;if(i&&n.step%1!==0){n.step*=2;break}}if(t++>1e3)throw new Error("Exceeded maximum number of iterations while optimizing scale step!")}}n.step=Math.max(n.step,a);function safeIncrement(e,t){e===(e+=t)&&(e*=1+(t>0?a:-a));return e}let c=n.min;let h=n.max;while(c+n.step<=n.low)c=safeIncrement(c,n.step);while(h-n.step>=n.high)h=safeIncrement(h,-n.step);n.min=c;n.max=h;n.range=n.max-n.min;const u=[];for(let e=n.min;e<=n.max;e=safeIncrement(e,n.step)){const t=roundWithPrecision(e);t!==u[u.length-1]&&u.push(t)}n.values=u;return n}function extend(){let e=arguments.length>0&&void 0!==arguments[0]?arguments[0]:{};for(var t=arguments.length,s=new Array(t>1?t-1:0),i=1;i<t;i++)s[i-1]=arguments[i];for(let t=0;t<s.length;t++){const i=s[t];for(const t in i){const s=i[t];e[t]="object"!==typeof s||null===s||s instanceof Array?s:extend(e[t],s)}}return e}
/**
 * Helps to simplify functional style code
 * @param n This exact value will be returned by the noop function
 * @return The same value that was provided to the n parameter
 */const noop=e=>e;function times(e,t){return Array.from({length:e},t?(e,s)=>t(s):()=>{})}const sum=(e,t)=>e+(t||0);const serialMap=(e,t)=>times(Math.max(...e.map((e=>e.length))),(s=>t(...e.map((e=>e[s])))));function safeHasProperty(e,t){return null!==e&&"object"===typeof e&&Reflect.has(e,t)}function isNumeric(e){return null!==e&&isFinite(e)}function isFalseyButZero(e){return!e&&0!==e}function getNumberOrUndefined(e){return isNumeric(e)?Number(e):void 0}function isArrayOfArrays(e){return!!Array.isArray(e)&&e.every(Array.isArray)}function each(e,t){let s=arguments.length>2&&void 0!==arguments[2]&&arguments[2];let i=0;e[s?"reduceRight":"reduce"](((e,s,a)=>t(s,i++,a)),void 0)}function getMetaData(e,t){const s=Array.isArray(e)?e[t]:safeHasProperty(e,"data")?e.data[t]:null;return safeHasProperty(s,"meta")?s.meta:void 0}function isDataHoleValue(e){return null===e||void 0===e||"number"===typeof e&&isNaN(e)}function isArrayOfSeries(e){return Array.isArray(e)&&e.every((e=>Array.isArray(e)||safeHasProperty(e,"data")))}function isMultiValue(e){return"object"===typeof e&&null!==e&&(Reflect.has(e,"x")||Reflect.has(e,"y"))}function getMultiValue(e){let t=arguments.length>1&&void 0!==arguments[1]?arguments[1]:"y";return isMultiValue(e)&&safeHasProperty(e,t)?getNumberOrUndefined(e[t]):getNumberOrUndefined(e)}
/**
 * Get highest and lowest value of data array. This Array contains the data that will be visualized in the chart.
 * @param data The array that contains the data to be visualized in the chart
 * @param options The Object that contains the chart options
 * @param dimension Axis dimension 'x' or 'y' used to access the correct value and high / low configuration
 * @return An object that contains the highest and lowest value that will be visualized on the chart.
 */function getHighLow(e,t,s){t={...t,...s?"x"===s?t.axisX:t.axisY:{}};const i={high:void 0===t.high?-Number.MAX_VALUE:+t.high,low:void 0===t.low?Number.MAX_VALUE:+t.low};const a=void 0===t.high;const n=void 0===t.low;function recursiveHighLow(e){if(!isDataHoleValue(e))if(Array.isArray(e))for(let t=0;t<e.length;t++)recursiveHighLow(e[t]);else{const t=Number(s&&safeHasProperty(e,s)?e[s]:e);a&&t>i.high&&(i.high=t);n&&t<i.low&&(i.low=t)}}(a||n)&&recursiveHighLow(e);if(t.referenceValue||0===t.referenceValue){i.high=Math.max(t.referenceValue,i.high);i.low=Math.min(t.referenceValue,i.low)}if(i.high<=i.low)if(0===i.low)i.high=1;else if(i.low<0)i.high=0;else if(i.high>0)i.low=0;else{i.high=1;i.low=0}return i}function normalizeData(e){let t=arguments.length>1&&void 0!==arguments[1]&&arguments[1],s=arguments.length>2?arguments[2]:void 0,i=arguments.length>3?arguments[3]:void 0;let a;const n={labels:(e.labels||[]).slice(),series:normalizeSeries(e.series,s,i)};const r=n.labels.length;if(isArrayOfArrays(n.series)){a=Math.max(r,...n.series.map((e=>e.length)));n.series.forEach((e=>{e.push(...times(Math.max(0,a-e.length)))}))}else a=n.series.length;n.labels.push(...times(Math.max(0,a-r),(()=>"")));t&&reverseData(n);return n}function reverseData(e){var t;null===(t=e.labels)||void 0===t?void 0:t.reverse();e.series.reverse();for(const t of e.series)safeHasProperty(t,"data")?t.data.reverse():Array.isArray(t)&&t.reverse()}function normalizeMulti(e,t){let s;let i;if("object"!==typeof e){const a=getNumberOrUndefined(e);"x"===t?s=a:i=a}else{safeHasProperty(e,"x")&&(s=getNumberOrUndefined(e.x));safeHasProperty(e,"y")&&(i=getNumberOrUndefined(e.y))}if(void 0!==s||void 0!==i)return{x:s,y:i}}function normalizePrimitive(e,t){if(!isDataHoleValue(e))return t?normalizeMulti(e,t):getNumberOrUndefined(e)}function normalizeSingleSeries(e,t){return Array.isArray(e)?e.map((e=>safeHasProperty(e,"value")?normalizePrimitive(e.value,t):normalizePrimitive(e,t))):normalizeSingleSeries(e.data,t)}function normalizeSeries(e,t,s){if(isArrayOfSeries(e))return e.map((e=>normalizeSingleSeries(e,t)));const i=normalizeSingleSeries(e,t);return s?i.map((e=>[e])):i}
/**
 * Splits a list of coordinates and associated values into segments. Each returned segment contains a pathCoordinates
 * valueData property describing the segment.
 *
 * With the default options, segments consist of contiguous sets of points that do not have an undefined value. Any
 * points with undefined values are discarded.
 *
 * **Options**
 * The following options are used to determine how segments are formed
 * ```javascript
 * var options = {
 *   // If fillHoles is true, undefined values are simply discarded without creating a new segment. Assuming other options are default, this returns single segment.
 *   fillHoles: false,
 *   // If increasingX is true, the coordinates in all segments have strictly increasing x-values.
 *   increasingX: false
 * };
 * ```
 *
 * @param pathCoordinates List of point coordinates to be split in the form [x1, y1, x2, y2 ... xn, yn]
 * @param valueData List of associated point values in the form [v1, v2 .. vn]
 * @param options Options set by user
 * @return List of segments, each containing a pathCoordinates and valueData property.
 */function splitIntoSegments(e,t,s){const i={increasingX:false,fillHoles:false,...s};const a=[];let n=true;for(let s=0;s<e.length;s+=2)if(void 0===getMultiValue(t[s/2].value))i.fillHoles||(n=true);else{i.increasingX&&s>=2&&e[s]<=e[s-2]&&(n=true);if(n){a.push({pathCoordinates:[],valueData:[]});n=false}a[a.length-1].pathCoordinates.push(e[s],e[s+1]);a[a.length-1].valueData.push(t[s/2])}return a}function serialize(e){let t="";if(null===e||void 0===e)return e;t="number"===typeof e?""+e:"object"===typeof e?JSON.stringify({data:e}):String(e);return Object.keys(i).reduce(((e,t)=>e.replaceAll(t,i[t])),t)}function deserialize(e){if("string"!==typeof e)return e;if("NaN"===e)return NaN;e=Object.keys(i).reduce(((e,t)=>e.replaceAll(i[t],t)),e);let t=e;if("string"===typeof e)try{t=JSON.parse(e);t=void 0!==t.data?t.data:t}catch(e){}return t}class SvgList{call(e,t){this.svgElements.forEach((s=>Reflect.apply(s[e],s,t)));return this}attr(){for(var e=arguments.length,t=new Array(e),s=0;s<e;s++)t[s]=arguments[s];return this.call("attr",t)}elem(){for(var e=arguments.length,t=new Array(e),s=0;s<e;s++)t[s]=arguments[s];return this.call("elem",t)}root(){for(var e=arguments.length,t=new Array(e),s=0;s<e;s++)t[s]=arguments[s];return this.call("root",t)}getNode(){for(var e=arguments.length,t=new Array(e),s=0;s<e;s++)t[s]=arguments[s];return this.call("getNode",t)}foreignObject(){for(var e=arguments.length,t=new Array(e),s=0;s<e;s++)t[s]=arguments[s];return this.call("foreignObject",t)}text(){for(var e=arguments.length,t=new Array(e),s=0;s<e;s++)t[s]=arguments[s];return this.call("text",t)}empty(){for(var e=arguments.length,t=new Array(e),s=0;s<e;s++)t[s]=arguments[s];return this.call("empty",t)}remove(){for(var e=arguments.length,t=new Array(e),s=0;s<e;s++)t[s]=arguments[s];return this.call("remove",t)}addClass(){for(var e=arguments.length,t=new Array(e),s=0;s<e;s++)t[s]=arguments[s];return this.call("addClass",t)}removeClass(){for(var e=arguments.length,t=new Array(e),s=0;s<e;s++)t[s]=arguments[s];return this.call("removeClass",t)}removeAllClasses(){for(var e=arguments.length,t=new Array(e),s=0;s<e;s++)t[s]=arguments[s];return this.call("removeAllClasses",t)}animate(){for(var e=arguments.length,t=new Array(e),s=0;s<e;s++)t[s]=arguments[s];return this.call("animate",t)}
/**
  * @param nodeList An Array of SVG DOM nodes or a SVG DOM NodeList (as returned by document.querySelectorAll)
  */constructor(e){this.svgElements=[];for(let t=0;t<e.length;t++)this.svgElements.push(new Svg(e[t]))}}const n={easeInSine:[.47,0,.745,.715],easeOutSine:[.39,.575,.565,1],easeInOutSine:[.445,.05,.55,.95],easeInQuad:[.55,.085,.68,.53],easeOutQuad:[.25,.46,.45,.94],easeInOutQuad:[.455,.03,.515,.955],easeInCubic:[.55,.055,.675,.19],easeOutCubic:[.215,.61,.355,1],easeInOutCubic:[.645,.045,.355,1],easeInQuart:[.895,.03,.685,.22],easeOutQuart:[.165,.84,.44,1],easeInOutQuart:[.77,0,.175,1],easeInQuint:[.755,.05,.855,.06],easeOutQuint:[.23,1,.32,1],easeInOutQuint:[.86,0,.07,1],easeInExpo:[.95,.05,.795,.035],easeOutExpo:[.19,1,.22,1],easeInOutExpo:[1,0,0,1],easeInCirc:[.6,.04,.98,.335],easeOutCirc:[.075,.82,.165,1],easeInOutCirc:[.785,.135,.15,.86],easeInBack:[.6,-.28,.735,.045],easeOutBack:[.175,.885,.32,1.275],easeInOutBack:[.68,-.55,.265,1.55]};function createAnimation(e,t,s){let i=arguments.length>3&&void 0!==arguments[3]&&arguments[3],a=arguments.length>4?arguments[4]:void 0;const{easing:r,...o}=s;const l={};let c;let h;r&&(c=Array.isArray(r)?r:n[r]);o.begin=ensureUnit(o.begin,"ms");o.dur=ensureUnit(o.dur,"ms");if(c){o.calcMode="spline";o.keySplines=c.join(" ");o.keyTimes="0;1"}if(i){o.fill="freeze";l[t]=o.from;e.attr(l);h=quantity(o.begin||0).value;o.begin="indefinite"}const u=e.elem("animate",{attributeName:t,...o});i&&setTimeout((()=>{try{u._node.beginElement()}catch(s){l[t]=o.to;e.attr(l);u.remove()}}),h);const d=u.getNode();a&&d.addEventListener("beginEvent",(()=>a.emit("animationBegin",{element:e,animate:d,params:s})));d.addEventListener("endEvent",(()=>{a&&a.emit("animationEnd",{element:e,animate:d,params:s});if(i){l[t]=o.to;e.attr(l);u.remove()}}))}class Svg{attr(e,s){if("string"===typeof e)return s?this._node.getAttributeNS(s,e):this._node.getAttribute(e);Object.keys(e).forEach((s=>{if(void 0!==e[s])if(-1!==s.indexOf(":")){const i=s.split(":");this._node.setAttributeNS(t[i[0]],s,String(e[s]))}else this._node.setAttribute(s,String(e[s]))}));return this}
/**
  * Create a new SVG element whose wrapper object will be selected for further operations. This way you can also create nested groups easily.
  * @param name The name of the SVG element that should be created as child element of the currently selected element wrapper
  * @param attributes An object with properties that will be added as attributes to the SVG element that is created. Attributes with undefined values will not be added.
  * @param className This class or class list will be added to the SVG element
  * @param insertFirst If this param is set to true in conjunction with a parent element the newly created element will be added as first child element in the parent element
  * @return Returns a Svg wrapper object that can be used to modify the containing SVG data
  */elem(e,t,s){let i=arguments.length>3&&void 0!==arguments[3]&&arguments[3];return new Svg(e,t,s,this,i)}parent(){return this._node.parentNode instanceof SVGElement?new Svg(this._node.parentNode):null}root(){let e=this._node;while("svg"!==e.nodeName){if(!e.parentElement)break;e=e.parentElement}return new Svg(e)}
/**
  * Find the first child SVG element of the current element that matches a CSS selector. The returned object is a Svg wrapper.
  * @param selector A CSS selector that is used to query for child SVG elements
  * @return The SVG wrapper for the element found or null if no element was found
  */querySelector(e){const t=this._node.querySelector(e);return t?new Svg(t):null}
/**
  * Find the all child SVG elements of the current element that match a CSS selector. The returned object is a Svg.List wrapper.
  * @param selector A CSS selector that is used to query for child SVG elements
  * @return The SVG wrapper list for the element found or null if no element was found
  */querySelectorAll(e){const t=this._node.querySelectorAll(e);return new SvgList(t)}getNode(){return this._node}
/**
  * This method creates a foreignObject (see https://developer.mozilla.org/en-US/docs/Web/SVG/Element/foreignObject) that allows to embed HTML content into a SVG graphic. With the help of foreignObjects you can enable the usage of regular HTML elements inside of SVG where they are subject for SVG positioning and transformation but the Browser will use the HTML rendering capabilities for the containing DOM.
  * @param content The DOM Node, or HTML string that will be converted to a DOM Node, that is then placed into and wrapped by the foreignObject
  * @param attributes An object with properties that will be added as attributes to the foreignObject element that is created. Attributes with undefined values will not be added.
  * @param className This class or class list will be added to the SVG element
  * @param insertFirst Specifies if the foreignObject should be inserted as first child
  * @return New wrapper object that wraps the foreignObject element
  */foreignObject(e,s,i){let a=arguments.length>3&&void 0!==arguments[3]&&arguments[3];let n;if("string"===typeof e){const t=document.createElement("div");t.innerHTML=e;n=t.firstChild}else n=e;n instanceof Element&&n.setAttribute("xmlns",t.xmlns);const r=this.elem("foreignObject",s,i,a);r._node.appendChild(n);return r}
/**
  * This method adds a new text element to the current Svg wrapper.
  * @param t The text that should be added to the text element that is created
  * @return The same wrapper object that was used to add the newly created element
  */text(e){this._node.appendChild(document.createTextNode(e));return this}empty(){while(this._node.firstChild)this._node.removeChild(this._node.firstChild);return this}remove(){var e;null===(e=this._node.parentNode)||void 0===e?void 0:e.removeChild(this._node);return this.parent()}
/**
  * This method will replace the element with a new element that can be created outside of the current DOM.
  * @param newElement The new Svg object that will be used to replace the current wrapper object
  * @return The wrapper of the new element
  */replace(e){var t;null===(t=this._node.parentNode)||void 0===t?void 0:t.replaceChild(e._node,this._node);return e}
/**
  * This method will append an element to the current element as a child.
  * @param element The Svg element that should be added as a child
  * @param insertFirst Specifies if the element should be inserted as first child
  * @return The wrapper of the appended object
  */append(e){let t=arguments.length>1&&void 0!==arguments[1]&&arguments[1];t&&this._node.firstChild?this._node.insertBefore(e._node,this._node.firstChild):this._node.appendChild(e._node);return this}classes(){const e=this._node.getAttribute("class");return e?e.trim().split(/\s+/):[]}
/**
  * Adds one or a space separated list of classes to the current element and ensures the classes are only existing once.
  * @param names A white space separated list of class names
  * @return The wrapper of the current element
  */addClass(e){this._node.setAttribute("class",this.classes().concat(e.trim().split(/\s+/)).filter((function(e,t,s){return s.indexOf(e)===t})).join(" "));return this}
/**
  * Removes one or a space separated list of classes from the current element.
  * @param names A white space separated list of class names
  * @return The wrapper of the current element
  */removeClass(e){const t=e.trim().split(/\s+/);this._node.setAttribute("class",this.classes().filter((e=>-1===t.indexOf(e))).join(" "));return this}removeAllClasses(){this._node.setAttribute("class","");return this}height(){return this._node.getBoundingClientRect().height}width(){return this._node.getBoundingClientRect().width}
/**
  * The animate function lets you animate the current element with SMIL animations. You can add animations for multiple attributes at the same time by using an animation definition object. This object should contain SMIL animation attributes. Please refer to http://www.w3.org/TR/SVG/animate.html for a detailed specification about the available animation attributes. Additionally an easing property can be passed in the animation definition object. This can be a string with a name of an easing function in `Svg.Easing` or an array with four numbers specifying a cubic Bézier curve.
  * **An animations object could look like this:**
  * ```javascript
  * element.animate({
  *   opacity: {
  *     dur: 1000,
  *     from: 0,
  *     to: 1
  *   },
  *   x1: {
  *     dur: '1000ms',
  *     from: 100,
  *     to: 200,
  *     easing: 'easeOutQuart'
  *   },
  *   y1: {
  *     dur: '2s',
  *     from: 0,
  *     to: 100
  *   }
  * });
  * ```
  * **Automatic unit conversion**
  * For the `dur` and the `begin` animate attribute you can also omit a unit by passing a number. The number will automatically be converted to milli seconds.
  * **Guided mode**
  * The default behavior of SMIL animations with offset using the `begin` attribute is that the attribute will keep it's original value until the animation starts. Mostly this behavior is not desired as you'd like to have your element attributes already initialized with the animation `from` value even before the animation starts. Also if you don't specify `fill="freeze"` on an animate element or if you delete the animation after it's done (which is done in guided mode) the attribute will switch back to the initial value. This behavior is also not desired when performing simple one-time animations. For one-time animations you'd want to trigger animations immediately instead of relative to the document begin time. That's why in guided mode Svg will also use the `begin` property to schedule a timeout and manually start the animation after the timeout. If you're using multiple SMIL definition objects for an attribute (in an array), guided mode will be disabled for this attribute, even if you explicitly enabled it.
  * If guided mode is enabled the following behavior is added:
  * - Before the animation starts (even when delayed with `begin`) the animated attribute will be set already to the `from` value of the animation
  * - `begin` is explicitly set to `indefinite` so it can be started manually without relying on document begin time (creation)
  * - The animate element will be forced to use `fill="freeze"`
  * - The animation will be triggered with `beginElement()` in a timeout where `begin` of the definition object is interpreted in milli seconds. If no `begin` was specified the timeout is triggered immediately.
  * - After the animation the element attribute value will be set to the `to` value of the animation
  * - The animate element is deleted from the DOM
  * @param animations An animations object where the property keys are the attributes you'd like to animate. The properties should be objects again that contain the SMIL animation attributes (usually begin, dur, from, and to). The property begin and dur is auto converted (see Automatic unit conversion). You can also schedule multiple animations for the same attribute by passing an Array of SMIL definition objects. Attributes that contain an array of SMIL definition objects will not be executed in guided mode.
  * @param guided Specify if guided mode should be activated for this animation (see Guided mode). If not otherwise specified, guided mode will be activated.
  * @param eventEmitter If specified, this event emitter will be notified when an animation starts or ends.
  * @return The current element where the animation was added
  */animate(e){let t=!(arguments.length>1&&void 0!==arguments[1])||arguments[1],s=arguments.length>2?arguments[2]:void 0;Object.keys(e).forEach((i=>{const a=e[i];Array.isArray(a)?a.forEach((e=>createAnimation(this,i,e,false,s))):createAnimation(this,i,a,t,s)}));return this}
/**
  * @param name The name of the SVG element to create or an SVG dom element which should be wrapped into Svg
  * @param attributes An object with properties that will be added as attributes to the SVG element that is created. Attributes with undefined values will not be added.
  * @param className This class or class list will be added to the SVG element
  * @param parent The parent SVG wrapper object where this newly created wrapper and it's element will be attached to as child
  * @param insertFirst If this param is set to true in conjunction with a parent element the newly created element will be added as first child element in the parent element
  */constructor(e,s,i,a,n=false){if(e instanceof Element)this._node=e;else{this._node=document.createElementNS(t.svg,e);"svg"===e&&this.attr({"xmlns:ct":t.ct})}s&&this.attr(s);i&&this.addClass(i);a&&(n&&a._node.firstChild?a._node.insertBefore(this._node,a._node.firstChild):a._node.appendChild(this._node))}}
/**
   * @todo Only there for chartist <1 compatibility. Remove after deprecation warining.
   * @deprecated Use the animation module export `easings` directly.
   */Svg.Easing=n;
/**
 * Create or reinitialize the SVG element for the chart
 * @param container The containing DOM Node object that will be used to plant the SVG element
 * @param width Set the width of the SVG element. Default is 100%
 * @param height Set the height of the SVG element. Default is 100%
 * @param className Specify a class to be added to the SVG element
 * @return The created/reinitialized SVG element
 */function createSvg(e){let s=arguments.length>1&&void 0!==arguments[1]?arguments[1]:"100%",i=arguments.length>2&&void 0!==arguments[2]?arguments[2]:"100%",a=arguments.length>3?arguments[3]:void 0;Array.from(e.querySelectorAll("svg")).filter((e=>e.getAttributeNS(t.xmlns,"ct"))).forEach((t=>e.removeChild(t)));const n=new Svg("svg").attr({width:s,height:i}).attr({style:"width: ".concat(s,"; height: ").concat(i,";")});a&&n.addClass(a);e.appendChild(n.getNode());return n}
/**
 * Converts a number into a padding object.
 * @param padding
 * @param fallback This value is used to fill missing values if a incomplete padding object was passed
 * @returns Returns a padding object containing top, right, bottom, left properties filled with the padding number passed in as argument. If the argument is something else than a number (presumably already a correct padding object) then this argument is directly returned.
 */function normalizePadding(e){return"number"===typeof e?{top:e,right:e,bottom:e,left:e}:void 0===e?{top:0,right:0,bottom:0,left:0}:{top:"number"===typeof e.top?e.top:0,right:"number"===typeof e.right?e.right:0,bottom:"number"===typeof e.bottom?e.bottom:0,left:"number"===typeof e.left?e.left:0}}
/**
 * Initialize chart drawing rectangle (area where chart is drawn) x1,y1 = bottom left / x2,y2 = top right
 * @param svg The svg element for the chart
 * @param options The Object that contains all the optional values for the chart
 * @return The chart rectangles coordinates inside the svg element plus the rectangles measurements
 */function createChartRect(e,t){var s,i,a,n;const r=Boolean(t.axisX||t.axisY);const o=(null===(s=t.axisY)||void 0===s?void 0:s.offset)||0;const l=(null===(i=t.axisX)||void 0===i?void 0:i.offset)||0;const c=null===(a=t.axisY)||void 0===a?void 0:a.position;const h=null===(n=t.axisX)||void 0===n?void 0:n.position;let u=e.width()||quantity(t.width).value||0;let d=e.height()||quantity(t.height).value||0;const m=normalizePadding(t.chartPadding);u=Math.max(u,o+m.left+m.right);d=Math.max(d,l+m.top+m.bottom);const p={x1:0,x2:0,y1:0,y2:0,padding:m,width(){return this.x2-this.x1},height(){return this.y1-this.y2}};if(r){if("start"===h){p.y2=m.top+l;p.y1=Math.max(d-m.bottom,p.y2+1)}else{p.y2=m.top;p.y1=Math.max(d-m.bottom-l,p.y2+1)}if("start"===c){p.x1=m.left+o;p.x2=Math.max(u-m.right,p.x1+1)}else{p.x1=m.left;p.x2=Math.max(u-m.right-o,p.x1+1)}}else{p.x1=m.left;p.x2=Math.max(u-m.right,p.x1+1);p.y2=m.top;p.y1=Math.max(d-m.bottom,p.y2+1)}return p}function createGrid(e,t,s,i,a,n,r,o){const l={["".concat(s.units.pos,"1")]:e,["".concat(s.units.pos,"2")]:e,["".concat(s.counterUnits.pos,"1")]:i,["".concat(s.counterUnits.pos,"2")]:i+a};const c=n.elem("line",l,r.join(" "));o.emit("draw",{type:"grid",axis:s,index:t,group:n,element:c,...l})}function createGridBackground(e,t,s,i){const a=e.elem("rect",{x:t.x1,y:t.y2,width:t.width(),height:t.height()},s,true);i.emit("draw",{type:"gridBackground",group:e,element:a})}function createLabel(e,t,s,i,a,n,r,o,l,c){const h={[a.units.pos]:e+r[a.units.pos],[a.counterUnits.pos]:r[a.counterUnits.pos],[a.units.len]:t,[a.counterUnits.len]:Math.max(0,n-10)};const u=Math.round(h[a.units.len]);const d=Math.round(h[a.counterUnits.len]);const m=document.createElement("span");m.className=l.join(" ");m.style[a.units.len]=u+"px";m.style[a.counterUnits.len]=d+"px";m.textContent=String(i);const p=o.foreignObject(m,{style:"overflow: visible;",...h});c.emit("draw",{type:"label",axis:a,index:s,group:o,element:p,text:i,...h})}
/**
 * Provides options handling functionality with callback for options changes triggered by responsive options and media query matches
 * @param options Options set by user
 * @param responsiveOptions Optional functions to add responsive behavior to chart
 * @param eventEmitter The event emitter that will be used to emit the options changed events
 * @return The consolidated options object from the defaults, base and matching responsive options
 */function optionsProvider(e,t,s){let i;const a=[];function updateCurrentOptions(a){const n=i;i=extend({},e);t&&t.forEach((e=>{const t=window.matchMedia(e[0]);t.matches&&(i=extend(i,e[1]))}));s&&a&&s.emit("optionsChanged",{previousOptions:n,currentOptions:i})}function removeMediaQueryListeners(){a.forEach((e=>e.removeEventListener("change",updateCurrentOptions)))}if(!window.matchMedia)throw new Error("window.matchMedia not found! Make sure you're using a polyfill.");t&&t.forEach((e=>{const t=window.matchMedia(e[0]);t.addEventListener("change",updateCurrentOptions);a.push(t)}));updateCurrentOptions();return{removeMediaQueryListeners:removeMediaQueryListeners,getCurrentOptions(){return i}}}const r={m:["x","y"],l:["x","y"],c:["x1","y1","x2","y2","x","y"],a:["rx","ry","xAr","lAf","sf","x","y"]};const o={accuracy:3};function element(e,t,s,i,a,n){const r={command:a?e.toLowerCase():e.toUpperCase(),...t,...n?{data:n}:{}};s.splice(i,0,r)}function forEachParam(e,t){e.forEach(((s,i)=>{r[s.command.toLowerCase()].forEach(((a,n)=>{t(s,a,i,n,e)}))}))}class SvgPath{
/**
  * This static function on `SvgPath` is joining multiple paths together into one paths.
  * @param paths A list of paths to be joined together. The order is important.
  * @param close If the newly created path should be a closed path
  * @param options Path options for the newly created path.
  */
static join(e){let t=arguments.length>1&&void 0!==arguments[1]&&arguments[1],s=arguments.length>2?arguments[2]:void 0;const i=new SvgPath(t,s);for(let t=0;t<e.length;t++){const s=e[t];for(let e=0;e<s.pathElements.length;e++)i.pathElements.push(s.pathElements[e])}return i}position(e){if(void 0!==e){this.pos=Math.max(0,Math.min(this.pathElements.length,e));return this}return this.pos}
/**
  * Removes elements from the path starting at the current position.
  * @param count Number of path elements that should be removed from the current position.
  * @return The current path object for easy call chaining.
  */remove(e){this.pathElements.splice(this.pos,e);return this}
/**
  * Use this function to add a new move SVG path element.
  * @param x The x coordinate for the move element.
  * @param y The y coordinate for the move element.
  * @param relative If set to true the move element will be created with relative coordinates (lowercase letter)
  * @param data Any data that should be stored with the element object that will be accessible in pathElement
  * @return The current path object for easy call chaining.
  */move(e,t){let s=arguments.length>2&&void 0!==arguments[2]&&arguments[2],i=arguments.length>3?arguments[3]:void 0;element("M",{x:+e,y:+t},this.pathElements,this.pos++,s,i);return this}
/**
  * Use this function to add a new line SVG path element.
  * @param x The x coordinate for the line element.
  * @param y The y coordinate for the line element.
  * @param relative If set to true the line element will be created with relative coordinates (lowercase letter)
  * @param data Any data that should be stored with the element object that will be accessible in pathElement
  * @return The current path object for easy call chaining.
  */line(e,t){let s=arguments.length>2&&void 0!==arguments[2]&&arguments[2],i=arguments.length>3?arguments[3]:void 0;element("L",{x:+e,y:+t},this.pathElements,this.pos++,s,i);return this}
/**
  * Use this function to add a new curve SVG path element.
  * @param x1 The x coordinate for the first control point of the bezier curve.
  * @param y1 The y coordinate for the first control point of the bezier curve.
  * @param x2 The x coordinate for the second control point of the bezier curve.
  * @param y2 The y coordinate for the second control point of the bezier curve.
  * @param x The x coordinate for the target point of the curve element.
  * @param y The y coordinate for the target point of the curve element.
  * @param relative If set to true the curve element will be created with relative coordinates (lowercase letter)
  * @param data Any data that should be stored with the element object that will be accessible in pathElement
  * @return The current path object for easy call chaining.
  */curve(e,t,s,i,a,n){let r=arguments.length>6&&void 0!==arguments[6]&&arguments[6],o=arguments.length>7?arguments[7]:void 0;element("C",{x1:+e,y1:+t,x2:+s,y2:+i,x:+a,y:+n},this.pathElements,this.pos++,r,o);return this}
/**
  * Use this function to add a new non-bezier curve SVG path element.
  * @param rx The radius to be used for the x-axis of the arc.
  * @param ry The radius to be used for the y-axis of the arc.
  * @param xAr Defines the orientation of the arc
  * @param lAf Large arc flag
  * @param sf Sweep flag
  * @param x The x coordinate for the target point of the curve element.
  * @param y The y coordinate for the target point of the curve element.
  * @param relative If set to true the curve element will be created with relative coordinates (lowercase letter)
  * @param data Any data that should be stored with the element object that will be accessible in pathElement
  * @return The current path object for easy call chaining.
  */arc(e,t,s,i,a,n,r){let o=arguments.length>7&&void 0!==arguments[7]&&arguments[7],l=arguments.length>8?arguments[8]:void 0;element("A",{rx:e,ry:t,xAr:s,lAf:i,sf:a,x:n,y:r},this.pathElements,this.pos++,o,l);return this}
/**
  * Parses an SVG path seen in the d attribute of path elements, and inserts the parsed elements into the existing path object at the current cursor position. Any closing path indicators (Z at the end of the path) will be ignored by the parser as this is provided by the close option in the options of the path object.
  * @param path Any SVG path that contains move (m), line (l) or curve (c) components.
  * @return The current path object for easy call chaining.
  */parse(e){const t=e.replace(/([A-Za-z])(-?[0-9])/g,"$1 $2").replace(/([0-9])([A-Za-z])/g,"$1 $2").split(/[\s,]+/).reduce(((e,t)=>{t.match(/[A-Za-z]/)&&e.push([]);e[e.length-1].push(t);return e}),[]);"Z"===t[t.length-1][0].toUpperCase()&&t.pop();const s=t.map((e=>{const t=e.shift();const s=r[t.toLowerCase()];return{command:t,...s.reduce(((t,s,i)=>{t[s]=+e[i];return t}),{})}}));this.pathElements.splice(this.pos,0,...s);this.pos+=s.length;return this}stringify(){const e=Math.pow(10,this.options.accuracy);return this.pathElements.reduce(((t,s)=>{const i=r[s.command.toLowerCase()].map((t=>{const i=s[t];return this.options.accuracy?Math.round(i*e)/e:i}));return t+s.command+i.join(",")}),"")+(this.close?"Z":"")}
/**
  * Scales all elements in the current SVG path object. There is an individual parameter for each coordinate. Scaling will also be done for control points of curves, affecting the given coordinate.
  * @param x The number which will be used to scale the x, x1 and x2 of all path elements.
  * @param y The number which will be used to scale the y, y1 and y2 of all path elements.
  * @return The current path object for easy call chaining.
  */scale(e,t){forEachParam(this.pathElements,((s,i)=>{s[i]*="x"===i[0]?e:t}));return this}
/**
  * Translates all elements in the current SVG path object. The translation is relative and there is an individual parameter for each coordinate. Translation will also be done for control points of curves, affecting the given coordinate.
  * @param x The number which will be used to translate the x, x1 and x2 of all path elements.
  * @param y The number which will be used to translate the y, y1 and y2 of all path elements.
  * @return The current path object for easy call chaining.
  */translate(e,t){forEachParam(this.pathElements,((s,i)=>{s[i]+="x"===i[0]?e:t}));return this}
/**
  * This function will run over all existing path elements and then loop over their attributes. The callback function will be called for every path element attribute that exists in the current path.
  * The method signature of the callback function looks like this:
  * ```javascript
  * function(pathElement, paramName, pathElementIndex, paramIndex, pathElements)
  * ```
  * If something else than undefined is returned by the callback function, this value will be used to replace the old value. This allows you to build custom transformations of path objects that can't be achieved using the basic transformation functions scale and translate.
  * @param transformFnc The callback function for the transformation. Check the signature in the function description.
  * @return The current path object for easy call chaining.
  */transform(e){forEachParam(this.pathElements,((t,s,i,a,n)=>{const r=e(t,s,i,a,n);(r||0===r)&&(t[s]=r)}));return this}
/**
  * This function clones a whole path object with all its properties. This is a deep clone and path element objects will also be cloned.
  * @param close Optional option to set the new cloned path to closed. If not specified or false, the original path close option will be used.
  */clone(){let e=arguments.length>0&&void 0!==arguments[0]&&arguments[0];const t=new SvgPath(e||this.close);t.pos=this.pos;t.pathElements=this.pathElements.slice().map((e=>({...e})));t.options={...this.options};return t}
/**
  * Split a Svg.Path object by a specific command in the path chain. The path chain will be split and an array of newly created paths objects will be returned. This is useful if you'd like to split an SVG path by it's move commands, for example, in order to isolate chunks of drawings.
  * @param command The command you'd like to use to split the path
  */splitByCommand(e){const t=[new SvgPath];this.pathElements.forEach((s=>{s.command===e.toUpperCase()&&0!==t[t.length-1].pathElements.length&&t.push(new SvgPath);t[t.length-1].pathElements.push(s)}));return t}
/**
  * Used to construct a new path object.
  * @param close If set to true then this path will be closed when stringified (with a Z at the end)
  * @param options Options object that overrides the default objects. See default options for more details.
  */constructor(e=false,t){this.close=e;this.pathElements=[];this.pos=0;this.options={...o,...t}}}function none(e){const t={fillHoles:false,...e};return function noneInterpolation(e,s){const i=new SvgPath;let a=true;for(let n=0;n<e.length;n+=2){const r=e[n];const o=e[n+1];const l=s[n/2];if(void 0!==getMultiValue(l.value)){a?i.move(r,o,false,l):i.line(r,o,false,l);a=false}else t.fillHoles||(a=true)}return i}}
/**
 * Simple smoothing creates horizontal handles that are positioned with a fraction of the length between two data points. You can use the divisor option to specify the amount of smoothing.
 *
 * Simple smoothing can be used instead of `Chartist.Smoothing.cardinal` if you'd like to get rid of the artifacts it produces sometimes. Simple smoothing produces less flowing lines but is accurate by hitting the points and it also doesn't swing below or above the given data point.
 *
 * All smoothing functions within Chartist are factory functions that accept an options parameter. The simple interpolation function accepts one configuration parameter `divisor`, between 1 and ∞, which controls the smoothing characteristics.
 *
 * @example
 * ```ts
 * const chart = new LineChart('.ct-chart', {
 *   labels: [1, 2, 3, 4, 5],
 *   series: [[1, 2, 8, 1, 7]]
 * }, {
 *   lineSmooth: Interpolation.simple({
 *     divisor: 2,
 *     fillHoles: false
 *   })
 * });
 * ```
 *
 * @param options The options of the simple interpolation factory function.
 */function simple(e){const t={divisor:2,fillHoles:false,...e};const s=1/Math.max(1,t.divisor);return function simpleInterpolation(e,i){const a=new SvgPath;let n=0;let r=0;let o;for(let l=0;l<e.length;l+=2){const c=e[l];const h=e[l+1];const u=(c-n)*s;const d=i[l/2];if(void 0!==d.value){void 0===o?a.move(c,h,false,d):a.curve(n+u,r,c-u,h,c,h,false,d);n=c;r=h;o=d}else if(!t.fillHoles){n=r=0;o=void 0}}return a}}function step(e){const t={postpone:true,fillHoles:false,...e};return function stepInterpolation(e,s){const i=new SvgPath;let a=0;let n=0;let r;for(let o=0;o<e.length;o+=2){const l=e[o];const c=e[o+1];const h=s[o/2];if(void 0!==h.value){if(void 0===r)i.move(l,c,false,h);else{t.postpone?i.line(l,n,false,r):i.line(a,c,false,h);i.line(l,c,false,h)}a=l;n=c;r=h}else if(!t.fillHoles){a=n=0;r=void 0}}return i}}
/**
 * Cardinal / Catmull-Rome spline interpolation is the default smoothing function in Chartist. It produces nice results where the splines will always meet the points. It produces some artifacts though when data values are increased or decreased rapidly. The line may not follow a very accurate path and if the line should be accurate this smoothing function does not produce the best results.
 *
 * Cardinal splines can only be created if there are more than two data points. If this is not the case this smoothing will fallback to `Chartist.Smoothing.none`.
 *
 * All smoothing functions within Chartist are factory functions that accept an options parameter. The cardinal interpolation function accepts one configuration parameter `tension`, between 0 and 1, which controls the smoothing intensity.
 *
 * @example
 * ```ts
 * const chart = new LineChart('.ct-chart', {
 *   labels: [1, 2, 3, 4, 5],
 *   series: [[1, 2, 8, 1, 7]]
 * }, {
 *   lineSmooth: Interpolation.cardinal({
 *     tension: 1,
 *     fillHoles: false
 *   })
 * });
 * ```
 *
 * @param options The options of the cardinal factory function.
 */function cardinal(e){const t={tension:1,fillHoles:false,...e};const s=Math.min(1,Math.max(0,t.tension));const i=1-s;return function cardinalInterpolation(e,a){const n=splitIntoSegments(e,a,{fillHoles:t.fillHoles});if(n.length){if(n.length>1)return SvgPath.join(n.map((e=>cardinalInterpolation(e.pathCoordinates,e.valueData))));{e=n[0].pathCoordinates;a=n[0].valueData;if(e.length<=4)return none()(e,a);const t=(new SvgPath).move(e[0],e[1],false,a[0]);const r=false;for(let n=0,o=e.length;o-2*Number(!r)>n;n+=2){const r=[{x:+e[n-2],y:+e[n-1]},{x:+e[n],y:+e[n+1]},{x:+e[n+2],y:+e[n+3]},{x:+e[n+4],y:+e[n+5]}];o-4===n?r[3]=r[2]:n||(r[0]={x:+e[n],y:+e[n+1]});t.curve(s*(-r[0].x+6*r[1].x+r[2].x)/6+i*r[2].x,s*(-r[0].y+6*r[1].y+r[2].y)/6+i*r[2].y,s*(r[1].x+6*r[2].x-r[3].x)/6+i*r[2].x,s*(r[1].y+6*r[2].y-r[3].y)/6+i*r[2].y,r[2].x,r[2].y,false,a[(n+2)/2])}return t}}return none()([],[])}}
/**
 * Monotone Cubic spline interpolation produces a smooth curve which preserves monotonicity. Unlike cardinal splines, the curve will not extend beyond the range of y-values of the original data points.
 *
 * Monotone Cubic splines can only be created if there are more than two data points. If this is not the case this smoothing will fallback to `Chartist.Smoothing.none`.
 *
 * The x-values of subsequent points must be increasing to fit a Monotone Cubic spline. If this condition is not met for a pair of adjacent points, then there will be a break in the curve between those data points.
 *
 * All smoothing functions within Chartist are factory functions that accept an options parameter.
 *
 * @example
 * ```ts
 * const chart = new LineChart('.ct-chart', {
 *   labels: [1, 2, 3, 4, 5],
 *   series: [[1, 2, 8, 1, 7]]
 * }, {
 *   lineSmooth: Interpolation.monotoneCubic({
 *     fillHoles: false
 *   })
 * });
 * ```
 *
 * @param options The options of the monotoneCubic factory function.
 */function monotoneCubic(e){const t={fillHoles:false,...e};return function monotoneCubicInterpolation(e,s){const i=splitIntoSegments(e,s,{fillHoles:t.fillHoles,increasingX:true});if(i.length){if(i.length>1)return SvgPath.join(i.map((e=>monotoneCubicInterpolation(e.pathCoordinates,e.valueData))));{e=i[0].pathCoordinates;s=i[0].valueData;if(e.length<=4)return none()(e,s);const t=[];const a=[];const n=e.length/2;const r=[];const o=[];const l=[];const c=[];for(let s=0;s<n;s++){t[s]=e[2*s];a[s]=e[2*s+1]}for(let e=0;e<n-1;e++){l[e]=a[e+1]-a[e];c[e]=t[e+1]-t[e];o[e]=l[e]/c[e]}r[0]=o[0];r[n-1]=o[n-2];for(let e=1;e<n-1;e++)if(0===o[e]||0===o[e-1]||o[e-1]>0!==o[e]>0)r[e]=0;else{r[e]=3*(c[e-1]+c[e])/((2*c[e]+c[e-1])/o[e-1]+(c[e]+2*c[e-1])/o[e]);isFinite(r[e])||(r[e]=0)}const h=(new SvgPath).move(t[0],a[0],false,s[0]);for(let e=0;e<n-1;e++)h.curve(t[e]+c[e]/3,a[e]+r[e]*c[e]/3,t[e+1]-c[e]/3,a[e+1]-r[e+1]*c[e]/3,t[e+1],a[e+1],false,s[e+1]);return h}}return none()([],[])}}var l=Object.freeze({__proto__:null,none:none,simple:simple,step:step,cardinal:cardinal,monotoneCubic:monotoneCubic});class EventEmitter{on(e,t){const{allListeners:s,listeners:i}=this;if("*"===e)s.add(t);else{i.has(e)||i.set(e,new Set);i.get(e).add(t)}}off(e,t){const{allListeners:s,listeners:i}=this;if("*"===e)t?s.delete(t):s.clear();else if(i.has(e)){const s=i.get(e);t?s.delete(t):s.clear();s.size||i.delete(e)}}
/**
  * Use this function to emit an event. All handlers that are listening for this event will be triggered with the data parameter.
  * @param event The event name that should be triggered
  * @param data Arbitrary data that will be passed to the event handler callback functions
  */emit(e,t){const{allListeners:s,listeners:i}=this;i.has(e)&&i.get(e).forEach((e=>e(t)));s.forEach((s=>s(e,t)))}constructor(){this.listeners=new Map;this.allListeners=new Set}}const c=new WeakMap;class BaseChart{
/**
  * Updates the chart which currently does a full reconstruction of the SVG DOM
  * @param data Optional data you'd like to set for the chart before it will update. If not specified the update method will use the data that is already configured with the chart.
  * @param options Optional options you'd like to add to the previous options for the chart before it will update. If not specified the update method will use the options that have been already configured with the chart.
  * @param override If set to true, the passed options will be used to extend the options that have been configured already. Otherwise the chart default options will be used as the base
  */
update(e,t){let s=arguments.length>2&&void 0!==arguments[2]&&arguments[2];if(e){this.data=e||{};this.data.labels=this.data.labels||[];this.data.series=this.data.series||[];this.eventEmitter.emit("data",{type:"update",data:this.data})}if(t){this.options=extend({},s?this.options:this.defaultOptions,t);if(!this.initializeTimeoutId){var i;null===(i=this.optionsProvider)||void 0===i?void 0:i.removeMediaQueryListeners();this.optionsProvider=optionsProvider(this.options,this.responsiveOptions,this.eventEmitter)}}!this.initializeTimeoutId&&this.optionsProvider&&this.createChart(this.optionsProvider.getCurrentOptions());return this}detach(){if(this.initializeTimeoutId)window.clearTimeout(this.initializeTimeoutId);else{var e;window.removeEventListener("resize",this.resizeListener);null===(e=this.optionsProvider)||void 0===e?void 0:e.removeMediaQueryListeners()}c.delete(this.container);return this}on(e,t){this.eventEmitter.on(e,t);return this}off(e,t){this.eventEmitter.off(e,t);return this}initialize(){window.addEventListener("resize",this.resizeListener);this.optionsProvider=optionsProvider(this.options,this.responsiveOptions,this.eventEmitter);this.eventEmitter.on("optionsChanged",(()=>this.update()));this.options.plugins&&this.options.plugins.forEach((e=>{Array.isArray(e)?e[0](this,e[1]):e(this)}));this.eventEmitter.emit("data",{type:"initial",data:this.data});this.createChart(this.optionsProvider.getCurrentOptions());this.initializeTimeoutId=null}constructor(e,t,s,i,a){this.data=t;this.defaultOptions=s;this.options=i;this.responsiveOptions=a;this.eventEmitter=new EventEmitter;this.resizeListener=()=>this.update();this.initializeTimeoutId=setTimeout((()=>this.initialize()),0);const n="string"===typeof e?document.querySelector(e):e;if(!n)throw new Error("Target element is not found");this.container=n;const r=c.get(n);r&&r.detach();c.set(n,this)}}const h={x:{pos:"x",len:"width",dir:"horizontal",rectStart:"x1",rectEnd:"x2",rectOffset:"y2"},y:{pos:"y",len:"height",dir:"vertical",rectStart:"y2",rectEnd:"y1",rectOffset:"x1"}};class Axis{createGridAndLabels(e,t,s,i){const a="x"===this.units.pos?s.axisX:s.axisY;const n=this.ticks.map(((e,t)=>this.projectValue(e,t)));const r=this.ticks.map(a.labelInterpolationFnc);n.forEach(((o,l)=>{const c=r[l];const h={x:0,y:0};let u;u=n[l+1]?n[l+1]-o:Math.max(this.axisLength-o,this.axisLength/this.ticks.length);if(""===c||!isFalseyButZero(c)){if("x"===this.units.pos){o=this.chartRect.x1+o;h.x=s.axisX.labelOffset.x;"start"===s.axisX.position?h.y=this.chartRect.padding.top+s.axisX.labelOffset.y+5:h.y=this.chartRect.y1+s.axisX.labelOffset.y+5}else{o=this.chartRect.y1-o;h.y=s.axisY.labelOffset.y-u;"start"===s.axisY.position?h.x=this.chartRect.padding.left+s.axisY.labelOffset.x:h.x=this.chartRect.x2+s.axisY.labelOffset.x+10}a.showGrid&&createGrid(o,l,this,this.gridOffset,this.chartRect[this.counterUnits.len](),e,[s.classNames.grid,s.classNames[this.units.dir]],i);a.showLabel&&createLabel(o,u,l,c,this,a.offset,h,t,[s.classNames.label,s.classNames[this.units.dir],"start"===a.position?s.classNames[a.position]:s.classNames.end],i)}}))}constructor(e,t,s){this.units=e;this.chartRect=t;this.ticks=s;this.counterUnits=e===h.x?h.y:h.x;this.axisLength=t[this.units.rectEnd]-t[this.units.rectStart];this.gridOffset=t[this.units.rectOffset]}}class AutoScaleAxis extends Axis{projectValue(e){const t=Number(getMultiValue(e,this.units.pos));return this.axisLength*(t-this.bounds.min)/this.bounds.range}constructor(e,t,s,i){const a=i.highLow||getHighLow(t,i,e.pos);const n=getBounds(s[e.rectEnd]-s[e.rectStart],a,i.scaleMinSpace||20,i.onlyInteger);const r={min:n.min,max:n.max};super(e,s,n.values);this.bounds=n;this.range=r}}class FixedScaleAxis extends Axis{projectValue(e){const t=Number(getMultiValue(e,this.units.pos));return this.axisLength*(t-this.range.min)/(this.range.max-this.range.min)}constructor(e,t,s,i){const a=i.highLow||getHighLow(t,i,e.pos);const n=i.divisor||1;const r=(i.ticks||times(n,(e=>a.low+(a.high-a.low)/n*e))).sort(((e,t)=>Number(e)-Number(t)));const o={min:a.low,max:a.high};super(e,s,r);this.range=o}}class StepAxis extends Axis{projectValue(e,t){return this.stepLength*t}constructor(e,t,s,i){const a=i.ticks||[];super(e,s,a);const n=Math.max(1,a.length-(i.stretch?1:0));this.stepLength=this.axisLength/n;this.stretch=Boolean(i.stretch)}}function getSeriesOption(e,t,s){var i;if(safeHasProperty(e,"name")&&e.name&&(null===(i=t.series)||void 0===i?void 0:i[e.name])){const i=null===t||void 0===t?void 0:t.series[e.name];const a=i[s];const n=void 0===a?t[s]:a;return n}return t[s]}const u={axisX:{offset:30,position:"end",labelOffset:{x:0,y:0},showLabel:true,showGrid:true,labelInterpolationFnc:noop,type:void 0},axisY:{offset:40,position:"start",labelOffset:{x:0,y:0},showLabel:true,showGrid:true,labelInterpolationFnc:noop,type:void 0,scaleMinSpace:20,onlyInteger:false},width:void 0,height:void 0,showLine:true,showPoint:true,showArea:false,areaBase:0,lineSmooth:true,showGridBackground:false,low:void 0,high:void 0,chartPadding:{top:15,right:15,bottom:5,left:10},fullWidth:false,reverseData:false,classNames:{chart:"ct-chart-line",label:"ct-label",labelGroup:"ct-labels",series:"ct-series",line:"ct-line",point:"ct-point",area:"ct-area",grid:"ct-grid",gridGroup:"ct-grids",gridBackground:"ct-grid-background",vertical:"ct-vertical",horizontal:"ct-horizontal",start:"ct-start",end:"ct-end"}};class LineChart extends BaseChart{createChart(e){const{data:t}=this;const s=normalizeData(t,e.reverseData,true);const i=createSvg(this.container,e.width,e.height,e.classNames.chart);this.svg=i;const a=i.elem("g").addClass(e.classNames.gridGroup);const n=i.elem("g");const r=i.elem("g").addClass(e.classNames.labelGroup);const o=createChartRect(i,e);let l;let c;l=void 0===e.axisX.type?new StepAxis(h.x,s.series,o,{...e.axisX,ticks:s.labels,stretch:e.fullWidth}):new e.axisX.type(h.x,s.series,o,e.axisX);c=void 0===e.axisY.type?new AutoScaleAxis(h.y,s.series,o,{...e.axisY,high:isNumeric(e.high)?e.high:e.axisY.high,low:isNumeric(e.low)?e.low:e.axisY.low}):new e.axisY.type(h.y,s.series,o,e.axisY);l.createGridAndLabels(a,r,e,this.eventEmitter);c.createGridAndLabels(a,r,e,this.eventEmitter);e.showGridBackground&&createGridBackground(a,o,e.classNames.gridBackground,this.eventEmitter);each(t.series,((t,i)=>{const a=n.elem("g");const r=safeHasProperty(t,"name")&&t.name;const h=safeHasProperty(t,"className")&&t.className;const u=safeHasProperty(t,"meta")?t.meta:void 0;r&&a.attr({"ct:series-name":r});u&&a.attr({"ct:meta":serialize(u)});a.addClass([e.classNames.series,h||"".concat(e.classNames.series,"-").concat(alphaNumerate(i))].join(" "));const d=[];const m=[];s.series[i].forEach(((e,a)=>{const n={x:o.x1+l.projectValue(e,a,s.series[i]),y:o.y1-c.projectValue(e,a,s.series[i])};d.push(n.x,n.y);m.push({value:e,valueIndex:a,meta:getMetaData(t,a)})}));const p={lineSmooth:getSeriesOption(t,e,"lineSmooth"),showPoint:getSeriesOption(t,e,"showPoint"),showLine:getSeriesOption(t,e,"showLine"),showArea:getSeriesOption(t,e,"showArea"),areaBase:getSeriesOption(t,e,"areaBase")};let g;g="function"===typeof p.lineSmooth?p.lineSmooth:p.lineSmooth?monotoneCubic():none();const v=g(d,m);p.showPoint&&v.pathElements.forEach((s=>{const{data:n}=s;const r=a.elem("line",{x1:s.x,y1:s.y,x2:s.x+.01,y2:s.y},e.classNames.point);if(n){let e;let t;safeHasProperty(n.value,"x")&&(e=n.value.x);safeHasProperty(n.value,"y")&&(t=n.value.y);r.attr({"ct:value":[e,t].filter(isNumeric).join(","),"ct:meta":serialize(n.meta)})}this.eventEmitter.emit("draw",{type:"point",value:null===n||void 0===n?void 0:n.value,index:(null===n||void 0===n?void 0:n.valueIndex)||0,meta:null===n||void 0===n?void 0:n.meta,series:t,seriesIndex:i,axisX:l,axisY:c,group:a,element:r,x:s.x,y:s.y,chartRect:o})}));if(p.showLine){const n=a.elem("path",{d:v.stringify()},e.classNames.line,true);this.eventEmitter.emit("draw",{type:"line",values:s.series[i],path:v.clone(),chartRect:o,index:i,series:t,seriesIndex:i,meta:u,axisX:l,axisY:c,group:a,element:n})}if(p.showArea&&c.range){const n=Math.max(Math.min(p.areaBase,c.range.max),c.range.min);const r=o.y1-c.projectValue(n);v.splitByCommand("M").filter((e=>e.pathElements.length>1)).map((e=>{const t=e.pathElements[0];const s=e.pathElements[e.pathElements.length-1];return e.clone(true).position(0).remove(1).move(t.x,r).line(t.x,t.y).position(e.pathElements.length+1).line(s.x,r)})).forEach((n=>{const r=a.elem("path",{d:n.stringify()},e.classNames.area,true);this.eventEmitter.emit("draw",{type:"area",values:s.series[i],path:n.clone(),series:t,seriesIndex:i,axisX:l,axisY:c,chartRect:o,index:i,group:a,element:r,meta:u})}))}}),e.reverseData);this.eventEmitter.emit("created",{chartRect:o,axisX:l,axisY:c,svg:i,options:e})}
/**
  * This method creates a new line chart.
  * @param query A selector query string or directly a DOM element
  * @param data The data object that needs to consist of a labels and a series array
  * @param options The options object with options that override the default options. Check the examples for a detailed list.
  * @param responsiveOptions Specify an array of responsive option arrays which are a media query and options object pair => [[mediaQueryString, optionsObject],[more...]]
  * @return An object which exposes the API for the created chart
  *
  * @example
  * ```ts
  * // Create a simple line chart
  * const data = {
  *   // A labels array that can contain any sort of values
  *   labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
  *   // Our series array that contains series objects or in this case series data arrays
  *   series: [
  *     [5, 2, 4, 2, 0]
  *   ]
  * };
  *
  * // As options we currently only set a static size of 300x200 px
  * const options = {
  *   width: '300px',
  *   height: '200px'
  * };
  *
  * // In the global name space Chartist we call the Line function to initialize a line chart. As a first parameter we pass in a selector where we would like to get our chart created. Second parameter is the actual data object and as a third parameter we pass in our options
  * new LineChart('.ct-chart', data, options);
  * ```
  *
  * @example
  * ```ts
  * // Use specific interpolation function with configuration from the Chartist.Interpolation module
  *
  * const chart = new LineChart('.ct-chart', {
  *   labels: [1, 2, 3, 4, 5],
  *   series: [
  *     [1, 1, 8, 1, 7]
  *   ]
  * }, {
  *   lineSmooth: Chartist.Interpolation.cardinal({
  *     tension: 0.2
  *   })
  * });
  * ```
  *
  * @example
  * ```ts
  * // Create a line chart with responsive options
  *
  * const data = {
  *   // A labels array that can contain any sort of values
  *   labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
  *   // Our series array that contains series objects or in this case series data arrays
  *   series: [
  *     [5, 2, 4, 2, 0]
  *   ]
  * };
  *
  * // In addition to the regular options we specify responsive option overrides that will override the default configutation based on the matching media queries.
  * const responsiveOptions = [
  *   ['screen and (min-width: 641px) and (max-width: 1024px)', {
  *     showPoint: false,
  *     axisX: {
  *       labelInterpolationFnc: function(value) {
  *         // Will return Mon, Tue, Wed etc. on medium screens
  *         return value.slice(0, 3);
  *       }
  *     }
  *   }],
  *   ['screen and (max-width: 640px)', {
  *     showLine: false,
  *     axisX: {
  *       labelInterpolationFnc: function(value) {
  *         // Will return M, T, W etc. on small screens
  *         return value[0];
  *       }
  *     }
  *   }]
  * ];
  *
  * new LineChart('.ct-chart', data, null, responsiveOptions);
  * ```
  */constructor(e,t,s,i){super(e,t,u,extend({},u,s),i);this.data=t}}function getSerialSums(e){return serialMap(e,(function(){for(var e=arguments.length,t=new Array(e),s=0;s<e;s++)t[s]=arguments[s];return Array.from(t).reduce(((e,t)=>({x:e.x+(safeHasProperty(t,"x")?t.x:0),y:e.y+(safeHasProperty(t,"y")?t.y:0)})),{x:0,y:0})}))}const d={axisX:{offset:30,position:"end",labelOffset:{x:0,y:0},showLabel:true,showGrid:true,labelInterpolationFnc:noop,scaleMinSpace:30,onlyInteger:false},axisY:{offset:40,position:"start",labelOffset:{x:0,y:0},showLabel:true,showGrid:true,labelInterpolationFnc:noop,scaleMinSpace:20,onlyInteger:false},width:void 0,height:void 0,high:void 0,low:void 0,referenceValue:0,chartPadding:{top:15,right:15,bottom:5,left:10},seriesBarDistance:15,stackBars:false,stackMode:"accumulate",horizontalBars:false,distributeSeries:false,reverseData:false,showGridBackground:false,classNames:{chart:"ct-chart-bar",horizontalBars:"ct-horizontal-bars",label:"ct-label",labelGroup:"ct-labels",series:"ct-series",bar:"ct-bar",grid:"ct-grid",gridGroup:"ct-grids",gridBackground:"ct-grid-background",vertical:"ct-vertical",horizontal:"ct-horizontal",start:"ct-start",end:"ct-end"}};class BarChart extends BaseChart{createChart(e){const{data:t}=this;const s=normalizeData(t,e.reverseData,e.horizontalBars?"x":"y",true);const i=createSvg(this.container,e.width,e.height,e.classNames.chart+(e.horizontalBars?" "+e.classNames.horizontalBars:""));const a=e.stackBars&&true!==e.stackMode&&s.series.length?getHighLow([getSerialSums(s.series)],e,e.horizontalBars?"x":"y"):getHighLow(s.series,e,e.horizontalBars?"x":"y");this.svg=i;const n=i.elem("g").addClass(e.classNames.gridGroup);const r=i.elem("g");const o=i.elem("g").addClass(e.classNames.labelGroup);"number"===typeof e.high&&(a.high=e.high);"number"===typeof e.low&&(a.low=e.low);const l=createChartRect(i,e);let c;const u=e.distributeSeries&&e.stackBars?s.labels.slice(0,1):s.labels;let d;let m;let p;if(e.horizontalBars){c=m=void 0===e.axisX.type?new AutoScaleAxis(h.x,s.series,l,{...e.axisX,highLow:a,referenceValue:0}):new e.axisX.type(h.x,s.series,l,{...e.axisX,highLow:a,referenceValue:0});d=p=void 0===e.axisY.type?new StepAxis(h.y,s.series,l,{ticks:u}):new e.axisY.type(h.y,s.series,l,e.axisY)}else{d=m=void 0===e.axisX.type?new StepAxis(h.x,s.series,l,{ticks:u}):new e.axisX.type(h.x,s.series,l,e.axisX);c=p=void 0===e.axisY.type?new AutoScaleAxis(h.y,s.series,l,{...e.axisY,highLow:a,referenceValue:0}):new e.axisY.type(h.y,s.series,l,{...e.axisY,highLow:a,referenceValue:0})}const g=e.horizontalBars?l.x1+c.projectValue(0):l.y1-c.projectValue(0);const v="accumulate"===e.stackMode;const x="accumulate-relative"===e.stackMode;const y=[];const w=[];let b=y;d.createGridAndLabels(n,o,e,this.eventEmitter);c.createGridAndLabels(n,o,e,this.eventEmitter);e.showGridBackground&&createGridBackground(n,l,e.classNames.gridBackground,this.eventEmitter);each(t.series,((i,a)=>{const n=a-(t.series.length-1)/2;let o;o=e.distributeSeries&&!e.stackBars?d.axisLength/s.series.length/2:e.distributeSeries&&e.stackBars?d.axisLength/2:d.axisLength/s.series[a].length/2;const h=r.elem("g");const u=safeHasProperty(i,"name")&&i.name;const S=safeHasProperty(i,"className")&&i.className;const A=safeHasProperty(i,"meta")?i.meta:void 0;u&&h.attr({"ct:series-name":u});A&&h.attr({"ct:meta":serialize(A)});h.addClass([e.classNames.series,S||"".concat(e.classNames.series,"-").concat(alphaNumerate(a))].join(" "));s.series[a].forEach(((t,r)=>{const u=safeHasProperty(t,"x")&&t.x;const S=safeHasProperty(t,"y")&&t.y;let A;A=e.distributeSeries&&!e.stackBars?a:e.distributeSeries&&e.stackBars?0:r;let E;E=e.horizontalBars?{x:l.x1+c.projectValue(u||0,r,s.series[a]),y:l.y1-d.projectValue(S||0,A,s.series[a])}:{x:l.x1+d.projectValue(u||0,A,s.series[a]),y:l.y1-c.projectValue(S||0,r,s.series[a])};if(d instanceof StepAxis){d.stretch||(E[d.units.pos]+=o*(e.horizontalBars?-1:1));E[d.units.pos]+=e.stackBars||e.distributeSeries?0:n*e.seriesBarDistance*(e.horizontalBars?-1:1)}x&&(b=S>=0||u>=0?y:w);const C=b[r]||g;b[r]=C-(g-E[d.counterUnits.pos]);if(void 0===t)return;const M={["".concat(d.units.pos,"1")]:E[d.units.pos],["".concat(d.units.pos,"2")]:E[d.units.pos]};if(e.stackBars&&(v||x||!e.stackMode)){M["".concat(d.counterUnits.pos,"1")]=C;M["".concat(d.counterUnits.pos,"2")]=b[r]}else{M["".concat(d.counterUnits.pos,"1")]=g;M["".concat(d.counterUnits.pos,"2")]=E[d.counterUnits.pos]}M.x1=Math.min(Math.max(M.x1,l.x1),l.x2);M.x2=Math.min(Math.max(M.x2,l.x1),l.x2);M.y1=Math.min(Math.max(M.y1,l.y2),l.y1);M.y2=Math.min(Math.max(M.y2,l.y2),l.y1);const P=getMetaData(i,r);const N=h.elem("line",M,e.classNames.bar).attr({"ct:value":[u,S].filter(isNumeric).join(","),"ct:meta":serialize(P)});this.eventEmitter.emit("draw",{type:"bar",value:t,index:r,meta:P,series:i,seriesIndex:a,axisX:m,axisY:p,chartRect:l,group:h,element:N,...M})}))}),e.reverseData);this.eventEmitter.emit("created",{chartRect:l,axisX:m,axisY:p,svg:i,options:e})}
/**
  * This method creates a new bar chart and returns API object that you can use for later changes.
  * @param query A selector query string or directly a DOM element
  * @param data The data object that needs to consist of a labels and a series array
  * @param options The options object with options that override the default options. Check the examples for a detailed list.
  * @param responsiveOptions Specify an array of responsive option arrays which are a media query and options object pair => [[mediaQueryString, optionsObject],[more...]]
  * @return An object which exposes the API for the created chart
  *
  * @example
  * ```ts
  * // Create a simple bar chart
  * const data = {
  *   labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
  *   series: [
  *     [5, 2, 4, 2, 0]
  *   ]
  * };
  *
  * // In the global name space Chartist we call the Bar function to initialize a bar chart. As a first parameter we pass in a selector where we would like to get our chart created and as a second parameter we pass our data object.
  * new BarChart('.ct-chart', data);
  * ```
  *
  * @example
  * ```ts
  * // This example creates a bipolar grouped bar chart where the boundaries are limitted to -10 and 10
  * new BarChart('.ct-chart', {
  *   labels: [1, 2, 3, 4, 5, 6, 7],
  *   series: [
  *     [1, 3, 2, -5, -3, 1, -6],
  *     [-5, -2, -4, -1, 2, -3, 1]
  *   ]
  * }, {
  *   seriesBarDistance: 12,
  *   low: -10,
  *   high: 10
  * });
  * ```
  */constructor(e,t,s,i){super(e,t,d,extend({},d,s),i);this.data=t}}const m={width:void 0,height:void 0,chartPadding:5,classNames:{chartPie:"ct-chart-pie",chartDonut:"ct-chart-donut",series:"ct-series",slicePie:"ct-slice-pie",sliceDonut:"ct-slice-donut",label:"ct-label"},startAngle:0,total:void 0,donut:false,donutWidth:60,showLabel:true,labelOffset:0,labelPosition:"inside",labelInterpolationFnc:noop,labelDirection:"neutral",ignoreEmptyValues:false};function determineAnchorPosition(e,t,s){const i=t.x>e.x;return i&&"explode"===s||!i&&"implode"===s?"start":i&&"implode"===s||!i&&"explode"===s?"end":"middle"}class PieChart extends BaseChart{
/**
  * Creates the pie chart
  *
  * @param options
  */
createChart(e){const{data:t}=this;const s=normalizeData(t);const i=[];let a;let n;let r=e.startAngle;const o=createSvg(this.container,e.width,e.height,e.donut?e.classNames.chartDonut:e.classNames.chartPie);this.svg=o;const l=createChartRect(o,e);let c=Math.min(l.width()/2,l.height()/2);const h=e.total||s.series.reduce(sum,0);const u=quantity(e.donutWidth);"%"===u.unit&&(u.value*=c/100);c-=e.donut?u.value/2:0;n="outside"===e.labelPosition||e.donut?c:"center"===e.labelPosition?0:c/2;e.labelOffset&&(n+=e.labelOffset);const d={x:l.x1+l.width()/2,y:l.y2+l.height()/2};const m=1===t.series.filter((e=>safeHasProperty(e,"value")?0!==e.value:0!==e)).length;t.series.forEach(((e,t)=>i[t]=o.elem("g")));e.showLabel&&(a=o.elem("g"));t.series.forEach(((o,p)=>{var g,v;if(0===s.series[p]&&e.ignoreEmptyValues)return;const x=safeHasProperty(o,"name")&&o.name;const y=safeHasProperty(o,"className")&&o.className;const w=safeHasProperty(o,"meta")?o.meta:void 0;x&&i[p].attr({"ct:series-name":x});i[p].addClass([null===(g=e.classNames)||void 0===g?void 0:g.series,y||"".concat(null===(v=e.classNames)||void 0===v?void 0:v.series,"-").concat(alphaNumerate(p))].join(" "));let b=h>0?r+s.series[p]/h*360:0;const S=Math.max(0,r-(0===p||m?0:.2));b-S>=359.99&&(b=S+359.99);const A=polarToCartesian(d.x,d.y,c,S);const E=polarToCartesian(d.x,d.y,c,b);const C=new SvgPath(!e.donut).move(E.x,E.y).arc(c,c,0,Number(b-r>180),0,A.x,A.y);e.donut||C.line(d.x,d.y);const M=i[p].elem("path",{d:C.stringify()},e.donut?e.classNames.sliceDonut:e.classNames.slicePie);M.attr({"ct:value":s.series[p],"ct:meta":serialize(w)});e.donut&&M.attr({style:"stroke-width: "+u.value+"px"});this.eventEmitter.emit("draw",{type:"slice",value:s.series[p],totalDataSum:h,index:p,meta:w,series:o,group:i[p],element:M,path:C.clone(),center:d,radius:c,startAngle:r,endAngle:b,chartRect:l});if(e.showLabel){let i;i=1===t.series.length?{x:d.x,y:d.y}:polarToCartesian(d.x,d.y,n,r+(b-r)/2);let c;c=s.labels&&!isFalseyButZero(s.labels[p])?s.labels[p]:s.series[p];const h=e.labelInterpolationFnc(c,p);if(h||0===h){const t=a.elem("text",{dx:i.x,dy:i.y,"text-anchor":determineAnchorPosition(d,i,e.labelDirection)},e.classNames.label).text(String(h));this.eventEmitter.emit("draw",{type:"label",index:p,group:a,element:t,text:""+h,chartRect:l,series:o,meta:w,...i})}}r=b}));this.eventEmitter.emit("created",{chartRect:l,svg:o,options:e})}
/**
  * This method creates a new pie chart and returns an object that can be used to redraw the chart.
  * @param query A selector query string or directly a DOM element
  * @param data The data object in the pie chart needs to have a series property with a one dimensional data array. The values will be normalized against each other and don't necessarily need to be in percentage. The series property can also be an array of value objects that contain a value property and a className property to override the CSS class name for the series group.
  * @param options The options object with options that override the default options. Check the examples for a detailed list.
  * @param responsiveOptions Specify an array of responsive option arrays which are a media query and options object pair => [[mediaQueryString, optionsObject],[more...]]
  *
  * @example
  * ```ts
  * // Simple pie chart example with four series
  * new PieChart('.ct-chart', {
  *   series: [10, 2, 4, 3]
  * });
  * ```
  *
  * @example
  * ```ts
  * // Drawing a donut chart
  * new PieChart('.ct-chart', {
  *   series: [10, 2, 4, 3]
  * }, {
  *   donut: true
  * });
  * ```
  *
  * @example
  * ```ts
  * // Using donut, startAngle and total to draw a gauge chart
  * new PieChart('.ct-chart', {
  *   series: [20, 10, 30, 40]
  * }, {
  *   donut: true,
  *   donutWidth: 20,
  *   startAngle: 270,
  *   total: 200
  * });
  * ```
  *
  * @example
  * ```ts
  * // Drawing a pie chart with padding and labels that are outside the pie
  * new PieChart('.ct-chart', {
  *   series: [20, 10, 30, 40]
  * }, {
  *   chartPadding: 30,
  *   labelOffset: 50,
  *   labelDirection: 'explode'
  * });
  * ```
  *
  * @example
  * ```ts
  * // Overriding the class names for individual series as well as a name and meta data.
  * // The name will be written as ct:series-name attribute and the meta data will be serialized and written
  * // to a ct:meta attribute.
  * new PieChart('.ct-chart', {
  *   series: [{
  *     value: 20,
  *     name: 'Series 1',
  *     className: 'my-custom-class-one',
  *     meta: 'Meta One'
  *   }, {
  *     value: 10,
  *     name: 'Series 2',
  *     className: 'my-custom-class-two',
  *     meta: 'Meta Two'
  *   }, {
  *     value: 70,
  *     name: 'Series 3',
  *     className: 'my-custom-class-three',
  *     meta: 'Meta Three'
  *   }]
  * });
  * ```
  */constructor(e,t,s,i){super(e,t,m,extend({},m,s),i);this.data=t}}e.AutoScaleAxis=AutoScaleAxis;e.Axis=Axis;e.BarChart=BarChart;e.BaseChart=BaseChart;e.EPSILON=a;e.EventEmitter=EventEmitter;e.FixedScaleAxis=FixedScaleAxis;e.Interpolation=l;e.LineChart=LineChart;e.PieChart=PieChart;e.StepAxis=StepAxis;e.Svg=Svg;e.SvgList=SvgList;e.SvgPath=SvgPath;e.alphaNumerate=alphaNumerate;e.axisUnits=h;e.createChartRect=createChartRect;e.createGrid=createGrid;e.createGridBackground=createGridBackground;e.createLabel=createLabel;e.createSvg=createSvg;e.deserialize=deserialize;e.determineAnchorPosition=determineAnchorPosition;e.each=each;e.easings=n;e.ensureUnit=ensureUnit;e.escapingMap=i;e.extend=extend;e.getBounds=getBounds;e.getHighLow=getHighLow;e.getMetaData=getMetaData;e.getMultiValue=getMultiValue;e.getNumberOrUndefined=getNumberOrUndefined;e.getSeriesOption=getSeriesOption;e.isArrayOfArrays=isArrayOfArrays;e.isArrayOfSeries=isArrayOfSeries;e.isDataHoleValue=isDataHoleValue;e.isFalseyButZero=isFalseyButZero;e.isMultiValue=isMultiValue;e.isNumeric=isNumeric;e.namespaces=t;e.noop=noop;e.normalizeData=normalizeData;e.normalizePadding=normalizePadding;e.optionsProvider=optionsProvider;e.orderOfMagnitude=orderOfMagnitude;e.polarToCartesian=polarToCartesian;e.precision=s;e.projectLength=projectLength;e.quantity=quantity;e.rho=rho;e.roundWithPrecision=roundWithPrecision;e.safeHasProperty=safeHasProperty;e.serialMap=serialMap;e.serialize=serialize;e.splitIntoSegments=splitIntoSegments;e.sum=sum;e.times=times;const p=e.__esModule,g=e.Interpolation;const v=e.AutoScaleAxis,x=e.Axis,y=e.BarChart,w=e.BaseChart,b=e.EPSILON,S=e.EventEmitter,A=e.FixedScaleAxis,E=e.LineChart,C=e.PieChart,M=e.StepAxis,P=e.Svg,N=e.SvgList,O=e.SvgPath,L=e.alphaNumerate,B=e.axisUnits,z=e.createChartRect,H=e.createGrid,I=e.createGridBackground,k=e.createLabel,j=e.createSvg,_=e.deserialize,V=e.determineAnchorPosition,D=e.each,U=e.easings,G=e.ensureUnit,R=e.escapingMap,X=e.extend,Y=e.getBounds,F=e.getHighLow,T=e.getMetaData,q=e.getMultiValue,Q=e.getNumberOrUndefined,Z=e.getSeriesOption,W=e.isArrayOfArrays,$=e.isArrayOfSeries,J=e.isDataHoleValue,K=e.isFalseyButZero,ee=e.isMultiValue,te=e.isNumeric,se=e.namespaces,ie=e.noop,ae=e.normalizeData,ne=e.normalizePadding,re=e.optionsProvider,oe=e.orderOfMagnitude,le=e.polarToCartesian,ce=e.precision,he=e.projectLength,ue=e.quantity,de=e.rho,me=e.roundWithPrecision,pe=e.safeHasProperty,ge=e.serialMap,fe=e.serialize,ve=e.splitIntoSegments,xe=e.sum,ye=e.times;export{v as AutoScaleAxis,x as Axis,y as BarChart,w as BaseChart,b as EPSILON,S as EventEmitter,A as FixedScaleAxis,g as Interpolation,E as LineChart,C as PieChart,M as StepAxis,P as Svg,N as SvgList,O as SvgPath,p as __esModule,L as alphaNumerate,B as axisUnits,z as createChartRect,H as createGrid,I as createGridBackground,k as createLabel,j as createSvg,e as default,_ as deserialize,V as determineAnchorPosition,D as each,U as easings,G as ensureUnit,R as escapingMap,X as extend,Y as getBounds,F as getHighLow,T as getMetaData,q as getMultiValue,Q as getNumberOrUndefined,Z as getSeriesOption,W as isArrayOfArrays,$ as isArrayOfSeries,J as isDataHoleValue,K as isFalseyButZero,ee as isMultiValue,te as isNumeric,se as namespaces,ie as noop,ae as normalizeData,ne as normalizePadding,re as optionsProvider,oe as orderOfMagnitude,le as polarToCartesian,ce as precision,he as projectLength,ue as quantity,de as rho,me as roundWithPrecision,pe as safeHasProperty,ge as serialMap,fe as serialize,ve as splitIntoSegments,xe as sum,ye as times};

