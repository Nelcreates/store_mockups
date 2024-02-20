Array.prototype.filter||(Array.prototype.filter=function(t,e){"use strict";if("Function"!=typeof t&&"function"!=typeof t||!this)throw new TypeError;var r=this.length>>>0,o=new Array(r),n=this,l=0,i=-1;if(void 0===e)for(;++i!==r;)i in this&&t(n[i],i,n)&&(o[l++]=n[i]);else for(;++i!==r;)i in this&&t.call(e,n[i],i,n)&&(o[l++]=n[i]);return o.length=l,o}),Array.prototype.forEach||(Array.prototype.forEach=function(t){var e,r;if(null==this)throw new TypeError('"this" is null or not defined');var o=Object(this),n=o.length>>>0;if("function"!=typeof t)throw new TypeError(t+" is not a function");for(arguments.length>1&&(e=arguments[1]),r=0;r<n;){var l;r in o&&(l=o[r],t.call(e,l,r,o)),r++}}),window.NodeList&&!NodeList.prototype.forEach&&(NodeList.prototype.forEach=Array.prototype.forEach),Array.prototype.indexOf||(Array.prototype.indexOf=function(t,e){var r;if(null==this)throw new TypeError('"this" is null or not defined');var o=Object(this),n=o.length>>>0;if(0===n)return-1;var l=0|e;if(l>=n)return-1;for(r=Math.max(l>=0?l:n-Math.abs(l),0);r<n;){if(r in o&&o[r]===t)return r;r++}return-1}),document.getElementsByClassName||(document.getElementsByClassName=function(t){var e,r,o,n=document,l=[];if(n.querySelectorAll)return n.querySelectorAll("."+t);if(n.evaluate)for(r=".//*[contains(concat(' ', @class, ' '), ' "+t+" ')]",e=n.evaluate(r,n,null,0,null);o=e.iterateNext();)l.push(o);else for(e=n.getElementsByTagName("*"),r=new RegExp("(^|\\s)"+t+"(\\s|$)"),o=0;o<e.length;o++)r.test(e[o].className)&&l.push(e[o]);return l}),document.querySelectorAll||(document.querySelectorAll=function(t){var e,r=document.createElement("style"),o=[];for(document.documentElement.firstChild.appendChild(r),document._qsa=[],r.styleSheet.cssText=t+"{x-qsa:expression(document._qsa && document._qsa.push(this))}",window.scrollBy(0,0),r.parentNode.removeChild(r);document._qsa.length;)(e=document._qsa.shift()).style.removeAttribute("x-qsa"),o.push(e);return document._qsa=null,o}),document.querySelector||(document.querySelector=function(t){var e=document.querySelectorAll(t);return e.length?e[0]:null}),Object.keys||(Object.keys=function(){"use strict";var t=Object.prototype.hasOwnProperty,e=!{toString:null}.propertyIsEnumerable("toString"),r=["toString","toLocaleString","valueOf","hasOwnProperty","isPrototypeOf","propertyIsEnumerable","constructor"],o=r.length;return function(n){if("function"!=typeof n&&("object"!=typeof n||null===n))throw new TypeError("Object.keys called on non-object");var l,i,s=[];for(l in n)t.call(n,l)&&s.push(l);if(e)for(i=0;i<o;i++)t.call(n,r[i])&&s.push(r[i]);return s}}()),"function"!=typeof String.prototype.trim&&(String.prototype.trim=function(){return this.replace(/^\s+|\s+$/g,"")}),String.prototype.replaceAll||(String.prototype.replaceAll=function(t,e){return"[object regexp]"===Object.prototype.toString.call(t).toLowerCase()?this.replace(t,e):this.replace(new RegExp(t,"g"),e)}),window.hasOwnProperty=window.hasOwnProperty||Object.prototype.hasOwnProperty;
if (typeof usi_commons === 'undefined') {
	usi_commons = {
		
		debug: location.href.indexOf("usidebug") != -1 || location.href.indexOf("usi_debug") != -1,
		
		log:function(msg) {
			if (usi_commons.debug) {
				try {
					if (msg instanceof Error) {
						console.log(msg.name + ': ' + msg.message);
					} else {
						console.log.apply(console, arguments);
					}
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_error: function(msg) {
			if (usi_commons.debug) {
				try {
					if (msg instanceof Error) {
						console.log('%c USI Error:', usi_commons.log_styles.error, msg.name + ': ' + msg.message);
					} else {
						console.log('%c USI Error:', usi_commons.log_styles.error, msg);
					}
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_success: function(msg) {
			if (usi_commons.debug) {
				try {
					console.log('%c USI Success:', usi_commons.log_styles.success, msg);
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		dir:function(obj) {
			if (usi_commons.debug) {
				try {
					console.dir(obj);
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_styles: {
			error: 'color: red; font-weight: bold;',
			success: 'color: green; font-weight: bold;'
		},
		domain: "https://app.upsellit.com",
		cdn: "https://www.upsellit.com",
		is_mobile: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()),
		device: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()) ? 'mobile' : 'desktop',
		gup:function(name) {
			try {
				name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
				var regexS = "[\\?&]" + name + "=([^&#\\?]*)";
				var regex = new RegExp(regexS);
				var results = regex.exec(window.location.href);
				if (results == null) return "";
				else return results[1];
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_script:function(source, callback, nocache) {
			try {
				if (source.indexOf("//www.upsellit.com") == 0) source = "https:"+source; //upgrade non-secure requests
				var docHead = document.getElementsByTagName("head")[0];
				if (top.location != location) docHead = parent.document.getElementsByTagName("head")[0];
				var newScript = document.createElement('script');
				newScript.type = 'text/javascript';
				var usi_appender = "";
				if (!nocache && source.indexOf("/active/") == -1 && source.indexOf("_pixel.jsp") == -1 && source.indexOf("_throttle.jsp") == -1 && source.indexOf("metro") == -1 && source.indexOf("_suppress") == -1 && source.indexOf("product_recommendations.jsp") == -1 && source.indexOf("_pid.jsp") == -1 && source.indexOf("_zips") == -1) {
					usi_appender = (source.indexOf("?")==-1?"?":"&");
					if (source.indexOf("pv2.js") != -1) usi_appender = "%7C";
					usi_appender += "si=" + usi_commons.get_sess();
				}
				newScript.src = source + usi_appender;
				if (typeof callback == "function") {
					newScript.onload = function() {
						try {
							callback();
						} catch (e) {
							usi_commons.report_error(e);
						}
					};
				}
				docHead.appendChild(newScript);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_display:function(usiQS, usiSiteID, usiKey, callback) {
			try {
				usiKey = usiKey || "";
				var source = usi_commons.domain + "/launch.jsp?qs=" + usiQS + "&siteID=" + usiSiteID + "&keys=" + usiKey;
				usi_commons.load_script(source, callback);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_view:function(usiHash, usiSiteID, usiKey, callback) {
			try {
				if (typeof(usi_force) != "undefined" || location.href.indexOf("usi_force") != -1 || (usi_cookies.get("usi_sale") == null && usi_cookies.get("usi_launched") == null && usi_cookies.get("usi_launched"+usiSiteID) == null)) {
					usiKey = usiKey || "";
					var usi_append = "";
					if (usi_commons.gup("usi_force_date") != "") usi_append = "&usi_force_date=" + usi_commons.gup("usi_force_date");
					else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) usi_append = "&usi_force_date=" + usi_cookies.get("usi_force_date");
					if (usi_commons.debug) usi_append += "&usi_referrer="+encodeURIComponent(location.href);
					var source = usi_commons.domain + "/view.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + usi_append;
					if (typeof(usi_commons.last_view) !== "undefined" && usi_commons.last_view == usiSiteID+"_"+usiKey) return;
					usi_commons.last_view = usiSiteID+"_"+usiKey;
					if (typeof usi_js !== 'undefined' && typeof usi_js.cleanup === 'function') usi_js.cleanup();
					usi_commons.load_script(source, callback);
				}
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		remove_loads:function() {
			try {
				if (document.getElementById("usi_obj") != null) {
					document.getElementById("usi_obj").parentNode.parentNode.removeChild(document.getElementById("usi_obj").parentNode);
				}
				if (typeof(usi_commons.usi_loads) !== "undefined") {
					for (var i in usi_commons.usi_loads) {
						if (document.getElementById("usi_"+i) != null) {
							document.getElementById("usi_"+i).parentNode.parentNode.removeChild(document.getElementById("usi_"+i).parentNode);
						}
					}
				}
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load:function(usiHash, usiSiteID, usiKey, callback){
			try {
				if (typeof(window["usi_" + usiSiteID]) !== "undefined") return;
				usiKey = usiKey || "";
				var usi_append = "";
				if (usi_commons.gup("usi_force_date") != "") usi_append = "&usi_force_date=" + usi_commons.gup("usi_force_date");
				else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) usi_append = "&usi_force_date=" + usi_cookies.get("usi_force_date");
				if (usi_commons.debug) usi_append += "&usi_referrer="+encodeURIComponent(location.href);
				var source = usi_commons.domain + "/usi_load.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + usi_append;
				usi_commons.load_script(source, callback);
				if (typeof(usi_commons.usi_loads) === "undefined") {
					usi_commons.usi_loads = {};
				}
				usi_commons.usi_loads[usiSiteID] = usiSiteID;
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_precapture:function(usiQS, usiSiteID, callback) {
			try {
				if (typeof(usi_commons.last_precapture_siteID) !== "undefined" && usi_commons.last_precapture_siteID == usiSiteID) return;
				usi_commons.last_precapture_siteID = usiSiteID;
				var source = usi_commons.domain + "/hound/monitor.jsp?qs=" + usiQS + "&siteID=" + usiSiteID;
				usi_commons.load_script(source, callback);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_mail:function(qs, siteID, callback) {
			try {
				var source = usi_commons.domain + "/mail.jsp?qs=" + qs + "&siteID=" + siteID + "&domain=" + encodeURIComponent(usi_commons.domain);
				usi_commons.load_script(source, callback);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_products:function(options) {
			try {
				if (!options.siteID || !options.pid) return;
				var queryStr = "";
				var params = ['siteID', 'association_siteID', 'pid', 'less_expensive', 'rows', 'days_back', 'force_exact', 'match', 'nomatch', 'name_from', 'image_from', 'price_from', 'url_from', 'extra_from', 'custom_callback', 'allow_dupe_names', 'expire_seconds', 'name'];
				params.forEach(function(name, index){
					if (options[name]) {
						queryStr += (index == 0 ? "?" : "&") + name + '=' + options[name];
					}
				});
				if (options.filters) {
					queryStr += "&filters=" + encodeURIComponent(options.filters.join("&"));
				}
				usi_commons.load_script(usi_commons.cdn + '/utility/product_recommendations_filter.jsp' + queryStr, function(){
					if (typeof options.callback === 'function') {
						options.callback();
					}
				});
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		send_prod_rec:function(siteID, info, real_time) {
			var result = false;
			try {
				if (document.getElementsByTagName("html").length > 0 && document.getElementsByTagName("html")[0].className != null && document.getElementsByTagName("html")[0].className.indexOf("translated") != -1) {
					//Ignore translated pages
					return false;
				}
				var data = [siteID, info.name, info.link, info.pid, info.price, info.image];
				if (data.indexOf(undefined) == -1) {
					var queryString = [siteID, info.name.replace(/\|/g, "&#124;"), info.link, info.pid, info.price, info.image].join("|") + "|";
					if (info.extra) queryString += info.extra + "|";
					var filetype = real_time ? "jsp" : "js";
					usi_commons.load_script(usi_commons.domain + "/utility/pv2." + filetype + "?" + encodeURIComponent(queryString));
					result = true;
				}
			} catch (e) {
				usi_commons.report_error(e);
				result = false;
			}
			return result;
		},
		report_error:function(err) {
			if (err == null) return;
			if (typeof err === 'string') err = new Error(err);
			if (!(err instanceof Error)) return;
			if (typeof(usi_commons.error_reported) !== "undefined") {
				return;
			}
			usi_commons.error_reported = true;
			if (location.href.indexOf('usishowerrors') !== -1) throw err;
			else usi_commons.load_script(usi_commons.domain + '/err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack) + "&url=" + encodeURIComponent(location.href));
			usi_commons.log_error(err.message);
			usi_commons.dir(err);
		},
		report_error_no_console:function(err) {
			if (err == null) return;
			if (typeof err === 'string') err = new Error(err);
			if (!(err instanceof Error)) return;
			if (typeof(usi_commons.error_reported) !== "undefined") {
				return;
			}
			usi_commons.error_reported = true;
			if (location.href.indexOf('usishowerrors') !== -1) throw err;
			else usi_commons.load_script(usi_commons.domain + '/err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack) + "&url=" + encodeURIComponent(location.href));
		},
		gup_or_get_cookie: function(name, expireSeconds, forceCookie) {
			try {
				if (typeof usi_cookies === 'undefined') {
					usi_commons.log_error('usi_cookies is not defined');
					return;
				}
				expireSeconds = (expireSeconds || usi_cookies.expire_time.day);
				if (name == "usi_enable") expireSeconds = usi_cookies.expire_time.hour;
				var value = null;
				var qsValue = usi_commons.gup(name);
				if (qsValue !== '') {
					value = qsValue;
					usi_cookies.set(name, value, expireSeconds, forceCookie);
				} else {
					value = usi_cookies.get(name);
				}
				return (value || '');
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		get_sess: function() {
			var usi_si = null;
			if (typeof(usi_cookies) === "undefined") return "";
			try {
				if (usi_cookies.get('usi_si') == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_si = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_si', usi_si, 24*60*60);
					return usi_si;
				}
				if (usi_cookies.get('usi_si') != null) usi_si = usi_cookies.get('usi_si');
				usi_cookies.set('usi_si', usi_si, 24*60*60);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_si;
		},
		get_id: function(usi_append) {
			if (!usi_append) usi_append = "";
			var usi_id = null;
			try {
				if (usi_cookies.get('usi_v') == null && usi_cookies.get('usi_id'+usi_append) == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_id = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_id'+usi_append, usi_id, 30 * 86400, true);
					return usi_id;
				}
				if (usi_cookies.get('usi_v') != null) usi_id = usi_cookies.get('usi_v');
				if (usi_cookies.get('usi_id'+usi_append) != null) usi_id = usi_cookies.get('usi_id'+usi_append);
				usi_cookies.set('usi_id'+usi_append, usi_id, 30 * 86400, true);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_id;
		},
		load_session_data: function(extended) {
			try {
				if (usi_cookies.get_json("usi_session_data") == null) {
					usi_commons.load_script(usi_commons.domain + '/utility/session_data.jsp?extended=' + (extended?"true":"false"));
				} else {
					usi_app.session_data = usi_cookies.get_json("usi_session_data");
					if (typeof(usi_app.session_data_callback) !== "undefined") {
						usi_app.session_data_callback();
					}
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
		}
	};
	setTimeout(function() {
		try {
			if (usi_commons.gup_or_get_cookie("usi_debug") != "") usi_commons.debug = true;
			if (usi_commons.gup_or_get_cookie("usi_qa") != "") {
				usi_commons.domain = usi_commons.cdn = "https://prod.upsellit.com";
			}
		} catch(err) {
			usi_commons.report_error(err);
		}
	}, 1000);
}

if (typeof usi_app === 'undefined') {
	try {
		if("undefined"==typeof usi_cookies&&(usi_cookies={expire_time:{minute:60,hour:3600,two_hours:7200,four_hours:14400,day:86400,week:604800,two_weeks:1209600,month:2592e3,year:31536e3,never:31536e4},max_cookies_count:15,max_cookie_length:1e3,update_window_name:function(e,o,i){try{var n=-1;if(-1!=i){var t=new Date;t.setTime(t.getTime()+1e3*i),n=t.getTime()}var r=window.top||window,s=0;null!=o&&-1!=o.indexOf("=")&&(o=o.replace(new RegExp("=","g"),"USIEQLS")),null!=o&&-1!=o.indexOf(";")&&(o=o.replace(new RegExp(";","g"),"USIPRNS"));for(var a=r.name.split(";"),u="",c=0;c<a.length;c++){var l=a[c].split("=");3==l.length?(l[0]==e&&(l[1]=o,l[2]=n,s=1),null!=l[1]&&"null"!=l[1]&&(u+=l[0]+"="+l[1]+"="+l[2]+";")):""!=a[c]&&(u+=a[c]+";")}0==s&&(u+=e+"="+o+"="+n+";"),r.name=u}catch(e){}},flush_window_name:function(e){try{for(var o=window.top||window,i=o.name.split(";"),n="",t=0;t<i.length;t++){var r=i[t].split("=");3==r.length&&(0==r[0].indexOf(e)||(n+=i[t]+";"))}o.name=n}catch(e){}},get_from_window_name:function(e){try{for(var o,i=(window.top||window).name.split(";"),n=0;n<i.length;n++){var t=i[n].split("=");if(3==t.length){if(t[0]==e&&(-1!=(o=t[1]).indexOf("USIEQLS")&&(o=o.replace(new RegExp("USIEQLS","g"),"=")),-1!=o.indexOf("USIPRNS")&&(o=o.replace(new RegExp("USIPRNS","g"),";")),!("-1"!=t[2]&&usi_cookies.datediff(t[2])<0)))return[o,t[2]]}else if(2==t.length&&t[0]==e)return-1!=(o=t[1]).indexOf("USIEQLS")&&(o=o.replace(new RegExp("USIEQLS","g"),"=")),-1!=o.indexOf("USIPRNS")&&(o=o.replace(new RegExp("USIPRNS","g"),";")),[o,(new Date).getTime()+6048e5]}}catch(e){}return null},datediff:function(e){return e-(new Date).getTime()},count_cookies:function(e){return e=e||"usi_",usi_cookies.search_cookies(e).length},root_domain:function(){try{var e=document.domain.split("."),o=e[e.length-1];if("com"==o||"net"==o||"org"==o||"us"==o||"co"==o||"ca"==o)return e[e.length-2]+"."+e[e.length-1]}catch(e){}return document.domain},create_cookie:function(e,o,i){if(!1!==navigator.cookieEnabled){var n="";if(-1!=i){var t=new Date;t.setTime(t.getTime()+1e3*i),n="; expires="+t.toGMTString()}var r="samesite=none;";0==location.href.indexOf("https://")&&(r+="secure;");var s=usi_cookies.root_domain();"undefined"!=typeof usi_parent_domain&&-1!=document.domain.indexOf(usi_parent_domain)&&(s=usi_parent_domain),document.cookie=e+"="+encodeURIComponent(o)+n+"; path=/;domain="+s+"; "+r}},create_nonencoded_cookie:function(e,o,i){if(!1!==navigator.cookieEnabled){var n="";if(-1!=i){var t=new Date;t.setTime(t.getTime()+1e3*i),n="; expires="+t.toGMTString()}var r="samesite=none;";0==location.href.indexOf("https://")&&(r+="secure;");var s=usi_cookies.root_domain();"undefined"!=typeof usi_parent_domain&&-1!=document.domain.indexOf(usi_parent_domain)&&(s=usi_parent_domain),document.cookie=e+"="+o+n+"; path=/;domain="+s+"; "+r}},read_cookie:function(e){if(!1===navigator.cookieEnabled)return null;var o=e+"=",i=[];try{i=document.cookie.split(";")}catch(e){}for(var n=0;n<i.length;n++){for(var t=i[n];" "==t.charAt(0);)t=t.substring(1,t.length);if(0==t.indexOf(o))return decodeURIComponent(t.substring(o.length,t.length))}return null},del:function(e){usi_cookies.set(e,null,-100);try{null!=localStorage&&localStorage.removeItem(e),null!=sessionStorage&&sessionStorage.removeItem(e)}catch(e){}},get_ls:function(e){try{var o=localStorage.getItem(e);if(null!=o){if(0==o.indexOf("{")&&-1!=o.indexOf("usi_expires")){var i=JSON.parse(o);if((new Date).getTime()>i.usi_expires)return localStorage.removeItem(e),null;o=i.value}return decodeURIComponent(o)}}catch(e){}return null},get:function(e){var o=usi_cookies.read_cookie(e);if(null!=o)return o;try{if(null!=localStorage&&null!=(o=usi_cookies.get_ls(e)))return o;if(null!=sessionStorage&&null!=(o=sessionStorage.getItem(e)))return decodeURIComponent(o)}catch(e){}var i=usi_cookies.get_from_window_name(e);if(null!=i&&i.length>1)try{o=decodeURIComponent(i[0])}catch(e){return i[0]}return o},get_json:function(e){var o=null,i=usi_cookies.get(e);if(null==i)return null;try{o=JSON.parse(i)}catch(e){i=i.replace(/\\"/g,'"');try{o=JSON.parse(JSON.parse(i))}catch(e){try{o=JSON.parse(i)}catch(e){}}}return o},search_cookies:function(e){e=e||"";var o=[];return document.cookie.split(";").forEach((function(i){var n=i.split("=")[0].trim();""!==e&&0!==n.indexOf(e)||o.push(n)})),o},set:function(e,o,i,n){"undefined"!=typeof usi_nevercookie&&(n=!1),void 0===i&&(i=-1);try{o=o.replace(/(\r\n|\n|\r)/gm,"")}catch(e){}"undefined"==typeof usi_windownameless&&usi_cookies.update_window_name(e+"",o+"",i);try{if(i>0&&null!=localStorage){var t={value:o,usi_expires:(new Date).getTime()+1e3*i};localStorage.setItem(e,JSON.stringify(t))}else null!=sessionStorage&&sessionStorage.setItem(e,o)}catch(e){}if(n||null==o){if(null!=o){if(null==usi_cookies.read_cookie(e))if(!n)if(usi_cookies.search_cookies("usi_").length+1>usi_cookies.max_cookies_count)return void usi_cookies.report_error('Set cookie "'+e+'" failed. Max cookies count is '+usi_cookies.max_cookies_count);if(o.length>usi_cookies.max_cookie_length)return void usi_cookies.report_error('Cookie "'+e+'" truncated ('+o.length+"). Max single-cookie length is "+usi_cookies.max_cookie_length)}usi_cookies.create_cookie(e,o,i)}},set_json:function(e,o,i,n){var t=JSON.stringify(o).replace(/^"/,"").replace(/"$/,"");usi_cookies.set(e,t,i,n)},flush:function(e){e=e||"usi_";var o,i,n,t=document.cookie.split(";");for(o=0;o<t.length;o++)0==(i=t[o]).trim().toLowerCase().indexOf(e)&&(n=i.trim().split("=")[0],usi_cookies.del(n));usi_cookies.flush_window_name(e);try{if(null!=localStorage)for(var r in localStorage)0==r.indexOf("usi_")&&localStorage.removeItem(r);if(null!=sessionStorage)for(var r in sessionStorage)0==r.indexOf("usi_")&&sessionStorage.removeItem(r)}catch(e){}},print:function(){for(var e=document.cookie.split(";"),o="",i=0;i<e.length;i++){var n=e[i];0==n.trim().toLowerCase().indexOf("usi_")&&(console.log(decodeURIComponent(n.trim())+" (cookie)"),o+=","+n.trim().toLowerCase().split("=")[0]+",")}try{if(null!=localStorage)for(var t in localStorage)0==t.indexOf("usi_")&&"string"==typeof localStorage[t]&&-1==o.indexOf(","+t+",")&&(console.log(t+"="+usi_cookies.get_ls(t)+" (localStorage)"),o+=","+t+",");if(null!=sessionStorage)for(var t in sessionStorage)0==t.indexOf("usi_")&&"string"==typeof sessionStorage[t]&&-1==o.indexOf(","+t+",")&&(console.log(t+"="+sessionStorage[t]+" (sessionStorage)"),o+=","+t+",")}catch(e){}for(var r=(window.top||window).name.split(";"),s=0;s<r.length;s++){var a=r[s].split("=");if(3==a.length&&0==a[0].indexOf("usi_")&&-1==o.indexOf(","+a[0]+",")){var u=a[1];-1!=u.indexOf("USIEQLS")&&(u=u.replace(new RegExp("USIEQLS","g"),"=")),-1!=u.indexOf("USIPRNS")&&(u=u.replace(new RegExp("USIPRNS","g"),";")),console.log(a[0]+"="+u+" (window.name)"),o+=","+n.trim().toLowerCase().split("=")[0]+","}}},value_exists:function(){var e,o;for(e=0;e<arguments.length;e++)if(""===(o=usi_cookies.get(arguments[e]))||null===o||"null"===o||"undefined"===o)return!1;return!0},report_error:function(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}},"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.gup&&"function"==typeof usi_commons.gup_or_get_cookie))try{""!=usi_commons.gup("usi_email_id")?usi_cookies.set("usi_email_id",usi_commons.gup("usi_email_id").split(".")[0],Number(usi_commons.gup("usi_email_id").split(".")[1]),!0):null==usi_cookies.read_cookie("usi_email_id")&&null!=usi_cookies.get_from_window_name("usi_email_id")&&(usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?usi_email_id_fix="+encodeURIComponent(usi_cookies.get_from_window_name("usi_email_id")[0])),usi_cookies.set("usi_email_id",usi_cookies.get_from_window_name("usi_email_id")[0],(usi_cookies.get_from_window_name("usi_email_id")[1]-(new Date).getTime())/1e3,!0)),""!=usi_commons.gup_or_get_cookie("usi_debug")&&(usi_commons.debug=!0),""!=usi_commons.gup_or_get_cookie("usi_qa")&&(usi_commons.domain=usi_commons.cdn="https://prod.upsellit.com")}catch(e){usi_commons.report_error(e)}
"undefined"==typeof usi_dom&&(usi_dom={},usi_dom.get_elements=function(e,t){return t=t||document,Array.prototype.slice.call(t.querySelectorAll(e))},usi_dom.count_elements=function(e,t){return t=t||document,usi_dom.get_elements(e,t).length},usi_dom.get_nth_element=function(e,t,n){var o=null;n=n||document;var r=usi_dom.get_elements(t,n);return r.length>=e&&(o=r[e-1]),o},usi_dom.get_first_element=function(e,t){if(""===(e||""))return null;if(t=t||document,"[object Array]"===Object.prototype.toString.call(e)){for(var n=null,o=0;o<e.length;o++){var r=e[o];if(null!=(n=usi_dom.get_first_element(r,t)))break}return n}return t.querySelector(e)},usi_dom.get_element_text_no_children=function(e,t){var n="";if(null==t&&(t=!1),null!=(e=e||document)&&null!=e.childNodes)for(var o=0;o<e.childNodes.length;++o)3===e.childNodes[o].nodeType&&(n+=e.childNodes[o].textContent);return!0===t&&(n=usi_dom.clean_string(n)),n.trim()},usi_dom.clean_string=function(e){if("string"==typeof e){return(e=(e=(e=(e=(e=(e=(e=e.replace(/[\u2010-\u2015\u2043]/g,"-")).replace(/[\u2018-\u201B]/g,"'")).replace(/[\u201C-\u201F]/g,'"')).replace(/\u2024/g,".")).replace(/\u2025/g,"..")).replace(/\u2026/g,"...")).replace(/\u2044/g,"/")).replace(/[^\x20-\xFF\u0100-\u017F\u0180-\u024F\u20A0-\u20CF]/g,"").trim()}},usi_dom.encode=function(e){if("string"==typeof e){var t=encodeURIComponent(e);return t=t.replace(/[-_.!~*'()]/g,function(e){return"%"+e.charCodeAt(0).toString(16).toUpperCase()})}},usi_dom.get_closest=function(e,t){for(e=e||document,"function"!=typeof Element.prototype.matches&&(Element.prototype.matches=Element.prototype.matchesSelector||Element.prototype.mozMatchesSelector||Element.prototype.msMatchesSelector||Element.prototype.oMatchesSelector||Element.prototype.webkitMatchesSelector||function(e){for(var t=(this.document||this.ownerDocument).querySelectorAll(e),n=t.length;--n>=0&&t.item(n)!==this;);return n>-1});null!=e&&e!==document;e=e.parentNode)if(e.matches(t))return e;return null},usi_dom.get_classes=function(e){var t=[];return null!=e&&null!=e.classList&&(t=Array.prototype.slice.call(e.classList)),t},usi_dom.add_class=function(e,t){if(null!=e){var n=usi_dom.get_classes(e);-1===n.indexOf(t)&&(n.push(t),e.className=n.join(" "))}},usi_dom.string_to_decimal=function(e){var t=null;if("string"==typeof e)try{var n=parseFloat(e.replace(/[^0-9\.-]+/g,""));!1===isNaN(n)&&(t=n)}catch(e){usi_commons.log("Error: "+e.message)}return t},usi_dom.string_to_integer=function(e){var t=null;if("string"==typeof e)try{var n=parseInt(e.replace(/[^0-9-]+/g,""));!1===isNaN(n)&&(t=n)}catch(e){usi_commons.log("Error: "+e.message)}return t},usi_dom.get_currency_string_from_content=function(e){if("string"!=typeof e)return"";try{e=e.trim();var t=e.match(/^([^\$]*?)(\$(?:[\,\,]?\d{1,3})+(?:\.\d{2})?)(.*?)$/)||[];return 4===t.length?t[2]:""}catch(e){return usi_commons.log("Error: "+e.message),""}},usi_dom.get_absolute_url=function(){var e;return function(t){return(e=e||document.createElement("a")).href=t,e.href}}(),usi_dom.format_number=function(e,t){var n="";if("number"==typeof e){t=t||0;var o=e.toFixed(t).split(/\./g);if(1==o.length||2==o.length)n=o[0].replace(/./g,function(e,t,n){return t&&"."!==e&&(n.length-t)%3==0?","+e:e}),2==o.length&&(n+="."+o[1])}return n},usi_dom.format_currency=function(e,t,n){var o="";return e=Number(e),!1===isNaN(e)&&("object"==typeof Intl&&"function"==typeof Intl.NumberFormat?(t=t||"en-US",n=n||{style:"currency",currency:"USD"},o=e.toLocaleString(t,n)):o=e),o},usi_dom.to_decimal_places=function(e,t){if(null!=e&&"number"==typeof e&&null!=t&&"number"==typeof t){if(0==t)return parseFloat(Math.round(e));for(var n=10,o=1;o<t;o++)n*=10;return parseFloat(Math.round(e*n)/n)}return null},usi_dom.trim_string=function(e,t,n){return n=n||"",(e=e||"").length>t&&(e=e.substring(0,t),""!==n&&(e+=n)),e},usi_dom.attach_event=function(e,t,n){var o=usi_dom.find_supported_element(e,n);usi_dom.detach_event(e,t,o),o.addEventListener?o.addEventListener(e,t,!1):o.attachEvent("on"+e,t)},usi_dom.detach_event=function(e,t,n){var o=usi_dom.find_supported_element(e,n);o.removeEventListener?o.removeEventListener(e,t,!1):o.detachEvent("on"+e,t)},usi_dom.find_supported_element=function(e,t){return(t=t||document)===window?window:!0===usi_dom.is_event_supported(e,t)?t:t===document?window:usi_dom.find_supported_element(e,document)},usi_dom.is_event_supported=function(e,t){return null!=t&&void 0!==t["on"+e]},usi_dom.is_defined=function(e,t){if(null==e)return!1;if(""===(t||""))return!1;var n=!0,o=e;return t.split(".").forEach(function(e){!0===n&&(null==o||"object"!=typeof o||!1===o.hasOwnProperty(e)?n=!1:o=o[e])}),n},usi_dom.observe=function(e,t,n){var o=location.href,r=window.MutationObserver||window.WebkitMutationObserver;return t=t||{onUrlUpdate:!1,observerOptions:{childList:!0,subtree:!0}},function(e,n){var i=null,u=function(){var e=location.href;t.onUrlUpdate&&e!==o?(n(),o=e):n()};return r?(i=new r(function(e){var r=location.href,i=e[0].addedNodes.length||e[0].removedNodes.length;i&&t.onUrlUpdate&&r!==o?(n(),o=r):i&&n()})).observe(e,t.observerOptions):window.addEventListener&&(e.addEventListener("DOMNodeInserted",u,!1),e.addEventListener("DOMNodeRemoved",u,!1)),i}}(),usi_dom.params_to_object=function(e){var t={};""!=(e||"")&&e.split("&").forEach(function(e){var n=e.split("=");2===n.length?t[decodeURIComponent(n[0])]=decodeURIComponent(n[1]):1===n.length&&(t[decodeURIComponent(n[0])]=null)});return t},usi_dom.object_to_params=function(e){var t=[];if(null!=e)for(var n in e)!0===e.hasOwnProperty(n)&&t.push(encodeURIComponent(n)+"="+(null==e[n]?"":encodeURIComponent(e[n])));return t.join("&")},usi_dom.interval_with_timeout=function(e,t,n,o){if("function"!=typeof e)throw new Error("usi_dom.interval_with_timeout(): iterationFunction must be a function");if(null==t)t=function(e){return e};else if("function"!=typeof t)throw new Error("usi_dom.interval_with_timeout(): timeoutCallback must be a function");if(null==n)n=function(e){return e};else if("function"!=typeof n)throw new Error("usi_dom.interval_with_timeout(): completeCallback must be a function");var r=(o=o||{}).intervalMS||20,i=o.timeoutMS||2e3;if("number"!=typeof r)throw new Error("usi_dom.interval_with_timeout(): intervalMS must be a number");if("number"!=typeof i)throw new Error("usi_dom.interval_with_timeout(): timeoutMS must be a number");var u=!1,l=new Date,a=setInterval(function(){var o=new Date-l;if(o>=i)return clearInterval(a),t({elapsedMS:o});!1===u&&(u=!0,e(function(e,t){if(u=!1,!0===e)return clearInterval(a),(t=t||{}).elapsedMS=new Date-l,n(t)}))},r)},usi_dom.load_external_stylesheet=function(e,t,n){if(""!==(e||"")){""===(t||"")&&(t="usi_stylesheet_"+(new Date).getTime());var o={url:e,id:t},r=document.getElementsByTagName("head")[0];if(null!=r){var i=document.createElement("link");i.type="text/css",i.rel="stylesheet",i.id=o.id,i.href=e,usi_dom.attach_event("load",function(){if(null!=n)return n(null,o)},i),r.appendChild(i)}}else if(null!=n)return n(null,o)},usi_dom.ready=function(e){void 0!==document.readyState&&"complete"===document.readyState?e():window.addEventListener?window.addEventListener("load",e,!0):window.attachEvent?window.attachEvent("onload",e):setTimeout(e,5e3)},usi_dom.fit_text=function(e,t){t||(t={});var n={multiLine:!0,minFontSize:.1,maxFontSize:20,widthOnly:!1},o={};for(var r in n)t.hasOwnProperty(r)?o[r]=t[r]:o[r]=n[r];var i=Object.prototype.toString.call(e);function u(e,t){var n,o,r,i,u,l,a,s;r=e.innerHTML,u=parseInt(window.getComputedStyle(e,null).getPropertyValue("font-size"),10),i=function(e){var t=window.getComputedStyle(e,null);return(e.clientWidth-parseInt(t.getPropertyValue("padding-left"),10)-parseInt(t.getPropertyValue("padding-right"),10))/u}(e),o=function(e){var t=window.getComputedStyle(e,null);return(e.clientHeight-parseInt(t.getPropertyValue("padding-top"),10)-parseInt(t.getPropertyValue("padding-bottom"),10))/u}(e),i&&(t.widthOnly||o)||(t.widthOnly?usi_commons.log("Set a static width on the target element "+e.outerHTML):usi_commons.log("Set a static height and width on the target element "+e.outerHTML)),-1===r.indexOf("textFitted")?((n=document.createElement("span")).className="textFitted",n.style.display="inline-block",n.innerHTML=r,e.innerHTML="",e.appendChild(n)):n=e.querySelector("span.textFitted"),t.multiLine||(e.style["white-space"]="nowrap"),l=t.minFontSize,s=t.maxFontSize;for(var c=l,d=1e3;l<=s&&d>0;)d--,a=s+l-.1,n.style.fontSize=a+"em",n.scrollWidth/u<=i&&(t.widthOnly||n.scrollHeight/u<=o)?(c=a,l=a+.1):s=a-.1;n.style.fontSize!==c+"em"&&(n.style.fontSize=c+"em")}"[object Array]"!==i&&"[object NodeList]"!==i&&"[object HTMLCollection]"!==i&&(e=[e]);for(var l=0;l<e.length;l++)u(e[l],o)});
'undefined'==typeof usi_url&&(usi_url={},usi_url.URL=function(a){a=a||location.href;var b=document.createElement('a');if(b.href=a,this.full=b.href||'',this.protocol=(b.protocol||'').split(':')[0],this.host=b.host||'',-1!=this.host.indexOf(':')&&(this.host=this.host.substring(0,this.host.indexOf(':'))),this.port=b.port||'',this.hash=b.hash||'',this.baseURL='',this.tld='',this.domain='',this.subdomain='',this.domain_tld='',''!==this.protocol&&''!==this.host){this.baseURL=this.protocol+'://'+this.host+'/';var c=this.host.split(/\./g);if(2<=c.length){if(-1<['co','com','org','net','int','edu','gov','mil'].indexOf(c[c.length-2])&&2===c[c.length-1].length){var d=c.pop(),e=c.pop();this.tld=e+'.'+d}else this.tld=c.pop()}0<c.length&&(this.domain=c.pop(),0<c.length&&(this.subdomain=c.join('.'))),this.domain_tld=this.domain+'.'+this.tld}var f=b.pathname||'';0!==f.indexOf('/')&&(f='/'+f),this.path=new usi_url.Path(f),this.params=new usi_url.Params((b.search||'').substr(1))},usi_url.URL.prototype.build=function(a,b,c){var d='';return''!==this.protocol&&''!==this.host&&(null==a&&(a=!0),null==b&&(b=!0),null==c&&(c=!0),!0==a&&(d+=this.protocol+':'),d+='//'+this.host,''!==this.port&&(d+=':'+this.port),!0==b&&(d+=this.path.full,!0==c&&0<Object.keys(this.params.parameters).length&&(d+='?',d+=this.params.build()))),d},usi_url.Path=function(a){a=a||'',this.full=a,this.directories=[],this.filename='';for(var b=a.substr(1).split(/\//g);0<b.length;)1===b.length?this.filename=b.shift():this.directories.push(b.shift());this.has_directory=function(a){return-1<this.directories.indexOf(a)},this.contains=function(a){return-1<this.full.indexOf(a)}},usi_url.Params=function(a){a=a||'',this.full=a,this.parameters=function(a){var b={};if(1===a.length&&''===a[0])return b;for(var c,d,e,f=0;f<a.length;f++)if(e=a[f].split('='),c=e[0]&&e[0].replace(/\+/g,' '),d=e[1]&&e[1].replace(/\+/g,' '),1===e.length)b[c]='';else try{b[c]=decodeURIComponent(d)}catch(a){b[c]=d}return b}(a.split('&')),this.count=Object.keys(this.parameters).length,this.get=function(a){return a in this.parameters?this.parameters[a]:null},this.has=function(a){return a in this.parameters},this.set=function(a,b){this.parameters[a]=b,this.count=Object.keys(this.parameters).length},this.remove=function(a){!0===this.has(a)&&delete this.parameters[a],this.count=Object.keys(this.parameters).length},this.build=function(){var a=this,b=[];for(var c in a.parameters)!0===a.parameters.hasOwnProperty(c)&&b.push(c+'='+encodeURIComponent(a.parameters[c]));return b.join('&')},this.remove_usi_params=function(a){var b=this;for(var c in a=a||[],-1===a.indexOf('usi_')&&a.push('usi_'),b.parameters)if(!0===b.parameters.hasOwnProperty(c)){var d=!1;a.forEach(function(a){0===c.indexOf(a)&&(d=!0)}),d&&b.remove(c)}},this.remove_all=function(){var a=this;for(var b in a.parameters)!0===a.parameters.hasOwnProperty(b)&&a.remove(b)}});
"undefined"==typeof usi_ajax&&(usi_ajax={},usi_ajax.get=function(e,t){try{return usi_ajax.get_with_options({url:e},t)}catch(e){usi_commons.report_error(e)}},usi_ajax.get_with_options=function(e,t){null==t&&(t=function(){});var r={};if((e=e||{}).headers=e.headers||[],null==XMLHttpRequest)return t(new Error("XMLHttpRequest not supported"),r);if(""===(e.url||""))return t(new Error("url cannot be blank"),r);try{var a=new XMLHttpRequest;a.open("GET",e.url,!0),a.setRequestHeader("Content-type","application/json"),e.headers.forEach(function(e){""!==(e.name||"")&&""!==(e.value||"")&&a.setRequestHeader(e.name,e.value)}),a.onreadystatechange=function(){if(4===a.readyState){r.status=a.status,r.responseText=a.responseText||"";var e=null;return 0!==String(a.status).indexOf("2")&&(e=new Error("http.status: "+a.status)),t(e,r)}},a.send()}catch(e){return usi_commons.report_error(e),t(e,r)}},usi_ajax.post=function(e,t,r){try{return usi_ajax.post_with_options({url:e,params:t},r)}catch(e){usi_commons.report_error(e)}},usi_ajax.post_with_options=function(e,t){null==t&&(t=function(){});var r={};if((e=e||{}).headers=e.headers||[],e.paramsDataType=e.paramsDataType||"string",e.params=e.params||"",null==XMLHttpRequest)return t(new Error("XMLHttpRequest not supported"),r);if(""===(e.url||""))return t(new Error("url cannot be blank"),r);try{var a=new XMLHttpRequest;a.open("POST",e.url,!0),"formData"===e.paramsDataType||("object"===e.paramsDataType?(a.setRequestHeader("Content-type","application/json; charset=utf-8"),e.params=JSON.stringify(e.params)):a.setRequestHeader("Content-type","application/x-www-form-urlencoded")),e.headers.forEach(function(e){""!==(e.name||"")&&""!==(e.value||"")&&a.setRequestHeader(e.name,e.value)}),a.onreadystatechange=function(){if(4===a.readyState){r.status=a.status,r.responseText=a.responseText||"",r.responseURL=a.responseURL||"";var e=null;return 0!==String(a.status).indexOf("2")&&(e=new Error("http.status: "+a.status)),t(e,r)}},a.send(e.params)}catch(e){return usi_commons.report_error(e),t(e,r)}},usi_ajax.form_post=function(e,t,r){try{r=r||"post";var a=document.createElement("form");a.setAttribute("method",r),a.setAttribute("action",e),null!=t&&"object"==typeof t&&Object.keys(t).forEach(function(e){var r=document.createElement("input");r.setAttribute("type","hidden"),r.setAttribute("name",e),r.setAttribute("value",t[e]),a.appendChild(r)}),document.body.appendChild(a),a.submit()}catch(e){usi_commons.report_error(e)}},usi_ajax.put_with_options=function(e,t){null==t&&(t=function(){});var r={};if((e=e||{}).headers=e.headers||[],null==XMLHttpRequest)return t(new Error("XMLHttpRequest not supported"),r);if(""===(e.url||""))return t(new Error("url cannot be blank"),r);try{var a=new XMLHttpRequest;a.open("PUT",e.url,!0),a.setRequestHeader("Content-type","application/json"),e.headers.forEach(function(e){""!==(e.name||"")&&""!==(e.value||"")&&a.setRequestHeader(e.name,e.value)}),a.onreadystatechange=function(){if(4===a.readyState){r.status=a.status,r.responseText=a.responseText||"";var e=null;return 0!==String(a.status).indexOf("2")&&(e=new Error("http.status: "+a.status)),t(e,r)}},a.send()}catch(e){return usi_commons.report_error(e),t(e,r)}},usi_ajax.get_with_script=function(e,t,r){try{var a={};null==t&&(t=!0);var n="usi_"+(new Date).getTime(),s=document.getElementsByTagName("head")[0];top.location!=location&&(s=parent.document.getElementsByTagName("head")[0]);var o=document.createElement("script");o.id=n,o.type="text/javascript",o.src=e,o.addEventListener("load",function(){if(!0===t&&s.removeChild(o),null!=r)return r(null,a)}),s.appendChild(o)}catch(e){usi_commons.report_error(e)}},usi_ajax.listener=function(e){if(null==e&&(e=!1),null!=XMLHttpRequest){var t=this;t.ajax=new Object,t.clear=function(){t.ajax.requests=[],t.ajax.registeredRequests=[],t.ajax.scriptLoads=[],t.ajax.registeredScriptLoads=[]},t.clear(),t.register=function(e,r,a){try{var n={method:e=(e||"*").toUpperCase(),url:r=r||"*",callback:a=a||function(){}};t.ajax.registeredRequests.push(n)}catch(e){usi_commons.report_error(e)}},t.registerScriptLoad=function(e,r){try{var a={url:e=e||"*",callback:r=r||function(){}};t.ajax.registeredScriptLoads.push(a)}catch(e){usi_commons.report_error(e)}},t.registerFormSubmit=function(t,r){try{null!=t&&usi_dom.attach_event("submit",function(a){if(!0===e&&usi_commons.log("USI AJAX: form submit"),null!=a&&!0===a.returnValue){a.preventDefault();var n={action:t.action,data:{},e:a},s=["submit"];if(Array.prototype.slice.call(t.elements).forEach(function(e){try{-1===s.indexOf(e.type)&&("checkbox"===e.type?!0===e.checked&&(n.data[e.name]=e.value):n.data[e.name]=e.value)}catch(e){usi_commons.report_error(e)}}),null!=r)return r(null,n);a.returnValue=!0}},t)}catch(e){usi_commons.report_error(e)}},t.listen=function(){try{t.ajax.originalOpen=XMLHttpRequest.prototype.open,t.ajax.originalSend=XMLHttpRequest.prototype.send,XMLHttpRequest.prototype.open=function(r,a){r=(r||"").toUpperCase(),a=a||"",a=usi_dom.get_absolute_url(a),!0===e&&usi_commons.log("USI AJAX: open["+r+"]: "+a);var n={method:r,url:a,openDate:new Date};t.ajax.requests.push(n);var s=null;t.ajax.registeredRequests.forEach(function(e){e.method!=r&&"*"!=e.method||(a.indexOf(e.url)>-1||"*"==e.url)&&(s=e)}),null!=s&&(!0===e&&usi_commons.log("USI AJAX: Registered URL["+r+"]: "+a),this.requestObj=n,this.requestObj.callback=s.callback),t.ajax.originalOpen.apply(this,arguments)},XMLHttpRequest.prototype.send=function(r){var a=this;null!=a.requestObj&&(!0===e&&usi_commons.log("USI AJAX: Send Registered URL["+a.requestObj.method+"]: "+a.requestObj.url),""!=(r||"")&&(a.requestObj.params=r),a.addEventListener?a.addEventListener("readystatechange",function(){t.ajax.readyStateChanged(a)},!1):t.ajax.proxifyOnReadyStateChange(a)),t.ajax.originalSend.apply(a,arguments)},t.ajax.readyStateChanged=function(t){if(4===t.readyState&&null!=t.requestObj&&(t.requestObj.completedDate=new Date,!0===e&&usi_commons.log("Completed: "+t.requestObj.url),null!=t.requestObj.callback)){var r={requestObj:t.requestObj,responseText:t.responseText};return t.requestObj.callback(null,r)}},t.ajax.proxifyOnReadyStateChange=function(e){var r=e.onreadystatechange;null!=r&&(e.onreadystatechange=function(){t.ajax.readyStateChanged(e),r()})},document.head.addEventListener("load",function(e){if(null!=e&&null!=e.target&&""!=(e.target.src||"")){var r=e.target.src,a={url:r=usi_dom.get_absolute_url(r),completedDate:new Date};t.ajax.scriptLoads.push(a);var n=null;if(t.ajax.registeredScriptLoads.forEach(function(e){(r.indexOf(e.url)>-1||"*"==e.url)&&(n=e)}),null!=n&&null!=n.callback)return n.callback(null,a)}},!0),usi_commons.log("USI AJAX: listening ...")}catch(e){usi_commons.report_error(e),usi_commons.log("usi_ajax.listener ERROR: "+e.message)}},t.unregisterAll=function(){t.ajax.registeredRequests=[],t.ajax.registeredScriptLoads=[]}}});
"undefined"==typeof usi_data&&(usi_data={},usi_data.data_store=function(e){this.keyFieldName=e,this.cookieName="usi_data_"+e,this.items=usi_cookies.get_json(this.cookieName)||[],this.get_item=function(e){return usi_array.get_item(this.items,this.keyFieldName,e)},this.save_value=function(e,t,i){var s=this.get_item(e);return null==s&&((s={})[this.keyFieldName]=e,this.items.push(s)),s[t]=i,usi_cookies.set_json(this.cookieName,this.items,usi_cookies.expire_time.day),s},this.get_value=function(e,t){var i=null,s=this.get_item(e);return null!=s&&1==s.hasOwnProperty(t)&&(i=s[t]),i},this.attach_metadata=function(e){var t=null;if(null!=e&&1==e.hasOwnProperty(this.keyFieldName)&&null!=(t=this.get_item(e[this.keyFieldName])))for(var i in t)1==t.hasOwnProperty(i)&&(e[i]=t[i]);return t}},usi_data.new_guid=function(){return"xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g,function(e){var t=16*Math.random()|0;return("x"==e?t:3&t|8).toString(16)})},usi_data.get_session_id=function(){var e=null;return null!=usi_cookies.get("USI_Session")?e=usi_cookies.get("USI_Session"):null!=usi_cookies.get("USI_DataHound")?e=usi_cookies.get("USI_DataHound"):null!=usi_cookies.get("usi_sess")?e=usi_cookies.get("usi_sess"):(e="usi_sess_"+usi_data.new_guid(),usi_cookies.set("usi_sess",e,usi_cookies.expire_time.day)),e},usi_data.save_session_data=function(e,t,i,s){var n={};i=i||"0";var a=usi_data.get_session_id(),o=usi_commons.domain+"/hound/saveData.jsp?siteID="+i+"&USI_value="+encodeURIComponent(t)+"&USI_name="+encodeURIComponent(e)+"&USI_Session="+encodeURIComponent(a);usi_ajax.get_with_script(o,!0,function(e,t){return null!=e&&null!=s?s(e,n):null!=s?s(null,n):void 0})},usi_data.save_session_items=function(e,t,i){var s={sessionID:usi_data.get_session_id()};t=t||"0";var n=0;e.forEach(function(a){usi_data.save_session_data(a.name,a.value,t,function(t,a){if((n+=1)==e.length&&(usi_commons.log("Saved Session items: "+s.sessionID),null!=i))return i(s)})})},usi_data.get_session_data=function(e,t){var i=usi_commons.domain+"/hound/getSessionData.jsp?s="+e,s="usi_"+(new Date).getTime();if(""!==e){var n=document.getElementsByTagName("head")[0];top.location!=location&&(n=parent.document.getElementsByTagName("head")[0]);var a=document.createElement("script");a.id=s,a.type="text/javascript",a.src=i,a.addEventListener("load",function(){var i=null;if("undefined"!=typeof usi_data&&void 0!==usi_data.sessionData&&(i=usi_data.sessionData[e]||null),n.removeChild(a),null!=t)return t(null,i)}),n.appendChild(a)}},usi_data.is_item_on_list=function(e,t,i,s,n){var a={};if(""===(e||"")&&null!=callback)return callback(new Error("companyID cannot be blank."),a);if(""===(i||"")&&null!=callback)return callback(new Error("item cannot be blank."),a);var o=usi_commons.cdn+"/utility/lookup_suppression.jsp?companyID="+e+"&product="+encodeURIComponent(i);""!==(t||"")&&(o+="&label="+encodeURIComponent(t)),""!==(s||"")&&(o+="&callback="+encodeURIComponent(s));var u=usi_dom.object_to_params(n);""!=u&&(o+="&"+u);var _="usi_"+(new Date).getTime(),l=document.getElementsByTagName("head")[0];top.location!=location&&(l=parent.document.getElementsByTagName("head")[0]);var r=document.createElement("script");r.id=_,r.type="text/javascript",r.src=o,r.addEventListener("load",function(){l.removeChild(r)}),l.appendChild(r)},usi_data.get_qs_or_cookie_item=function(e,t){t=t||usi_cookies.expire_time.day;var i=null,s=usi_commons.gup(e);return""!==s?(i=s,usi_cookies.set(e,i,t)):i=usi_cookies.get(e),i||""},usi_data.build_form_data_object=function(e,t){var i=null;return null==t&&(t=!0),null!=e&&(i={},usi_dom.get_elements("*",e).forEach(function(e){if(e.hasAttribute("name")){var s=e.getAttribute("name")||"";if(""!==s){var n=e.value||"";(""!==n||t)&&(i[s]=n)}}})),i});

		usi_cookieless = true;
		usi_app = {};
		usi_app.main = function () {
			try {
				// General
				usi_app.url = new usi_url.URL(location.href.toLowerCase());
				usi_app.recommendation_site_cart = "29065";
				usi_app.recommendation_site_product = "39976";
				usi_app.product_page_data = {};

				// Pages
				usi_app.is_product_page = window['globalData'] && window['globalData']['pageType'] === 'product';
				usi_app.is_cart_page = usi_app.url.path.filename === "cart";
				usi_app.is_checkout_login_page = usi_app.url.path.filename === "checkoutlogin";
				usi_app.is_confirmation_page = usi_app.url.path.full.indexOf("/order-received/") != -1;

				// Booleans
				usi_app.is_enabled = usi_commons.gup_or_get_cookie("usi_enable", usi_cookies.expire_time.hour, true) != "";
				usi_app.is_suppressed = usi_app.is_confirmation_page;
				usi_app.real_time = false;

				if (usi_commons.gup("utm_source") == "Upsellit.com") {
					usi_cookies.set("usi_needs_link", "1", 30*24*60*60);
				}

				if (usi_cookies.get("usi_needs_link") != null && location.href.indexOf("/checkoutbegin") != -1) {
					usi_app.listen_for_payment();
				}

				// Rebuild cart (add usi_rebuild={{SESSIONID}} on email destination link)
				if (!usi_cookies.value_exists("usi_suppress_cr") && usi_app.is_cart_page && usi_commons.gup("usi_rebuild") != "" && document.querySelector(".cart-empty h1") != null) {
					document.querySelector(".cart-empty h1").innerHTML = "One moment while we rebuild your cart...";
					usi_data.get_session_data(usi_commons.gup("usi_rebuild"), usi_app.rebuild);
					return;
				}

				// Collect product page data
				if (usi_app.is_product_page && !usi_commons.is_mobile) {
					usi_app.product_page_data = usi_app.send_product_data();
				}

				// Check suppressions
				if (usi_app.is_suppressed) {
					return usi_commons.log("[ main ] Company is suppressed!");
				}

				// Listen for cart adds
				usi_app.setup_listener("/Cart-AddProduct", usi_app.handle_ajax_response);

				// Save cart data
				if (usi_app.is_cart_page) {
					usi_app.save_cart();
				} else {
					// Load campaigns
					usi_app.load();
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.link_injection = function (src,callback) {
			var iframe = document.createElement("iframe");
			iframe.src = src;
			iframe.style.width = "1px";
			iframe.style.height = "1px";
			iframe.setAttribute("id","usi_iframe");
			if (callback != null) iframe.onload = callback;
			document.getElementsByTagName('body')[0].appendChild(iframe);
		};


		usi_app.listen_for_payment = function() {
			if (location.href.indexOf("checkoutbegin?stage=payment#payment") != -1) {
				usi_cookies.del("usi_needs_link");
				usi_app.link_injection("https://pcrs.rv8crv.net/c/16669/674905/10458");
			} else {
				setTimeout(usi_app.listen_for_payment, 2000);
			}
		};

		usi_app.load = function () {
			try {
				// Clean up previous solutions
				if (typeof usi_js !== 'undefined' && typeof usi_js.cleanup === 'function') {
					usi_js.cleanup();
				}

				// PC - Cart Rebuilder (New)
				

				if (usi_app.is_checkout_login_page && usi_cookies.value_exists('usi_cart', 'usi_prod_name_1', 'usi_prod_pic_1', 'usi_prod_price_1')) {
					// Specific recs
					usi_app.load_product_data({
						siteID: usi_app.recommendation_site_product,
						pid: usi_cookies.get("usi_prod_pid_1") || "popular",
						nomatch: "OUTOFSTOCK,noimage",
						//match: 'OLED55A1PUA,OLED65A1PUA,OLED77A1PUA',
						//force_exact: true,
						callback: function () {
							if (typeof (usi_app.product_rec.product3) != "undefined") {
								usi_commons.log('[ load ] * * * PC - 3 Recs * * *');
								usi_commons.load_precapture("0RSGdZUOoTyLwighZMj8sZ2", "41330");
							}
						}
					})
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.shuffle = function (array) {
			try {
				for (var i = array.length - 1; i > 0; i--) {
					var j = Math.floor(Math.random() * (i + 1));
					var temp = array[i];
					array[i] = array[j];
					array[j] = temp;
				}
				return array;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.create_cookie = function (name, value, exp_seconds) {
			var expires = "";
			if (exp_seconds != -1) {
				var date = new Date();
				date.setTime(date.getTime() + (exp_seconds * 1000));
				expires = "; expires=" + date.toGMTString();
			}
			document.cookie = name + "=" + value + expires + "; domain=.pcrichard.com; path=/;";
		};

		usi_app.save_cart = function () {
			try {
				var cart_prefix = "usi_prod_";
				usi_cookies.flush(cart_prefix);
				usi_app.cart = {
					items: usi_app.scrape_cart(),
					subtotal: usi_app.scrape_subtotal()
				};

				if (typeof usi_app.cart.items != "undefined") {
					usi_app.cart.items.forEach(function (product, index) {
						var prop;
						if (index >= 3) return;
						for (prop in product) {
							if (product.hasOwnProperty(prop)) {
								usi_cookies.set(cart_prefix + prop + "_" + (index + 1), encodeURIComponent(product[prop]), usi_cookies.expire_time.week);
							}
						}
					});
				}
				usi_commons.log('[ save_cart ] items:', usi_app.cart.items);
				usi_app.process_cr_params(usi_app.cart.items);

				if (typeof usi_app.cart.subtotal != "undefined") {
					usi_cookies.set("usi_subtotal", usi_app.cart.subtotal, usi_cookies.expire_time.week);
				}
				usi_commons.log('[ save_cart ] subtotal:', usi_app.cart.subtotal);

				// Load solutions
				usi_app.load();
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.process_cr_params = function (items) {
			try {
				// Fetch original cart
				var cart = usi_cookies.get("usi_cart") || '';
				if (cart) {
					var cart_arr = cart.split('|');
					var cart_arr_final = [];
					usi_commons.log('[ process_cr_params ] cart_arr:', cart_arr);
					items.forEach(function (el) {
						for (var i = 0; i < cart_arr.length; i++) {
							if (cart_arr[i].indexOf(el.pid) !== -1) {
								// Update qty
								var head = cart_arr[i].split('~')[0];
								var body = cart_arr[i].split('~')[1];
								var head_arr = head.split('@');
								head_arr[1] = el.qty;
								cart_arr_final.push(head_arr.join('@') + '~' + body);
								break;
							}
						}
					});
					usi_commons.log('[ process_cr_params ] cart_arr_final:', cart_arr_final);
					cart = cart_arr_final.join('|');
					usi_cookies.set("usi_cart", cart, usi_cookies.expire_time.week);
					usi_commons.log('[ process_cr_params ] cart:', cart);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.scrape_subtotal = function () {
			try {
				var subtotal = document.querySelector(".order-summary .sub-total");
				if (subtotal != null) {
					subtotal = usi_dom.string_to_decimal(subtotal.textContent).toFixed(2);
					return subtotal;
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.scrape_cart = function () {
			try {
				var cart_rows = usi_dom.get_elements('.cart-page .product-info-wrapper');
				var items = [], product;
				cart_rows.forEach(function (container) {
					product = {};

					var name_el = container.querySelector(".line-item-name a");
					if (name_el) {
						product.link = name_el.href;
						product.name = name_el.textContent.trim();
					}

					var pic_el = container.querySelector("img.product-image");
					if (pic_el) {
						product.pic = pic_el.src;
					}

					var price_el = container.querySelector(".line-item-each-price .value");
					if (price_el && usi_dom.string_to_decimal(price_el.textContent)) {
						product.price = usi_dom.string_to_decimal(price_el.textContent).toFixed(2);
					}

					var qty_el = container.querySelector("input.quantity-val");
					if (qty_el) {
						product.qty = qty_el.value;
					}

					var remove_el = container.querySelector("button.remove-product");
					if (remove_el) {
						product.pid = remove_el.getAttribute('data-pid');
					}

					if (product.name && product.pic && product.price && product.qty && product.pid) {
						items.push(product);
					}
				});
				return items;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		// --------------------------------------------------------------------------
		// --------------------------------------------------------------------------
		// ----------------------------- CART REBUILDER -----------------------------
		// --------------------------------------------------------------------------
		// --------------------------------------------------------------------------
		// <editor-fold desc="* * * CART REBUILDER * * *">
		usi_app.setup_listener = function (url, callback) {
			try {
				usi_app.ajaxListener = new usi_ajax.listener();
				usi_app.ajaxListener.register('POST', url, callback);
				usi_app.ajaxListener.listen();
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.handle_ajax_response = function (err, response) {
			try {
				if (response) {
					// Record params for cart rebuilder
					if (response.requestObj && response.requestObj.params) usi_app.record_cart_rebuilder_params(response.requestObj.params);
				} else {
					usi_commons.report_error(err);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.record_cart_rebuilder_params = function (params) {
			try {
				// Remove unused params & extract pid
				var params_arr = params.split('&');
				var params_clean = [];
				var pid = '';
				var qty = '1';
				params_arr.forEach(function (el) {
					if (el.indexOf('quantity=') !== -1) {
						qty = el.split("=")[1];
					} else {
						if (el.indexOf('pid=') !== -1) pid = el.split("=")[1];
						params_clean.push(el);
					}
				});
				params = params_clean.join('&');
				usi_commons.log('[ record_cart_rebuilder_params ] pid:', pid);

				if (pid) {

					// Fetch original cart
					var cart = usi_cookies.get("usi_cart") || '';
					if (cart) {
						var cart_arr = cart.split('|'), found = false;
						for (var i = 0; i < cart_arr.length; i++) {
							var head = cart_arr[i].split('~')[0];
							var body = cart_arr[i].split('~')[1];
							var head_arr = head.split('@');
							if (head_arr[0] == pid) {
								// Update qty
								head_arr[1] = qty;
								cart_arr[i] = head_arr.join('@') + body;
								found = true;
								break;
							}
						}
						if (!found) cart_arr.push(pid + '@' + qty + '~' + params);
						cart = cart_arr.join('|');
					} else {
						cart = pid + '@' + qty + '~' + params;
					}

					// Save new cart
					usi_cookies.set("usi_cart", cart, usi_cookies.expire_time.week);
					usi_commons.log('[ record_cart_rebuilder_params ] cart:', cart);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.rebuild = function (err, response) {
			try {
				if (response) {

					usi_commons.log('[ rebuild ] ====================');
					usi_commons.log('[ rebuild ] === REBUILD CART ===');
					usi_commons.log('[ rebuild ] ====================');
					usi_commons.log(response);

					// Extract params
					var params_arr = [];
					var cart_string = response['usi_cart'];
					if (cart_string) {
						var cart_arr = cart_string.split('|');
						var qty = "1";
						cart_arr.forEach(function (el) {
							// Extract quantity
							var el_arr = el.split('~');
							qty = el_arr[0].split('@')[1];
							params_arr.push(el_arr[1] + '&quantity=' + qty);
						});
					}

					// Rebuild
					if (params_arr.length > 0) {
						usi_app.rebuild_cart(params_arr, 0, function () {
							usi_cookies.set("usi_suppress_cr", '1', usi_cookies.expire_time.minute * 5, true);
							setTimeout(function () {
								location.href = "https://pcrs.rv8crv.net/c/16669/674905/10458?u=" + encodeURIComponent(location.href.split('?')[0]);
							}, 500);
						});
					}

				} else {
					usi_commons.report_error(err);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.rebuild_cart = function (params_arr, idx, cb) {
			try {
				// Exit condition
				var params = params_arr[idx];
				if (!params) {
					cb();
					return
				}

				// Add items to cart
				usi_commons.log('[ rebuild ] params', params);
				var url = "https://www.pcrichard.com/on/demandware.store/Sites-PCRichard-Site/default/Cart-AddProduct";
				var xhr = new XMLHttpRequest();
				xhr.open("POST", url, true);
				xhr.setRequestHeader("accept", "*/*");
				xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
				xhr.withCredentials = true;
				xhr.onreadystatechange = function () {
					if (xhr.readyState === 4) {
						// Add the next item
						setTimeout(function () {
							usi_app.rebuild_cart(params_arr, idx + 1, cb);
						}, 500);
					}
				};
				xhr.send(params);
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		// </editor-fold>

		usi_app.send_product_data = function () {
			try {
				var current_prod = usi_app.scrape_product_page();
				usi_commons.log('[ send_product_data ] current_prod:', current_prod);
				if (current_prod && current_prod.pid && current_prod.price && current_prod.name && current_prod.image && current_prod.extra) {
					var real_time = current_prod.extra.indexOf('outofstock') !== -1 || usi_app.real_time;
					usi_commons.log('[ send_product_data ] real_time:', real_time);
					usi_commons.send_prod_rec(usi_app.recommendation_site_product, current_prod, real_time);
				} else {
					usi_commons.log_error('[ send_product_data ] Missing required params');
				}
				return current_prod;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.scrape_product_page = function () {
			try {
				var product = {};
				product.link = location.protocol + '//' + location.host + location.pathname;

				var category = '';
				if (window['pageData']) {
					category = window['pageData']['pageCategory'];
				}

				var pid_el = document.querySelector('.product-details-main .product-id');
				if (pid_el) {
					product.pid = pid_el.textContent.trim();
				}

				var price_el = document.querySelector('.product-details-main .prices-and-promos .price .value');
				if (price_el && price_el.getAttribute('content')) {
					product.price = price_el.getAttribute('content');
				}

				var name_el = document.querySelector('.product-details-main .product-name');
				if (name_el) {
					product.name = name_el.textContent.trim();
				}

				var image_el = document.querySelector('.product-details-main .img-container .main-image');
				if (image_el) {
					product.image = image_el.src;
				}

				// Special prices
				if (product.pid === 'OLED55A1PUA') {
					product.price = '799.96';
					// usi_app.real_time = true;
				} else if (product.pid === 'OLED65A1PUA') {
					product.price = '999.96';
					// usi_app.real_time = true;
				} else if (product.pid === 'OLED77A1PUA') {
					product.price = '1999.96';
					// usi_app.real_time = true;
				}

				product.in_stock = document.querySelector(".cart-and-ipay button.add-to-cart") !== null;
				product.extra = JSON.stringify({
					stock: product.in_stock ? "INSTOCK" : "OUTOFSTOCK",
					category: category
				});
				return product;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.load_product_data = function (options) {
			try {
				var queryStr = "";
				var params = ['siteID', 'association_siteID', 'pid', 'less_expensive', 'rows', 'days_back', 'match', 'nomatch', 'force_exact'];
				params.forEach(function(name, index){
					if (options[name]) {
						queryStr += (index == 0 ? "?" : "&") + name + '=' + options[name];
					}
				});
				usi_commons.load_script(usi_commons.cdn + '/utility/product_recommendations.jsp' + queryStr, function(){
					if (typeof options.callback === 'function' && typeof usi_app.product_rec !== 'undefined') {
						options.callback(usi_app.product_rec);
					}
				});
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_dom.ready(function () {
			try {
				usi_app.main();
			} catch (err) {
				usi_commons.report_error(err);
			}
		});
	} catch (err) {
		usi_commons.report_error(err);
	}
}
