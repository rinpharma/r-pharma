/*! Wowchemy v5.0.0-beta.2 | https://wowchemy.com/ */
/*! Copyright 2016-present George Cushen (https://georgecushen.com/) */
/*! License: https://github.com/wowchemy/wowchemy-hugo-modules/blob/master/LICENSE.md */

;
(()=>{var body=document.body;function getThemeMode(){return parseInt(localStorage.getItem("wcTheme")||2);}
function canChangeTheme(){return Boolean(window.wc.darkLightEnabled);}
function initThemeVariation(){if(!canChangeTheme()){console.debug("User theming disabled.");return{isDarkTheme:window.wc.isSiteThemeDark,themeMode:window.wc.isSiteThemeDark?1:0};}
console.debug("User theming enabled.");let isDarkTheme;let currentThemeMode=getThemeMode();console.debug(`User's theme variation: ${currentThemeMode}`);switch(currentThemeMode){case 0:isDarkTheme=false;break;case 1:isDarkTheme=true;break;default:if(window.matchMedia("(prefers-color-scheme: dark)").matches){isDarkTheme=true;}else if(window.matchMedia("(prefers-color-scheme: light)").matches){isDarkTheme=false;}else{isDarkTheme=window.wc.isSiteThemeDark;}
break;}
if(isDarkTheme&&!body.classList.contains("dark")){console.debug("Applying Wowchemy dark theme");document.body.classList.add("dark");}else if(!isDarkTheme&&body.classList.contains("dark")){console.debug("Applying Wowchemy light theme");document.body.classList.remove("dark");}
return{isDarkTheme,themeMode:currentThemeMode};}
var wcDarkLightEnabled=false;var wcIsSiteThemeDark=false;window.wc={darkLightEnabled:wcDarkLightEnabled,isSiteThemeDark:wcIsSiteThemeDark};if(window.netlifyIdentity){window.netlifyIdentity.on("init",(user)=>{if(!user){window.netlifyIdentity.on("login",()=>{document.location.href="/admin/";});}});}
initThemeVariation();window.PlotlyConfig={MathJaxConfig:"local"};})();