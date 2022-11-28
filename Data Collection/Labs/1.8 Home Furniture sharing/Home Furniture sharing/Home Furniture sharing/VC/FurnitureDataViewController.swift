import UIKit

class FurnitureDataViewController: UIViewController {

    var furniture: Furniture?
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var choosePhotoButton: UIButton!
    @IBOutlet weak var furnitureTitleLabel: UILabel!
    @IBOutlet weak var furnitureDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    init?(coder: NSCoder, furniture: Furniture?) {
        self.furniture = furniture
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI() {
        guard let furniture = furniture else { return }
        if let imageData = furniture.imageData,
           let image = UIImage(data: imageData) {
            imageViewOutlet.image = image
        } else {
            imageViewOutlet.image = nil
        }
        
        furnitureTitleLabel.text = furniture.name
        furnitureDescriptionLabel.text = furniture.description
    }
}
