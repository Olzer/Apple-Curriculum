//
//  EmojiTableViewController.swift
//  EmojiDictionary_2
//
//  Created by Oleg Dorozhovets on 19/10/2022.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    var emojis: [Emoji] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight          = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        if Emoji.loadFromFile().count > 0 {
            emojis = Emoji.loadFromFile()
        } else {
            emojis = Emoji.loadSampleEmoji()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
    


    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Step 1: Dequeue Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell

        //Step 2: Fetch model object to display
        let emoji                 = emojis[indexPath.row]
        
       //Step 3: Configure Cell
        cell.update(with: emoji)
        cell.showsReorderControl  = true
        
        //Step 4: Return Cell
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
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }



    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
