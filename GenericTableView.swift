//
//  GenericTableView.swift
//  GenericTableViewExample
//
//  Created by Ahmed Meguid on 1/29/19.
//  Copyright © 2019 Ahmed Meguid. All rights reserved.
//

import UIKit

protocol GenericDataSource {
    var type: UITableViewCell.Type {get set}
    var item: GenericModel {get set}
    var action: (GenericModel) -> () {get set}
}

protocol GenericCell {
    func configure(model: GenericModel)
}

protocol GenericModel { }

class GenericTableView: UITableView {
    
    var items: [GenericDataSource] = []
    
    init(frame: CGRect) {
        super.init(frame: frame, style: UITableView.Style.plain)
    }
    
    func updateDataSource(items: [GenericDataSource]) {
        self.items = items
        reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfRows(inSection section: Int) -> Int {
        return items.count
    }
    
    override func cellForRow(at indexPath: IndexPath) -> UITableViewCell? {
        let cell = self.dequeueReusableCell(withIdentifier: items[indexPath.row].type.className, for: indexPath)
        if let cell = cell as? GenericCell {
            cell.configure(model: items[indexPath.row].item)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[indexPath.row].action(items[indexPath.row].item)
    }
}

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
