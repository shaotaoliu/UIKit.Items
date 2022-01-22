import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var table: UITableView!
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
    
}
