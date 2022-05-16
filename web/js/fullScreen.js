function isfullScreen(fullElement = document.documentElement) {
    // 全屏状态
    const isFullScreen = document.isFullScreen || document.mozIsFullScreen || document.webkitIsFullScreen;
    if (isFullScreen == undefined)  isFullScreen = false;
    return isFullScreen;
}

function cancelfullScreen(fullElement = document.documentElement) {
    // 判断是否处在全屏状态
    const isFullScreen = document.isFullScreen || document.mozIsFullScreen || document.webkitIsFullScreen;
    if (isFullScreen) {
         const el = document;
         let cfs = el.cancelFullScreen || el.mozCancelFullScreen || el.msExitFullscreen || el.webkitExitFullscreen || el.exitFullscreen;
          if (cfs) {
               cfs.call(el);
          }
     }
}

function enterfullScreen(fullElement = document.documentElement) {
    // 判断是否处在全屏状态
    const isFullScreen = document.isFullScreen || document.mozIsFullScreen || document.webkitIsFullScreen;
    if (!isFullScreen)
    {
          const el = fullElement;
          let rfs = el.requestFullScreen || el.webkitRequestFullScreen || el.mozRequestFullScreen || el.msRequestFullscreen;
          if (rfs) {
               rfs.call(el);
          }
     }
}