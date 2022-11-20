import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var treeImageView    : UIImageView!
    @IBOutlet weak var correctWorldLabel: UILabel!
    @IBOutlet weak var scoreLabel       : UILabel!
    @IBOutlet var letterButtons         : [UIButton]!
    

    var listOfWords = ["Banana", "Apple", "Pineapple", "Strawberry", "Avocado", "Apricot", "Blaclberry", "Blueberry", "Cherry", "Coconut", "Grape", "Kiwi", "Lemon", "Lime", "Mango", "Orange", "Peach", "Pear"]
    let incorectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    var totalLosses          = 0 {
        didSet {
            newRound()
        }
    }
    
    var currentGame: Game!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        buttonsConfig()
    }

    
    func buttonsConfig() {
        for button in letterButtons {
            button.layer.cornerRadius = 10
            button.backgroundColor = .systemGreen
        }
    }
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord.lowercased(), incorrectMoviesRemaining: incorectMovesAllowed, guessedLatters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formatedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        
        correctWorldLabel.text = wordWithSpacing
        scoreLabel.text        = "Wins: \(totalWins), Loses: \(totalLosses)"
        treeImageView.image    = UIImage(named: "Tree \(currentGame.incorrectMoviesRemaining)")
    }
    
    
    func updateGameState() {
        if currentGame.incorrectMoviesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formatedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter       = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        
        updateGameState()
    }
    
}

