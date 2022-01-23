import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var buttonEdit: UIBarButtonItem!
    private let vm = ItemViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
    }
    
    @IBAction func addItem() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "AddItemViewController") as! AddItemViewController
        
        controller.completionHanddler = { item in
            self.vm.add(item: item)
            self.table.reloadData()
        }
        
        //navigationController?.pushViewController(controller, animated: true)
        present(controller, animated: true)
    }
    
    @IBAction func edit(_ sender: Any) {
        table.setEditing(!table.isEditing, animated: true)
        buttonEdit.title = table.isEditing ? "Done" : "Edit"
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: false)
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "ItemDetailViewController") as! ItemDetailViewController
        let item = vm.items[indexPath.row]
        controller.item = item
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = vm.items[indexPath.row].name
        content.secondaryText = vm.items[indexPath.row].description
        content.secondaryTextProperties.color = .systemGray
        
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            vm.items.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        vm.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
        table.reloadData()
    }
    
}
