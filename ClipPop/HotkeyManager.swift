import Cocoa
import Carbon

class HotkeyManager {
    static let shared = HotkeyManager()

    func setupShortcut() {
        NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { event in
            if event.modifierFlags.contains(.command) && event.keyCode == 9 { // keyCode 9 = "v"
                ClipboardPopupWindow.showPopup()
            }
        }
    }
}
