import UIKit

class ToDoTVC: UITableViewController {

    var toDos = [ToDo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    func updateUI() {
        if let savedToDos = ToDo.loadToDos() {
            toDos = savedToDos
        } else {
            toDos = ToDo.loadSampleDos()
        }
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        
        //        let toDo = toDos[indexPath.row]
        //        var content = cell.defaultContentConfiguration()
        //        content.text = toDo.title
        //        cell.contentConfiguration = content
        
        let toDo = toDos[indexPath.row]
        cell.titleLabel?.text = toDo.title
        cell.isCompleteButton.isSelected = toDo.isComplete
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as! ToDoDetailTVC
        
        if let toDo = sourceViewController.toDo {
            if let indexOfExistingToDo = toDos.firstIndex(of: toDo) {
                toDos[indexOfExistingToDo] = toDo
                tableView.reloadRows(at: [IndexPath(row: indexOfExistingToDo, section: 0)], with: .automatic)
                print("Reload row")
            } else {
                let newIndexPath = IndexPath(row: toDos.count, section: 0)
                toDos.append(toDo)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }

    @IBSegueAction func editToDo(_ coder: NSCoder, sender: Any?) -> ToDoDetailTVC? {
        let detailController = ToDoDetailTVC(coder: coder)
        
        guard let cell = sender as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell) else { return detailController }
        
        tableView.deselectRow(at: indexPath, animated: true)
        detailController?.toDo = toDos[indexPath.row]
        print("Editing")
        return detailController
    }

}
