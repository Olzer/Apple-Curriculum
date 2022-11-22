import Foundation

class Emoji: Codable {
    var symbol     : String
    var name       : String
    var descriprion: String
    var usage      : String
    
    init(symbol: String, name: String, descriprion: String, usage: String) {
        self.symbol = symbol
        self.name = name
        self.descriprion = descriprion
        self.usage = usage
    }
    
    static var documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("emojis").appendingPathExtension("plist")
    
    
    static func saveToFile(emojies: [Emoji]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodeEmojies = try? propertyListEncoder.encode(emojies)
        
        try? encodeEmojies?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [Emoji]? {
        guard let codedEmojis = try? Data(contentsOf: archiveURL) else { return nil }
        
        let propertyListDecoder = PropertyListDecoder()
        
        return try? propertyListDecoder.decode(Array<Emoji>.self, from: codedEmojis)
    }
    
    
    static func loadSampleEmoji() -> [Emoji] {
        return [
            Emoji(symbol: "😁", name: "Beaming Face with Smiling Eyes", descriprion: "Teeth may be smoothed-over or crosshatched. ", usage: "Often expresses a radiant, gratified happiness. Tone varies, including warm, silly, amused, or proud."),
            Emoji(symbol: "😊", name: "Smiling Face with Smiling Eyes", descriprion: "Closed smile turning up to rosy cheeks. ", usage: "Often expresses genuine happiness and warm, positive feelings."),
            Emoji(symbol: "🫶", name: "Heart Hands", descriprion: "Two hands forming a heart shape.", usage: "Used to express love and support."), Emoji(symbol: "😂", name: "Face with Tears of Joy", descriprion: "Face with a big grin, uplifted eyebrows, and smiling eyes, each shedding a tear from laughing so hard.", usage: "Widely used to show something is funny or pleasing. "),
            Emoji(symbol: "👍", name: "Thumbs Up", descriprion: "A thumbs-up gesture indicating approval.", usage: "Good!"),
            Emoji(symbol: "🤔", name: "Thinking Face", descriprion: "Intended to show a person pondering or deep in thought.", usage: "Often used to question or scorn something or someone, as if saying Hmm, I don't know about that. Tone varies, including earnest, playful, puzzled, skeptical, and mocking."),
            Emoji(symbol: "🥺", name: "Pleading Face", descriprion: "“Puppy dog” eyes, as if begging or pleading.", usage: "May also represent adoration or feeling touched by a loving gesture."),
            Emoji(symbol: "🥲", name: "Smiling Face with Tear", descriprion: "Face with open eyes, a thin closed-mouth smile, and a single tear falling from one of its eye", usage: "Can be used to express a wide range of emotions and expressions including gratitude, tender happiness, an attempt to look happy when actually sad, or smiling through pain. Can also be a response to something that is bittersweet."),
            Emoji(symbol: "😉", name: "Winking Face", descriprion: "Smile or open mouth shown winking, usually its left eye. ", usage: "May signal a joke, flirtation, hidden meaning, or general positivity. Tone varies, including playful, affectionate, suggestive, or ironic."),
            Emoji(symbol: "❤️", name: "Red Heart", descriprion: "A classic red love heart emoji, used for expressions of love and romance.", usage: "Love")
        ]
    }
}
