//
//  AddEditEmojiTableViewController.swift
//  EmojiDictionary_2
//
//  Created by Oleg Dorozhovets on 24/10/2022.
//

import UIKit

class AddEditEmojiTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField       : UITextField!
    @IBOutlet weak var symboTextField      : UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var usageTextField      : UITextField!
    @IBOutlet weak var saveButton          : UIBarButtonItem!
    
    
    var emoji: Emoji?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let emoji = emoji {
            nameTextField.text        = emoji.name
            symboTextField.text       = emoji.symbol
            descriptionTextField.text = emoji.descriprion
            usageTextField.text       = emoji.usage
            title = "Edit Emoji"
        } else {
            title = "Add Emoji"
        }
      updateSaveButton()
    }

    init?(coder: NSCoder, emoji: Emoji?) {
        self.emoji = emoji
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButton()
    }
    
    
    func updateSaveButton() {
        let nameText         = nameTextField.text ?? ""
        let descriptionText  = descriptionTextField.text ?? ""
        let usageText        = usageTextField.text ?? ""
        saveButton.isEnabled = containsSingleEmoji(symboTextField) && !nameText.isEmpty && !descriptionText.isEmpty && !usageText.isEmpty
    }
    
    
    func containsSingleEmoji(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text.count == 1 else {
            return  false
        }
        
        let isCombinatedIntoEmoji = text.unicodeScalars.count > 1 && text.unicodeScalars.first?.properties.isEmoji ?? false
        let isEmojiPresentation   = text.unicodeScalars.first?.properties.isEmojiPresentation ?? false
        
        return isEmojiPresentation || isCombinatedIntoEmoji
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveUnwind" else { return }

        let symbol      = symboTextField.text!
        let name        = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        let usage       = usageTextField.text ?? ""
        emoji           = Emoji(symbol: symbol, name: name, descriprion: description, usage: usage)

    }

    
    
    
    
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
