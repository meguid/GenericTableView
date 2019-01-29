//
//  GenericTableViewExample
//
//  Created by Ahmed Meguid on 1/29/19.
//  Copyright © 2019 Ahmed Meguid. All rights reserved.
//

import UIKit

class SimpleTableViewExample: UIViewController {

    let users = [UsersDataSource(user: User(firstname: "Adam", lastname: "Meguid")),
                 UsersDataSource(user: User(firstname: "Ahmed", lastname: "Ali"))]
    
    func addTableView() {
        let usersList = GenericTableView(frame: view.bounds)
        usersList.updateDataSource(items: users)
        self.view.addSubview(usersList)
    }
}

class UsersDataSource: GenericDataSource {
    
    var type: UITableViewCell.Type = UserCell.self
    var action: (GenericModel) -> () = {_ in }
    var item: GenericModel
    
    init(user: User) {
        item = user
    }
}

struct User: GenericModel {
    var firstname: String
    var lastname: String
}

class UserCell: UITableViewCell, GenericCell {
    @IBOutlet weak private var firstname: UILabel!
    @IBOutlet weak private var lastname: UILabel!

    func configure(model: GenericModel) {
        if let user = model as? User {
            firstname.text = user.firstname
            lastname.text = user.lastname
        }
    }
}
