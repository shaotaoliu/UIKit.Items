import UIKit

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textDescription: UITextField!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var buttonSave: UIButton!
    var completionHanddler: ((Item) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(save))
    }
    
    //@objc
    @IBAction
    func save() {
        guard let name = textName.text, !name.isEmpty else {
            showAlert(message: "Please enter name")
            return
        }
        
        guard let description = textDescription.text, !description.isEmpty else {
            showAlert(message: "Please enter description")
            return
        }
        
        let item = Item(id: 0, name: name, description: description)
        completionHanddler?(item)
        
        //navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }
    
    @IBAction
    func cancel() {
        dismiss(animated: true)
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
