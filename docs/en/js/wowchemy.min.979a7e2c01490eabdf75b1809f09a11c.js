(() => {
  // en/js/wowchemy.min.js
  /*! Wowchemy v5.0.0-beta.3 | https://wowchemy.com/ */
  /*! Copyright 2016-present George Cushen (https://georgecushen.com/) */
  /*! License: https://github.com/wowchemy/wowchemy-hugo-modules/blob/main/LICENSE.md */
  (() => {
    /*!medium-zoom 1.0.6 | MIT License | https://github.com/francoischalifour/medium-zoom*/
    var _extends = Object.assign || function(target) {
      for (var i = 1; i < arguments.length; i++) {
        var source = arguments[i];
        for (var key in source) {
          if (Object.prototype.hasOwnProperty.call(source, key)) {
            target[key] = source[key];
          }
        }
      }
      return target;
    };
    var isSupported = function isSupported2(node) {
      return node.tagName === "IMG";
    };
    var isNodeList = function isNodeList2(selector) {
      return NodeList.prototype.isPrototypeOf(selector);
    };
    var isNode = function isNode2(selector) {
      return selector && selector.nodeType === 1;
    };
    var isSvg = function isSvg2(image) {
      var source = image.currentSrc || image.src;
      return source.substr(-4).toLowerCase() === ".svg";
    };
    var getImagesFromSelector = function getImagesFromSelector2(selector) {
      try {
        if (Array.isArray(selector)) {
          return selector.filter(isSupported);
        }
        if (isNodeList(selector)) {
          return [].slice.call(selector).filter(isSupported);
        }
        if (isNode(selector)) {
          return [selector].filter(isSupported);
        }
        if (typeof selector === "string") {
          return [].slice.call(document.querySelectorAll(selector)).filter(isSupported);
        }
        return [];
      } catch (err) {
        throw new TypeError("The provided selector is invalid.\nExpects a CSS selector, a Node element, a NodeList or an array.\nSee: https://github.com/francoischalifour/medium-zoom");
      }
    };
    var createOverlay = function createOverlay2(background) {
      var overlay = document.createElement("div");
      overlay.classList.add("medium-zoom-overlay");
      overlay.style.background = background;
      return overlay;
    };
    var cloneTarget = function cloneTarget2(template) {
      var _template$getBounding = template.getBoundingClientRect(), top = _template$getBounding.top, left = _template$getBounding.left, width = _template$getBounding.width, height = _template$getBounding.height;
      var clone = template.cloneNode();
      var scrollTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0;
      var scrollLeft = window.pageXOffset || document.documentElement.scrollLeft || document.body.scrollLeft || 0;
      clone.removeAttribute("id");
      clone.style.position = "absolute";
      clone.style.top = top + scrollTop + "px";
      clone.style.left = left + scrollLeft + "px";
      clone.style.width = width + "px";
      clone.style.height = height + "px";
      clone.style.transform = "";
      return clone;
    };
    var createCustomEvent = function createCustomEvent2(type, params2) {
      var eventParams = _extends({bubbles: false, cancelable: false, detail: void 0}, params2);
      if (typeof window.CustomEvent === "function") {
        return new CustomEvent(type, eventParams);
      }
      var customEvent = document.createEvent("CustomEvent");
      customEvent.initCustomEvent(type, eventParams.bubbles, eventParams.cancelable, eventParams.detail);
      return customEvent;
    };
    var mediumZoomEsm = function mediumZoom(selector) {
      var options = arguments.length > 1 && arguments[1] !== void 0 ? arguments[1] : {};
      var Promise2 = window.Promise || function Promise3(fn) {
        function noop() {
        }
        fn(noop, noop);
      };
      var _handleClick = function _handleClick2(event) {
        var target = event.target;
        if (target === overlay) {
          close();
          return;
        }
        if (images.indexOf(target) === -1) {
          return;
        }
        toggle({target});
      };
      var _handleScroll = function _handleScroll2() {
        if (isAnimating || !active.original) {
          return;
        }
        var currentScroll = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0;
        if (Math.abs(scrollTop - currentScroll) > zoomOptions.scrollOffset) {
          setTimeout(close, 150);
        }
      };
      var _handleKeyUp = function _handleKeyUp2(event) {
        var key = event.key || event.keyCode;
        if (key === "Escape" || key === "Esc" || key === 27) {
          close();
        }
      };
      var update = function update2() {
        var options2 = arguments.length > 0 && arguments[0] !== void 0 ? arguments[0] : {};
        var newOptions = options2;
        if (options2.background) {
          overlay.style.background = options2.background;
        }
        if (options2.container && options2.container instanceof Object) {
          newOptions.container = _extends({}, zoomOptions.container, options2.container);
        }
        if (options2.template) {
          var template = isNode(options2.template) ? options2.template : document.querySelector(options2.template);
          newOptions.template = template;
        }
        zoomOptions = _extends({}, zoomOptions, newOptions);
        images.forEach(function(image) {
          image.dispatchEvent(createCustomEvent("medium-zoom:update", {detail: {zoom}}));
        });
        return zoom;
      };
      var clone = function clone2() {
        var options2 = arguments.length > 0 && arguments[0] !== void 0 ? arguments[0] : {};
        return mediumZoomEsm(_extends({}, zoomOptions, options2));
      };
      var attach = function attach2() {
        for (var _len = arguments.length, selectors = Array(_len), _key = 0; _key < _len; _key++) {
          selectors[_key] = arguments[_key];
        }
        var newImages = selectors.reduce(function(imagesAccumulator, currentSelector) {
          return [].concat(imagesAccumulator, getImagesFromSelector(currentSelector));
        }, []);
        newImages.filter(function(newImage) {
          return images.indexOf(newImage) === -1;
        }).forEach(function(newImage) {
          images.push(newImage);
          newImage.classList.add("medium-zoom-image");
        });
        eventListeners.forEach(function(_ref) {
          var type = _ref.type, listener = _ref.listener, options2 = _ref.options;
          newImages.forEach(function(image) {
            image.addEventListener(type, listener, options2);
          });
        });
        return zoom;
      };
      var detach = function detach2() {
        for (var _len2 = arguments.length, selectors = Array(_len2), _key2 = 0; _key2 < _len2; _key2++) {
          selectors[_key2] = arguments[_key2];
        }
        if (active.zoomed) {
          close();
        }
        var imagesToDetach = selectors.length > 0 ? selectors.reduce(function(imagesAccumulator, currentSelector) {
          return [].concat(imagesAccumulator, getImagesFromSelector(currentSelector));
        }, []) : images;
        imagesToDetach.forEach(function(image) {
          image.classList.remove("medium-zoom-image");
          image.dispatchEvent(createCustomEvent("medium-zoom:detach", {detail: {zoom}}));
        });
        images = images.filter(function(image) {
          return imagesToDetach.indexOf(image) === -1;
        });
        return zoom;
      };
      var on = function on2(type, listener) {
        var options2 = arguments.length > 2 && arguments[2] !== void 0 ? arguments[2] : {};
        images.forEach(function(image) {
          image.addEventListener("medium-zoom:" + type, listener, options2);
        });
        eventListeners.push({type: "medium-zoom:" + type, listener, options: options2});
        return zoom;
      };
      var off = function off2(type, listener) {
        var options2 = arguments.length > 2 && arguments[2] !== void 0 ? arguments[2] : {};
        images.forEach(function(image) {
          image.removeEventListener("medium-zoom:" + type, listener, options2);
        });
        eventListeners = eventListeners.filter(function(eventListener) {
          return !(eventListener.type === "medium-zoom:" + type && eventListener.listener.toString() === listener.toString());
        });
        return zoom;
      };
      var open = function open2() {
        var _ref2 = arguments.length > 0 && arguments[0] !== void 0 ? arguments[0] : {}, target = _ref2.target;
        var _animate = function _animate2() {
          var container = {width: document.documentElement.clientWidth, height: document.documentElement.clientHeight, left: 0, top: 0, right: 0, bottom: 0};
          var viewportWidth = void 0;
          var viewportHeight = void 0;
          if (zoomOptions.container) {
            if (zoomOptions.container instanceof Object) {
              container = _extends({}, container, zoomOptions.container);
              viewportWidth = container.width - container.left - container.right - zoomOptions.margin * 2;
              viewportHeight = container.height - container.top - container.bottom - zoomOptions.margin * 2;
            } else {
              var zoomContainer = isNode(zoomOptions.container) ? zoomOptions.container : document.querySelector(zoomOptions.container);
              var _zoomContainer$getBou = zoomContainer.getBoundingClientRect(), _width = _zoomContainer$getBou.width, _height = _zoomContainer$getBou.height, _left = _zoomContainer$getBou.left, _top = _zoomContainer$getBou.top;
              container = _extends({}, container, {width: _width, height: _height, left: _left, top: _top});
            }
          }
          viewportWidth = viewportWidth || container.width - zoomOptions.margin * 2;
          viewportHeight = viewportHeight || container.height - zoomOptions.margin * 2;
          var zoomTarget = active.zoomedHd || active.original;
          var naturalWidth = isSvg(zoomTarget) ? viewportWidth : zoomTarget.naturalWidth || viewportWidth;
          var naturalHeight = isSvg(zoomTarget) ? viewportHeight : zoomTarget.naturalHeight || viewportHeight;
          var _zoomTarget$getBoundi = zoomTarget.getBoundingClientRect(), top = _zoomTarget$getBoundi.top, left = _zoomTarget$getBoundi.left, width = _zoomTarget$getBoundi.width, height = _zoomTarget$getBoundi.height;
          var scaleX = Math.min(naturalWidth, viewportWidth) / width;
          var scaleY = Math.min(naturalHeight, viewportHeight) / height;
          var scale = Math.min(scaleX, scaleY);
          var translateX = (-left + (viewportWidth - width) / 2 + zoomOptions.margin + container.left) / scale;
          var translateY = (-top + (viewportHeight - height) / 2 + zoomOptions.margin + container.top) / scale;
          var transform = "scale(" + scale + ") translate3d(" + translateX + "px, " + translateY + "px, 0)";
          active.zoomed.style.transform = transform;
          if (active.zoomedHd) {
            active.zoomedHd.style.transform = transform;
          }
        };
        return new Promise2(function(resolve) {
          if (target && images.indexOf(target) === -1) {
            resolve(zoom);
            return;
          }
          var _handleOpenEnd = function _handleOpenEnd2() {
            isAnimating = false;
            active.zoomed.removeEventListener("transitionend", _handleOpenEnd2);
            active.original.dispatchEvent(createCustomEvent("medium-zoom:opened", {detail: {zoom}}));
            resolve(zoom);
          };
          if (active.zoomed) {
            resolve(zoom);
            return;
          }
          if (target) {
            active.original = target;
          } else if (images.length > 0) {
            var _images = images;
            active.original = _images[0];
          } else {
            resolve(zoom);
            return;
          }
          active.original.dispatchEvent(createCustomEvent("medium-zoom:open", {detail: {zoom}}));
          scrollTop = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0;
          isAnimating = true;
          active.zoomed = cloneTarget(active.original);
          document.body.appendChild(overlay);
          if (zoomOptions.template) {
            var template = isNode(zoomOptions.template) ? zoomOptions.template : document.querySelector(zoomOptions.template);
            active.template = document.createElement("div");
            active.template.appendChild(template.content.cloneNode(true));
            document.body.appendChild(active.template);
          }
          document.body.appendChild(active.zoomed);
          window.requestAnimationFrame(function() {
            document.body.classList.add("medium-zoom--opened");
          });
          active.original.classList.add("medium-zoom-image--hidden");
          active.zoomed.classList.add("medium-zoom-image--opened");
          active.zoomed.addEventListener("click", close);
          active.zoomed.addEventListener("transitionend", _handleOpenEnd);
          if (active.original.getAttribute("data-zoom-src")) {
            active.zoomedHd = active.zoomed.cloneNode();
            active.zoomedHd.removeAttribute("srcset");
            active.zoomedHd.removeAttribute("sizes");
            active.zoomedHd.src = active.zoomed.getAttribute("data-zoom-src");
            active.zoomedHd.onerror = function() {
              clearInterval(getZoomTargetSize);
              console.warn("Unable to reach the zoom image target " + active.zoomedHd.src);
              active.zoomedHd = null;
              _animate();
            };
            var getZoomTargetSize = setInterval(function() {
              if (active.zoomedHd.complete) {
                clearInterval(getZoomTargetSize);
                active.zoomedHd.classList.add("medium-zoom-image--opened");
                active.zoomedHd.addEventListener("click", close);
                document.body.appendChild(active.zoomedHd);
                _animate();
              }
            }, 10);
          } else if (active.original.hasAttribute("srcset")) {
            active.zoomedHd = active.zoomed.cloneNode();
            active.zoomedHd.removeAttribute("sizes");
            active.zoomedHd.removeAttribute("loading");
            var loadEventListener = active.zoomedHd.addEventListener("load", function() {
              active.zoomedHd.removeEventListener("load", loadEventListener);
              active.zoomedHd.classList.add("medium-zoom-image--opened");
              active.zoomedHd.addEventListener("click", close);
              document.body.appendChild(active.zoomedHd);
              _animate();
            });
          } else {
            _animate();
          }
        });
      };
      var close = function close2() {
        return new Promise2(function(resolve) {
          if (isAnimating || !active.original) {
            resolve(zoom);
            return;
          }
          var _handleCloseEnd = function _handleCloseEnd2() {
            active.original.classList.remove("medium-zoom-image--hidden");
            document.body.removeChild(active.zoomed);
            if (active.zoomedHd) {
              document.body.removeChild(active.zoomedHd);
            }
            document.body.removeChild(overlay);
            active.zoomed.classList.remove("medium-zoom-image--opened");
            if (active.template) {
              document.body.removeChild(active.template);
            }
            isAnimating = false;
            active.zoomed.removeEventListener("transitionend", _handleCloseEnd2);
            active.original.dispatchEvent(createCustomEvent("medium-zoom:closed", {detail: {zoom}}));
            active.original = null;
            active.zoomed = null;
            active.zoomedHd = null;
            active.template = null;
            resolve(zoom);
          };
          isAnimating = true;
          document.body.classList.remove("medium-zoom--opened");
          active.zoomed.style.transform = "";
          if (active.zoomedHd) {
            active.zoomedHd.style.transform = "";
          }
          if (active.template) {
            active.template.style.transition = "opacity 150ms";
            active.template.style.opacity = 0;
          }
          active.original.dispatchEvent(createCustomEvent("medium-zoom:close", {detail: {zoom}}));
          active.zoomed.addEventListener("transitionend", _handleCloseEnd);
        });
      };
      var toggle = function toggle2() {
        var _ref3 = arguments.length > 0 && arguments[0] !== void 0 ? arguments[0] : {}, target = _ref3.target;
        if (active.original) {
          return close();
        }
        return open({target});
      };
      var getOptions = function getOptions2() {
        return zoomOptions;
      };
      var getImages = function getImages2() {
        return images;
      };
      var getZoomedImage = function getZoomedImage2() {
        return active.original;
      };
      var images = [];
      var eventListeners = [];
      var isAnimating = false;
      var scrollTop = 0;
      var zoomOptions = options;
      var active = {original: null, zoomed: null, zoomedHd: null, template: null};
      if (Object.prototype.toString.call(selector) === "[object Object]") {
        zoomOptions = selector;
      } else if (selector || typeof selector === "string") {
        attach(selector);
      }
      zoomOptions = _extends({margin: 0, background: "#fff", scrollOffset: 40, container: null, template: null}, zoomOptions);
      var overlay = createOverlay(zoomOptions.background);
      document.addEventListener("click", _handleClick);
      document.addEventListener("keyup", _handleKeyUp);
      document.addEventListener("scroll", _handleScroll);
      window.addEventListener("resize", close);
      var zoom = {open, close, toggle, update, clone, attach, detach, on, off, getOptions, getImages, getZoomedImage};
      return zoom;
    };
    function styleInject(css2, ref) {
      if (ref === void 0)
        ref = {};
      var insertAt = ref.insertAt;
      if (!css2 || typeof document === "undefined") {
        return;
      }
      var head = document.head || document.getElementsByTagName("head")[0];
      var style = document.createElement("style");
      style.type = "text/css";
      if (insertAt === "top") {
        if (head.firstChild) {
          head.insertBefore(style, head.firstChild);
        } else {
          head.appendChild(style);
        }
      } else {
        head.appendChild(style);
      }
      if (style.styleSheet) {
        style.styleSheet.cssText = css2;
      } else {
        style.appendChild(document.createTextNode(css2));
      }
    }
    var css = ".medium-zoom-overlay{position:fixed;top:0;right:0;bottom:0;left:0;opacity:0;transition:opacity .3s;will-change:opacity}.medium-zoom--opened .medium-zoom-overlay{cursor:pointer;cursor:zoom-out;opacity:1}.medium-zoom-image{cursor:pointer;cursor:zoom-in;transition:transform .3s cubic-bezier(.2,0,.2,1)!important}.medium-zoom-image--hidden{visibility:hidden}.medium-zoom-image--opened{position:relative;cursor:pointer;cursor:zoom-out;will-change:transform}";
    styleInject(css);
    var medium_zoom_esm_default = mediumZoomEsm;
    var codeHighlighting = false;
    var hugoEnvironment = "production";
    var searchEnabled = true;
    function fixMermaid(render = false) {
      let mermaids = [];
      [].push.apply(mermaids, document.getElementsByClassName("language-mermaid"));
      for (let i = 0; i < mermaids.length; i++) {
        let mermaidCodeElement = mermaids[i];
        let newElement = document.createElement("div");
        newElement.innerHTML = mermaidCodeElement.innerHTML;
        newElement.classList.add("mermaid");
        if (render) {
          window.mermaid.mermaidAPI.render(`mermaid-${i}`, newElement.textContent, function(svgCode) {
            newElement.innerHTML = svgCode;
          });
        }
        mermaidCodeElement.parentNode.replaceWith(newElement);
      }
      console.debug(`Processed ${mermaids.length} Mermaid code blocks`);
    }
    function scrollParentToChild(parent, child) {
      const parentRect = parent.getBoundingClientRect();
      const parentViewableArea = {height: parent.clientHeight, width: parent.clientWidth};
      const childRect = child.getBoundingClientRect();
      const isChildInView = childRect.top >= parentRect.top && childRect.bottom <= parentRect.top + parentViewableArea.height;
      if (!isChildInView) {
        parent.scrollTop = childRect.top + parent.scrollTop - parentRect.top;
      }
    }
    function fadeIn(element, duration = 600) {
      element.style.display = "";
      element.style.opacity = "0";
      let last = +new Date();
      let tick = function() {
        element.style.opacity = (+element.style.opacity + (new Date() - last) / duration).toString();
        last = +new Date();
        if (+element.style.opacity < 1) {
          window.requestAnimationFrame && requestAnimationFrame(tick) || setTimeout(tick, 16);
        }
      };
      tick();
    }
    var body = document.body;
    function getThemeMode() {
      return parseInt(localStorage.getItem("wcTheme") || 2);
    }
    function canChangeTheme() {
      return Boolean(window.wc.darkLightEnabled);
    }
    function initThemeVariation() {
      if (!canChangeTheme()) {
        console.debug("User theming disabled.");
        return {isDarkTheme: window.wc.isSiteThemeDark, themeMode: window.wc.isSiteThemeDark ? 1 : 0};
      }
      console.debug("User theming enabled.");
      let isDarkTheme;
      let currentThemeMode = getThemeMode();
      console.debug(`User's theme variation: ${currentThemeMode}`);
      switch (currentThemeMode) {
        case 0:
          isDarkTheme = false;
          break;
        case 1:
          isDarkTheme = true;
          break;
        default:
          if (window.matchMedia("(prefers-color-scheme: dark)").matches) {
            isDarkTheme = true;
          } else if (window.matchMedia("(prefers-color-scheme: light)").matches) {
            isDarkTheme = false;
          } else {
            isDarkTheme = window.wc.isSiteThemeDark;
          }
          break;
      }
      if (isDarkTheme && !body.classList.contains("dark")) {
        console.debug("Applying Wowchemy dark theme");
        document.body.classList.add("dark");
      } else if (!isDarkTheme && body.classList.contains("dark")) {
        console.debug("Applying Wowchemy light theme");
        document.body.classList.remove("dark");
      }
      return {isDarkTheme, themeMode: currentThemeMode};
    }
    function changeThemeModeClick(newMode) {
      if (!canChangeTheme()) {
        console.debug("Cannot change theme - user theming disabled.");
        return;
      }
      let isDarkTheme;
      switch (newMode) {
        case 0:
          localStorage.setItem("wcTheme", "0");
          isDarkTheme = false;
          console.debug("User changed theme variation to Light.");
          break;
        case 1:
          localStorage.setItem("wcTheme", "1");
          isDarkTheme = true;
          console.debug("User changed theme variation to Dark.");
          break;
        default:
          localStorage.setItem("wcTheme", "2");
          if (window.matchMedia("(prefers-color-scheme: dark)").matches) {
            isDarkTheme = true;
          } else if (window.matchMedia("(prefers-color-scheme: light)").matches) {
            isDarkTheme = false;
          } else {
            isDarkTheme = window.wc.isSiteThemeDark;
          }
          console.debug("User changed theme variation to Auto.");
          break;
      }
      renderThemeVariation(isDarkTheme, newMode);
    }
    function showActiveTheme(mode) {
      let linkLight2 = document.querySelector(".js-set-theme-light");
      let linkDark2 = document.querySelector(".js-set-theme-dark");
      let linkAuto2 = document.querySelector(".js-set-theme-auto");
      if (linkLight2 === null) {
        return;
      }
      switch (mode) {
        case 0:
          linkLight2.classList.add("dropdown-item-active");
          linkDark2.classList.remove("dropdown-item-active");
          linkAuto2.classList.remove("dropdown-item-active");
          break;
        case 1:
          linkLight2.classList.remove("dropdown-item-active");
          linkDark2.classList.add("dropdown-item-active");
          linkAuto2.classList.remove("dropdown-item-active");
          break;
        default:
          linkLight2.classList.remove("dropdown-item-active");
          linkDark2.classList.remove("dropdown-item-active");
          linkAuto2.classList.add("dropdown-item-active");
          break;
      }
    }
    function renderThemeVariation(isDarkTheme, themeMode = 2, init = false) {
      const codeHlLight = document.querySelector("link[title=hl-light]");
      const codeHlDark = document.querySelector("link[title=hl-dark]");
      const codeHlEnabled = codeHlLight !== null || codeHlDark !== null;
      const diagramEnabled = document.querySelector("script[title=mermaid]") !== null;
      showActiveTheme(themeMode);
      const themeChangeEvent = new CustomEvent("wcThemeChange", {detail: {isDarkTheme: () => isDarkTheme}});
      document.dispatchEvent(themeChangeEvent);
      if (!init) {
        if (isDarkTheme === false && !body.classList.contains("dark") || isDarkTheme === true && body.classList.contains("dark")) {
          return;
        }
      }
      if (isDarkTheme === false) {
        if (!init) {
          Object.assign(document.body.style, {opacity: 0, visibility: "visible"});
          fadeIn(document.body, 600);
        }
        body.classList.remove("dark");
        if (codeHlEnabled) {
          console.debug("Setting HLJS theme to light");
          if (codeHlLight) {
            codeHlLight.disabled = false;
          }
          if (codeHlDark) {
            codeHlDark.disabled = true;
          }
        }
        if (diagramEnabled) {
          console.debug("Initializing Mermaid with light theme");
          if (init) {
            window.mermaid.initialize({startOnLoad: false, theme: "default", securityLevel: "loose"});
            fixMermaid(true);
          } else {
            location.reload();
          }
        }
      } else if (isDarkTheme === true) {
        if (!init) {
          Object.assign(document.body.style, {opacity: 0, visibility: "visible"});
          fadeIn(document.body, 600);
        }
        body.classList.add("dark");
        if (codeHlEnabled) {
          console.debug("Setting HLJS theme to dark");
          if (codeHlLight) {
            codeHlLight.disabled = true;
          }
          if (codeHlDark) {
            codeHlDark.disabled = false;
          }
        }
        if (diagramEnabled) {
          console.debug("Initializing Mermaid with dark theme");
          if (init) {
            window.mermaid.initialize({startOnLoad: false, theme: "dark", securityLevel: "loose"});
            fixMermaid(true);
          } else {
            location.reload();
          }
        }
      }
    }
    function onMediaQueryListEvent(event) {
      if (!canChangeTheme()) {
        return;
      }
      const darkModeOn = event.matches;
      console.debug(`OS dark mode preference changed to ${darkModeOn ? "\u{1F312} on" : "\u2600\uFE0F off"}.`);
      let currentThemeVariation = getThemeMode();
      let isDarkTheme;
      if (currentThemeVariation === 2) {
        if (window.matchMedia("(prefers-color-scheme: dark)").matches) {
          isDarkTheme = true;
        } else if (window.matchMedia("(prefers-color-scheme: light)").matches) {
          isDarkTheme = false;
        } else {
          isDarkTheme = window.wc.isSiteThemeDark;
        }
        renderThemeVariation(isDarkTheme, currentThemeVariation);
      }
    }
    console.debug(`Environment: ${hugoEnvironment}`);
    function getNavBarHeight() {
      let $navbar = $("#navbar-main");
      let navbar_offset = $navbar.outerHeight();
      console.debug("Navbar height: " + navbar_offset);
      return navbar_offset;
    }
    function scrollToAnchor(target, duration = 0) {
      target = typeof target === "undefined" || typeof target === "object" ? decodeURIComponent(window.location.hash) : target;
      if ($(target).length) {
        target = "#" + $.escapeSelector(target.substring(1));
        let elementOffset = Math.ceil($(target).offset().top - getNavBarHeight());
        $("body").addClass("scrolling");
        $("html, body").animate({scrollTop: elementOffset}, duration, function() {
          $("body").removeClass("scrolling");
        });
      } else {
        console.debug("Cannot scroll to target `#" + target + "`. ID not found!");
      }
    }
    function fixScrollspy() {
      let $body = $("body");
      let data = $body.data("bs.scrollspy");
      if (data) {
        data._config.offset = getNavBarHeight();
        $body.data("bs.scrollspy", data);
        $body.scrollspy("refresh");
      }
    }
    function removeQueryParamsFromUrl() {
      if (window.history.replaceState) {
        let urlWithoutSearchParams = window.location.protocol + "//" + window.location.host + window.location.pathname + window.location.hash;
        window.history.replaceState({path: urlWithoutSearchParams}, "", urlWithoutSearchParams);
      }
    }
    window.addEventListener("hashchange", scrollToAnchor);
    $("#navbar-main li.nav-item a.nav-link, .js-scroll").on("click", function(event) {
      let hash = this.hash;
      if (this.pathname === window.location.pathname && hash && $(hash).length && $(".js-widget-page").length > 0) {
        event.preventDefault();
        let elementOffset = Math.ceil($(hash).offset().top - getNavBarHeight());
        $("html, body").animate({scrollTop: elementOffset}, 800);
      }
    });
    $(document).on("click", ".navbar-collapse.show", function(e) {
      let targetElement = $(e.target).is("a") ? $(e.target) : $(e.target).parent();
      if (targetElement.is("a") && targetElement.attr("class") != "dropdown-toggle") {
        $(this).collapse("hide");
      }
    });
    var pubFilters = {};
    var searchRegex;
    var filterValues;
    var $grid_pubs = $("#container-publications");
    if ($grid_pubs.length) {
      $grid_pubs.isotope({itemSelector: ".isotope-item", percentPosition: true, masonry: {columnWidth: ".grid-sizer"}, filter: function() {
        let $this = $(this);
        let searchResults = searchRegex ? $this.text().match(searchRegex) : true;
        let filterResults = filterValues ? $this.is(filterValues) : true;
        return searchResults && filterResults;
      }});
      let $quickSearch = $(".filter-search").keyup(debounce(function() {
        searchRegex = new RegExp($quickSearch.val(), "gi");
        $grid_pubs.isotope();
      }));
      $(".pub-filters").on("change", function() {
        let $this = $(this);
        let filterGroup = $this[0].getAttribute("data-filter-group");
        pubFilters[filterGroup] = this.value;
        filterValues = concatValues(pubFilters);
        $grid_pubs.isotope();
        if (filterGroup === "pubtype") {
          let url = $(this).val();
          if (url.substr(0, 9) === ".pubtype-") {
            window.location.hash = url.substr(9);
          } else {
            window.location.hash = "";
          }
        }
      });
    }
    function debounce(fn, threshold) {
      let timeout;
      threshold = threshold || 100;
      return function debounced() {
        clearTimeout(timeout);
        let args = arguments;
        let _this = this;
        function delayed() {
          fn.apply(_this, args);
        }
        timeout = setTimeout(delayed, threshold);
      };
    }
    function concatValues(obj) {
      let value = "";
      for (let prop in obj) {
        value += obj[prop];
      }
      return value;
    }
    function filter_publications() {
      if (!$grid_pubs.length)
        return;
      let urlHash = window.location.hash.replace("#", "");
      let filterValue = "*";
      if (urlHash != "" && !isNaN(urlHash)) {
        filterValue = ".pubtype-" + urlHash;
      }
      let filterGroup = "pubtype";
      pubFilters[filterGroup] = filterValue;
      filterValues = concatValues(pubFilters);
      $grid_pubs.isotope();
      $(".pubtype-select").val(filterValue);
    }
    function initMap() {
      if ($("#map").length) {
        let map_provider = $("#map-provider").val();
        let lat = $("#map-lat").val();
        let lng = $("#map-lng").val();
        let zoom = parseInt($("#map-zoom").val());
        let address = $("#map-dir").val();
        let api_key = $("#map-api-key").val();
        if (map_provider === "google") {
          let map = new GMaps({div: "#map", lat, lng, zoom, zoomControl: true, zoomControlOpt: {style: "SMALL", position: "TOP_LEFT"}, streetViewControl: false, mapTypeControl: false, gestureHandling: "cooperative"});
          map.addMarker({lat, lng, click: function() {
            let url = "https://www.google.com/maps/place/" + encodeURIComponent(address) + "/@" + lat + "," + lng + "/";
            window.open(url, "_blank");
          }, title: address});
        } else {
          let map = new L.map("map").setView([lat, lng], zoom);
          if (map_provider === "mapbox" && api_key.length) {
            L.tileLayer("https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}", {attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery \xA9 <a href="http://mapbox.com">Mapbox</a>', tileSize: 512, maxZoom: 18, zoomOffset: -1, id: "mapbox/streets-v11", accessToken: api_key}).addTo(map);
          } else {
            L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {maxZoom: 19, attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'}).addTo(map);
          }
          let marker = L.marker([lat, lng]).addTo(map);
          let url = lat + "," + lng + "#map=" + zoom + "/" + lat + "/" + lng + "&layers=N";
          marker.bindPopup(address + '<p><a href="https://www.openstreetmap.org/directions?engine=osrm_car&route=' + url + '">Routing via OpenStreetMap</a></p>');
        }
      }
    }
    function printLatestRelease(selector, repo) {
      if (hugoEnvironment === "production") {
        $.getJSON("https://api.github.com/repos/" + repo + "/tags").done(function(json) {
          let release = json[0];
          $(selector).append(" " + release.name);
        }).fail(function(jqxhr, textStatus, error) {
          let err = textStatus + ", " + error;
          console.log("Request Failed: " + err);
        });
      }
    }
    function toggleSearchDialog() {
      if ($("body").hasClass("searching")) {
        $("[id=search-query]").blur();
        $("body").removeClass("searching compensate-for-scrollbar");
        removeQueryParamsFromUrl();
        $("#fancybox-style-noscroll").remove();
      } else {
        if (!$("#fancybox-style-noscroll").length && document.body.scrollHeight > window.innerHeight) {
          $("head").append('<style id="fancybox-style-noscroll">.compensate-for-scrollbar{margin-right:' + (window.innerWidth - document.documentElement.clientWidth) + "px;}</style>");
          $("body").addClass("compensate-for-scrollbar");
        }
        $("body").addClass("searching");
        $(".search-results").css({opacity: 0, visibility: "visible"}).animate({opacity: 1}, 200);
        $("#search-query").focus();
      }
    }
    function normalizeCarouselSlideHeights() {
      $(".carousel").each(function() {
        let items = $(".carousel-item", this);
        items.css("min-height", 0);
        let maxHeight = Math.max.apply(null, items.map(function() {
          return $(this).outerHeight();
        }).get());
        items.css("min-height", maxHeight + "px");
      });
    }
    function fixHugoOutput() {
      $("#TableOfContents").addClass("nav flex-column");
      $("#TableOfContents li").addClass("nav-item");
      $("#TableOfContents li a").addClass("nav-link");
      $("input[type='checkbox'][disabled]").parents("ul").addClass("task-list");
    }
    function getSiblings(elem) {
      return Array.prototype.filter.call(elem.parentNode.children, function(sibling) {
        return sibling !== elem;
      });
    }
    $(document).ready(function() {
      fixHugoOutput();
      let {isDarkTheme, themeMode} = initThemeVariation();
      renderThemeVariation(isDarkTheme, themeMode, true);
      if (codeHighlighting) {
        hljs.initHighlighting();
      }
      let child = document.querySelector(".docs-links .active");
      let parent = document.querySelector(".docs-links");
      if (child && parent) {
        scrollParentToChild(parent, child);
      }
    });
    $(window).on("load", function() {
      fixScrollspy();
      let isotopeInstances = document.querySelectorAll(".projects-container");
      let isotopeInstancesCount = isotopeInstances.length;
      if (window.location.hash && isotopeInstancesCount === 0) {
        scrollToAnchor(decodeURIComponent(window.location.hash), 0);
      }
      let child = document.querySelector(".docs-toc .nav-link.active");
      let parent = document.querySelector(".docs-toc");
      if (child && parent) {
        scrollParentToChild(parent, child);
      }
      let zoomOptions = {};
      if (document.body.classList.contains("dark")) {
        zoomOptions.background = "rgba(0,0,0,0.9)";
      } else {
        zoomOptions.background = "rgba(255,255,255,0.9)";
      }
      medium_zoom_esm_default("[data-zoomable]", zoomOptions);
      let isotopeCounter = 0;
      isotopeInstances.forEach(function(isotopeInstance, index) {
        console.debug(`Loading Isotope instance ${index}`);
        let iso;
        let isoSection = isotopeInstance.closest("section");
        let layout = "";
        if (isoSection.querySelector(".isotope").classList.contains("js-layout-row")) {
          layout = "fitRows";
        } else {
          layout = "masonry";
        }
        let defaultFilter = isoSection.querySelector(".default-project-filter");
        let filterText = "*";
        if (defaultFilter !== null) {
          filterText = defaultFilter.textContent;
        }
        console.debug(`Default Isotope filter: ${filterText}`);
        imagesLoaded(isotopeInstance, function() {
          iso = new Isotope(isotopeInstance, {itemSelector: ".isotope-item", layoutMode: layout, masonry: {gutter: 20}, filter: filterText});
          let isoFilterButtons = isoSection.querySelectorAll(".project-filters a");
          isoFilterButtons.forEach((button) => button.addEventListener("click", (e) => {
            e.preventDefault();
            let selector = button.getAttribute("data-filter");
            console.debug(`Updating Isotope filter to ${selector}`);
            iso.arrange({filter: selector});
            button.classList.remove("active");
            button.classList.add("active");
            let buttonSiblings = getSiblings(button);
            buttonSiblings.forEach((buttonSibling) => {
              buttonSibling.classList.remove("active");
              buttonSibling.classList.remove("all");
            });
          }));
          incrementIsotopeCounter();
        });
      });
      function incrementIsotopeCounter() {
        isotopeCounter++;
        if (isotopeCounter === isotopeInstancesCount) {
          console.debug(`All Portfolio Isotope instances loaded.`);
          if (window.location.hash) {
            scrollToAnchor(decodeURIComponent(window.location.hash), 0);
          }
        }
      }
      if ($(".pub-filters-select")) {
        filter_publications();
      }
      $(".js-cite-modal").click(function(e) {
        e.preventDefault();
        let filename = $(this).attr("data-filename");
        let modal = $("#modal");
        modal.find(".modal-body code").load(filename, function(response, status, xhr) {
          if (status == "error") {
            let msg = "Error: ";
            $("#modal-error").html(msg + xhr.status + " " + xhr.statusText);
          } else {
            $(".js-download-cite").attr("href", filename);
          }
        });
        modal.modal("show");
      });
      $(".js-copy-cite").click(function(e) {
        e.preventDefault();
        let range = document.createRange();
        let code_node = document.querySelector("#modal .modal-body");
        range.selectNode(code_node);
        window.getSelection().addRange(range);
        try {
          document.execCommand("copy");
        } catch (e2) {
          console.log("Error: citation copy failed.");
        }
        window.getSelection().removeRange(range);
      });
      initMap();
      let githubReleaseSelector = ".js-github-release";
      if ($(githubReleaseSelector).length > 0) {
        printLatestRelease(githubReleaseSelector, $(githubReleaseSelector).data("repo"));
      }
      document.addEventListener("keyup", (event) => {
        if (event.code === "Escape") {
          const body2 = document.body;
          if (body2.classList.contains("searching")) {
            toggleSearchDialog();
          }
        }
        if (event.key === "/") {
          let focusedElement = document.hasFocus() && document.activeElement !== document.body && document.activeElement !== document.documentElement && document.activeElement || null;
          let isInputFocused = focusedElement instanceof HTMLInputElement || focusedElement instanceof HTMLTextAreaElement;
          if (searchEnabled && !isInputFocused) {
            event.preventDefault();
            toggleSearchDialog();
          }
        }
      });
      if (searchEnabled) {
        $(".js-search").click(function(e) {
          e.preventDefault();
          toggleSearchDialog();
        });
      }
      $('[data-toggle="tooltip"]').tooltip();
    });
    var linkLight = document.querySelector(".js-set-theme-light");
    var linkDark = document.querySelector(".js-set-theme-dark");
    var linkAuto = document.querySelector(".js-set-theme-auto");
    if (linkLight && linkDark && linkAuto) {
      linkLight.addEventListener("click", (event) => {
        event.preventDefault();
        changeThemeModeClick(0);
      });
      linkDark.addEventListener("click", (event) => {
        event.preventDefault();
        changeThemeModeClick(1);
      });
      linkAuto.addEventListener("click", (event) => {
        event.preventDefault();
        changeThemeModeClick(2);
      });
    }
    var darkModeMediaQuery = window.matchMedia("(prefers-color-scheme: dark)");
    darkModeMediaQuery.addEventListener("change", (event) => {
      onMediaQueryListEvent(event);
    });
    window.addEventListener("load", normalizeCarouselSlideHeights);
    window.addEventListener("resize", normalizeCarouselSlideHeights);
    window.addEventListener("orientationchange", normalizeCarouselSlideHeights);
    $("body").on("mouseenter mouseleave", ".dropdown", function(e) {
      var dropdown = $(e.target).closest(".dropdown");
      var menu = $(".dropdown-menu", dropdown);
      dropdown.addClass("show");
      menu.addClass("show");
      setTimeout(function() {
        dropdown[dropdown.is(":hover") ? "addClass" : "removeClass"]("show");
        menu[dropdown.is(":hover") ? "addClass" : "removeClass"]("show");
      }, 300);
    });
    var resizeTimer;
    $(window).resize(function() {
      clearTimeout(resizeTimer);
      resizeTimer = setTimeout(fixScrollspy, 200);
    });
  })();
  (() => {
    var content_type = {authors: "Authors", event: "Events", post: "Posts", project: "Projects", publication: "Publications", slides: "Slides"};
    var i18n = {no_results: "No results found", placeholder: "Search...", results: "results found"};
    var search_config = {indexURI: "/r-pharma/index.json", minLength: 1, threshold: 0.3};
    var fuseOptions = {shouldSort: true, includeMatches: true, tokenize: true, threshold: search_config.threshold, location: 0, distance: 100, maxPatternLength: 32, minMatchCharLength: search_config.minLength, keys: [{name: "title", weight: 0.99}, {name: "summary", weight: 0.6}, {name: "authors", weight: 0.5}, {name: "content", weight: 0.2}, {name: "tags", weight: 0.5}, {name: "categories", weight: 0.5}]};
    var summaryLength = 60;
    function getSearchQuery(name) {
      return decodeURIComponent((location.search.split(name + "=")[1] || "").split("&")[0]).replace(/\+/g, " ");
    }
    function updateURL(url) {
      if (history.replaceState) {
        window.history.replaceState({path: url}, "", url);
      }
    }
    function initSearch(force, fuse) {
      let query = $("#search-query").val();
      if (query.length < 1) {
        $("#search-hits").empty();
        $("#search-common-queries").show();
      }
      if (!force && query.length < fuseOptions.minMatchCharLength)
        return;
      $("#search-hits").empty();
      $("#search-common-queries").hide();
      searchAcademic(query, fuse);
      let newURL = window.location.protocol + "//" + window.location.host + window.location.pathname + "?q=" + encodeURIComponent(query) + window.location.hash;
      updateURL(newURL);
    }
    function searchAcademic(query, fuse) {
      let results = fuse.search(query);
      if (results.length > 0) {
        $("#search-hits").append('<h3 class="mt-0">' + results.length + " " + i18n.results + "</h3>");
        parseResults(query, results);
      } else {
        $("#search-hits").append('<div class="search-no-results">' + i18n.no_results + "</div>");
      }
    }
    function parseResults(query, results) {
      $.each(results, function(key, value) {
        let content_key = value.item.section;
        let content = "";
        let snippet = "";
        let snippetHighlights = [];
        if (["publication", "event"].includes(content_key)) {
          content = value.item.summary;
        } else {
          content = value.item.content;
        }
        if (fuseOptions.tokenize) {
          snippetHighlights.push(query);
        } else {
          $.each(value.matches, function(matchKey, matchValue) {
            if (matchValue.key == "content") {
              let start = matchValue.indices[0][0] - summaryLength > 0 ? matchValue.indices[0][0] - summaryLength : 0;
              let end = matchValue.indices[0][1] + summaryLength < content.length ? matchValue.indices[0][1] + summaryLength : content.length;
              snippet += content.substring(start, end);
              snippetHighlights.push(matchValue.value.substring(matchValue.indices[0][0], matchValue.indices[0][1] - matchValue.indices[0][0] + 1));
            }
          });
        }
        if (snippet.length < 1) {
          snippet += value.item.summary;
        }
        let template = $("#search-hit-fuse-template").html();
        if (content_key in content_type) {
          content_key = content_type[content_key];
        }
        let templateData = {key, title: value.item.title, type: content_key, relpermalink: value.item.relpermalink, snippet};
        let output = render(template, templateData);
        $("#search-hits").append(output);
        $.each(snippetHighlights, function(hlKey, hlValue) {
          $("#summary-" + key).mark(hlValue);
        });
      });
    }
    function render(template, data) {
      let key, find, re;
      for (key in data) {
        find = "\\{\\{\\s*" + key + "\\s*\\}\\}";
        re = new RegExp(find, "g");
        template = template.replace(re, data[key]);
      }
      return template;
    }
    if (typeof Fuse === "function") {
      $.getJSON(search_config.indexURI, function(search_index) {
        let fuse = new Fuse(search_index, fuseOptions);
        let query = getSearchQuery("q");
        if (query) {
          $("body").addClass("searching");
          $(".search-results").css({opacity: 0, visibility: "visible"}).animate({opacity: 1}, 200);
          $("#search-query").val(query);
          $("#search-query").focus();
          initSearch(true, fuse);
        }
        $("#search-query").keyup(function(e) {
          clearTimeout($.data(this, "searchTimer"));
          if (e.keyCode == 13) {
            initSearch(true, fuse);
          } else {
            $(this).data("searchTimer", setTimeout(function() {
              initSearch(false, fuse);
            }, 250));
          }
        });
      });
    }
  })();
})();
