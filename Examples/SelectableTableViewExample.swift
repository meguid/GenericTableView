//
//  GenericTableViewExample
//
//  Created by Ahmed Meguid on 1/29/19.
//  Copyright © 2019 Ahmed Meguid. All rights reserved.
//

import UIKit

class SelectableTableViewExample: UIViewController {
    
    let employees = [EmployeesDataSource(employee: Employee(fullName: "Meguid", jobTitle: "iOS Developer")),
                     EmployeesDataSource(employee: Employee(fullName: "Ahmed", jobTitle: "Software Engineer"))]
    
    func addTableView() {
        let employeesList = GenericTableView(frame: view.bounds)
        employees.forEach({$0.action = navigateToEmployeeView()})
        employeesList.updateDataSource(items: employees)
        self.view.addSubview(employeesList)
    }
    
    private func navigateToEmployeeView() -> (GenericModel) -> Void {
        return { (employee: GenericModel) in
            // here navigate to $employee view
        }
    }
}

class EmployeesDataSource: GenericDataSource {
    
    var type: UITableViewCell.Type = EmployeeCell.self
    var action: (GenericModel) -> () = {_ in }
    var item: GenericModel
    
    init(employee: Employee) {
        item = employee
    }
}

struct Employee: GenericModel {
    var fullName: String
    var jobTitle: String
}

class EmployeeCell: UITableViewCell, GenericCell {
    @IBOutlet weak private var fullName: UILabel!
    @IBOutlet weak private var jobTitle: UILabel!
    
    func configure(model: GenericModel) {
        if let employee = model as? Employee {
            fullName.text = employee.fullName
            jobTitle.text = employee.jobTitle
        }
    }
}
