import UIKit

class SelectRoomTypeTableViewController: UITableViewController {
    
    var roomType: [RoomType] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        tableView.reloadData()
//    }
//
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomType.all.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTypeCell", for: indexPath)
        let roomType = RoomType.all[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = roomType.name
        content.secondaryText = "$ \(roomType.price)"
        cell.contentConfiguration = content
        return cell
    }

}
