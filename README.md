# GenericTableView
Simple &amp; Dynamic GenericTableView with Examples

## Features:

- [x] Generic Table View
- [x] Simple Table View Example
- [x] Selectable/Actionable Table View Example
- [x] MultiCells Table View Example
- [ ] More...

## Usage
- Adding the tableview would be like this

  ```swift
  let users = [UsersDataSource(user: User(firstname: "Adam", lastname: "Meguid")),
               UsersDataSource(user: User(firstname: "Ahmed", lastname: "Ali"))]

  func addTableView() {
      let usersList = GenericTableView(frame: view.bounds)
      usersList.updateDataSource(items: users)
      self.view.addSubview(usersList)
  }
  ```
  
  But first we need to add 3 things
  
  - Model 
  
  ```swift
  struct User: GenericModel {
    var firstname: String
    var lastname: String
  } 
  ```  
  
  - Cell 
  
  ```swift
  class UserCell: UITableViewCell, GenericCell {
    @IBOutlet weak var firstname: UILabel!
    @IBOutlet weak var lastname: UILabel!

    func configure(model: GenericModel) {
        if let user = model as? User {
            firstname.text = user.firstname
            lastname.text = user.lastname
        }
    }
  }
  ```

  - Data Source
  
  ```swift
  class UsersDataSource: GenericDataSource {

    var type: UITableViewCell.Type = UserCell.self
    var action: (GenericModel) -> () = {_ in }
    var item: GenericModel

    init(user: User) {
        item = user
    }
  } 
  ```  
  
#### And that's all you need.
  
## More Customization

- Adding actions to cell selection

    ```swift
    func addTableView() {
        .
        .
        users.forEach({$0.action = navigateToUserView()})
        .
    }
    
    private func navigateToUserView() -> (GenericModel) -> Void {
        return { (user: GenericModel) in
            // here navigate to $user view
        }
    }
    ```
  
- Supporting Multi Actions

    ```swift
    func addTableView() {
        .
        users.forEach { (user) in
            if let userItem = user.item as? User {
                if userItem.activated {
                    user.action = navigateToUserView()
                } else {
                    user.action = blockUserAccess()
                }
            }
        }
        .
        .
    }
    
    private func navigateToUserView() -> (GenericModel) -> Void {
        return { (user: GenericModel) in
            // here navigate to $user view
        }
    }
    
    private func blockUserAccess() -> (GenericModel) -> Void {
        return { (user: GenericModel) in
            // here block access to $user
        }
    }
    
    struct User: GenericModel {
      .
      .
      var activated: Bool
    }
    ```
  
   
- Supporting Multi Cells with Multi Actions

    ```swift
    
    let users = [UsersDataSource(user: User(firstname: "Adam", lastname: "Meguid")),
                 PremiumUsersDataSource(user: PremiumUser(firstname: "Ahmed", lastname: "Ali", grade: "Class A"))]

    struct PremiumUser: GenericModel {
        var firstname: String
        var lastname: String
        var grade: String
    }

    class PremiumUserCell: UserCell {
        @IBOutlet weak private var grade: UILabel!

        override func configure(model: GenericModel) {
            if let user = model as? PremiumUser {
                firstname.text = user.firstname
                lastname.text = user.lastname
                grade.text = user.grade
            }
        }
    }

    class PremiumUsersDataSource: GenericDataSource {
    
      var type: UITableViewCell.Type = PremiumUserCell.self
      var action: (GenericModel) -> () = {_ in }
      var item: GenericModel
    
      init(user: PremiumUserCell) {
          item = user
      }
    } 
    ```
