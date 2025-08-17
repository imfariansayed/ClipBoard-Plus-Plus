class ClipboardPopupWindow {
    private static var retainedWindow: NSWindow?

    static func showPopup() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateController(withIdentifier: "ClipboardHistoryVC") as? ClipboardHistoryViewController else {
            return
        }

        let window = NSWindow(contentViewController: controller)
        window.styleMask = [.titled, .closable]
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)

        retainedWindow = window // ✅ Keep a reference so ARC doesn't kill it
    }
}
