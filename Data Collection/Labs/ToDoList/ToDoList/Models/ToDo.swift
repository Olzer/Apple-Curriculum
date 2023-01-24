import Foundation
import UIKit

struct ToDo: Equatable, Codable {
    let id: UUID
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    init(title: String, isComplete: Bool, dueDate: Date, notes: String?) {
        self.id = UUID()
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.notes = notes
    }
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appending(path: "toDos").appendingPathExtension("plist")
    
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func loadToDos() -> [ToDo]? {
        guard let codedToDos = try? Data(contentsOf: archiveURL) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedToDos)
    }
    
    static func saveToDos(_ toDos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codesToDos = try? propertyListEncoder.encode(toDos)
        try? codesToDos?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadSampleDos() -> [ToDo] {
        let toDo1 = ToDo(title: "To-Do One. Wake up!", isComplete: false, dueDate: Date(), notes: "It's esential to wake up every day at the same time")
        let toDo2 = ToDo(title: "To-Do Two. Morning Exercise", isComplete: false, dueDate: Date(), notes: "It's real important to have some morning exercice, for activate our body and prepare it for future day")
        let toDo3 = ToDo(title: "To-Do Three. Teeth washing", isComplete: false, dueDate: Date(), notes: "Regular teeth cleaning needed to prevent beauty and even health issues")
        
        return [toDo1, toDo2, toDo3]
    }
}
