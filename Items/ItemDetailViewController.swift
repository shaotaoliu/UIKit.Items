import UIKit

class ItemDetailViewController: UIViewController {

    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    var item: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = item.name
        labelName.text = item.name
        labelDescription.text = item.description
    }

}
