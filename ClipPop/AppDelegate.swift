import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    let clipboardManager = ClipboardManager.shared

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        clipboardManager.startMonitoring()
        HotkeyManager.shared.setupShortcut()
    }

    func applicationWillTerminate(_ aNotification: Notification) {}
}
