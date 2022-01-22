import Foundation

class ItemViewModel {
    
    var items: [Item] = []
    
    init() {
        loadData()
    }
    
    func loadData() {
        for i in 1...5 {
            items.append(Item(id: i, name: "Item \(i)", description: "This is item \(i)"))
        }
    }
    
    func add(item: Item) {
        let maxId = items.map {
            $0.id
        }.max()
        
        let id = (maxId ?? 0) + 1
        items.append(Item(id: id, name: item.name, description: item.description))
    }
    
    func remove(item: Item) {
        items.removeAll(where: { $0.id == item.id })
    }
    
    func update(item: Item) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].name = item.name
            items[index].description = item.description
        }
    }
}

struct Item {
    var id: Int
    var name: String
    var description: String
}
