//
//  BookTableViewCell.swift
//  test
//
//  Created by Антон Гринчук on 07.06.2022.
//

import UIKit

final class BookTableViewCell: UITableViewCell {

    @IBOutlet weak private var booksTitleLabel: UILabel!
    
    var books: HydraMember! {
        didSet {
            self.booksTitleLabel.text = self.books.title
        }
    }
    
}
