import Cocoa

class ClipboardHistoryViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!

    var clipboardItems: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Load history from manager
        clipboardItems = ClipboardManager.shared.history
        print("Loaded items:", clipboardItems)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
}

extension ClipboardHistoryViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return clipboardItems.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let item = clipboardItems[row]

        guard let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("ClipboardCell"), owner: self) as? NSTableCellView else {
            return nil
        }

        cell.textField?.stringValue = item
        return cell
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        let row = tableView.selectedRow
        guard row >= 0 else { return }

        let text = clipboardItems[row]
        ClipboardManager.shared.simulatePaste(text)
        print("Pasting:", text)

        self.view.window?.close()
    }
}
