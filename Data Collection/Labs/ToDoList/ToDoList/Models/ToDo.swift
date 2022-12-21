import Foundation
import UIKit

struct ToDo: Equatable {
    let id = UUID()
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func loadToDos() -> [ToDo]? {
        return nil
    }
    
    static func loadSampleDos() -> [ToDo] {
        let toDo1 = ToDo(title: "To-Do One. Wake up!", isComplete: false, dueDate: Date(), notes: "It's esential to wake up every day at the same time")
        let toDo2 = ToDo(title: "To-Do Two. Morning Exercise", isComplete: false, dueDate: Date(), notes: "It's real important to have some morning exercice, for activate our body and prepare it for future day")
        let toDo3 = ToDo(title: "To-Do Three. Teeth washing", isComplete: false, dueDate: Date(), notes: "Regular teeth cleaning needed to prevent beauty and even health issues")
        
        return [toDo1, toDo2, toDo3]
    }
}
