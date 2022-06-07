//
//  PhotosTableViewCell.swift
//  Exam
//
//  Created by Антон Гринчук on 05.06.2022.
//

import UIKit

final class BooksTableViewCell: UITableViewCell {

    @IBOutlet private weak var booksTitleLabel: UILabel!
    
    var books: HydraMember! {
        didSet {
            self.booksTitleLabel.text = self.books.title
        }
    }
//    var books: Book! {
//        didSet {
//            self.booksTitleLabel.text = self.books.title
//        }
//    }
}
