import UIKit

class EmojiTableViewController: UITableViewController {
    
    var emojis: [Emoji] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureEmojiTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    func configureEmojiTableView() {
        tableView.rowHeight          = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        if Emoji.loadFromFile().count > 0 {
            emojis = Emoji.loadFromFile()
        } else {
            emojis = Emoji.loadSampleEmoji()
        }
    }
    
    
    @IBSegueAction func addEditEmoji(_ coder: NSCoder, sender: Any?) -> AddEditEmojiTableViewController? {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            //Editing Emoji
            let emojiToEdit = emojis[indexPath.row]
            return AddEditEmojiTableViewController(coder: coder, emoji: nil)
        } else {
            //Adding Emoji
            return AddEditEmojiTableViewController(coder: coder, emoji: nil)
        }
    }
    
    
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind",
              let sourceViewController = segue.source
                as? AddEditEmojiTableViewController,
              let emoji = sourceViewController.emoji else { return }
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emojis[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            let newIndexPath = IndexPath(row: emojis.count, section: 0)
            emojis.append(emoji)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell
        let emoji = emojis[indexPath.row]
        cell.update(with: emoji)
        cell.showsReorderControl  = true
        
        return cell
    }
    
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = emojis.remove(at: sourceIndexPath.row)
        Emoji.saveToFile(emojies: emojis)
        emojis.insert(movedEmoji, at: destinationIndexPath.row)
    }
    
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojis.remove(at: indexPath.row)
            Emoji.saveToFile(emojies: emojis)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
        }
    }
}
