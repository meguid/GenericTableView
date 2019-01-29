//
//  GenericTableViewExample
//
//  Created by Ahmed Meguid on 1/29/19.
//  Copyright © 2019 Ahmed Meguid. All rights reserved.
//

import UIKit

class MultiCellsTableViewExample: UIViewController {
    
    let cards = [CardsDataSource(card: Card(number: "98768", holder: "Ahmed Meguid", expired: false)),
                 CardsDataSource(card: Card(number: "78434", holder: "Ahmed Aly", expired: true))]
    
    func addTableView() {
        let cardsList = GenericTableView(frame: view.bounds)
        cards.forEach { (card) in
            if let cardItem = card.item as? Card {
                if cardItem.expired {
                    card.action = rejectTransaction()
                } else {
                    card.action = proceedPayment()
                }
            }
        }
        cardsList.updateDataSource(items: cards)
        self.view.addSubview(cardsList)
    }
    
    private func proceedPayment() -> (GenericModel) -> Void {
        return { (card: GenericModel) in
            // complete payment with $card
        }
    }
    
    private func rejectTransaction() -> (GenericModel) -> Void {
        return { (card: GenericModel) in
            // reject transaction for $card
        }
    }
}

class CardsDataSource: GenericDataSource {
    
    var type: UITableViewCell.Type = CardCell.self
    var action: (GenericModel) -> () = {_ in }
    var item: GenericModel
    
    init(card: Card) {
        item = card
    }
}

struct Card: GenericModel {
    var number: String
    var holder: String
    var expired: Bool
}

class CardCell: UITableViewCell, GenericCell {
    @IBOutlet weak private var number: UILabel!
    @IBOutlet weak private var holder: UILabel!
    
    func configure(model: GenericModel) {
        if let card = model as? Card {
            number.text = card.number
            holder.text = card.holder
        }
    }
}
