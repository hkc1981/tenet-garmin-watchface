import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class tenetWatchFaceApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view and delegate of your application here.
    // 回傳 WatchFaceDelegate 才能讓 Connect IQ 啟用 1Hz 局部更新 (onPartialUpdate) 機制！
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new tenetWatchFaceView(), new tenetWatchFaceDelegate() ] as [Views, InputDelegates];
    }

}

// 實作 WatchFaceDelegate 以啟用 1Hz 局部刷新 (onPartialUpdate)
class tenetWatchFaceDelegate extends WatchUi.WatchFaceDelegate {
    function initialize() {
        WatchFaceDelegate.initialize();
    }
}

function getApp() as tenetWatchFaceApp {
    return Application.getApp() as tenetWatchFaceApp;
}
