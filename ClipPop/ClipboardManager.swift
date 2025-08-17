import Cocoa

class ClipboardManager {
    static let shared = ClipboardManager()
    private let pasteboard = NSPasteboard.general
    private var changeCount = NSPasteboard.general.changeCount
    private(set) var history: [String] = []

    private init() {}

    func startMonitoring() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            self.checkClipboard()
        }
    }

    private func checkClipboard() {
        if pasteboard.changeCount != changeCount {
            changeCount = pasteboard.changeCount
            if let newText = pasteboard.string(forType: .string) {
                print("Copied:", newText)
                addToHistory(newText)
            }
        }
    }

    private func addToHistory(_ item: String) {
        history.removeAll(where: { $0 == item })
        history.insert(item, at: 0)
        if history.count > 20 {
            history.removeLast()
        }
    }

    // ✅ MOVE THIS INSIDE THE CLASS
    func simulatePaste(_ text: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(text, forType: .string)

        let src = CGEventSource(stateID: .combinedSessionState)

        // Cmd + V down
        let cmdDown = CGEvent(keyboardEventSource: src, virtualKey: 0x09, keyDown: true) // V key
        cmdDown?.flags = .maskCommand

        // Cmd + V up
        let cmdUp = CGEvent(keyboardEventSource: src, virtualKey: 0x09, keyDown: false)
        cmdUp?.flags = .maskCommand

        let loc = CGEventTapLocation.cghidEventTap
        cmdDown?.post(tap: loc)
        cmdUp?.post(tap: loc)
    }
}
