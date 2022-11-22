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
        configureEmoji()
        updateSaveButton()
    }
    
    init?(coder: NSCoder, emoji: Emoji?) {
        self.emoji = emoji
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureEmoji() {
        if let emoji = emoji {
            nameTextField.text        = emoji.name
            symboTextField.text       = emoji.symbol
            descriptionTextField.text = emoji.descriprion
            usageTextField.text       = emoji.usage
            title = "Edit Emoji"
        } else {
            title = "Add Emoji"
        }
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
}
