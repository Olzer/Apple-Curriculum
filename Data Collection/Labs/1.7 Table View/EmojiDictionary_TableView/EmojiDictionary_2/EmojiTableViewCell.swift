import UIKit

class EmojiTableViewCell: UITableViewCell {

    @IBOutlet weak var symbolLabel     : UILabel!
    @IBOutlet weak var nameLabel       : UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func update(with emoji: Emoji) {
        symbolLabel.text      = emoji.symbol
        nameLabel.text        = emoji.name
        descriptionLabel.text = emoji.descriprion
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
