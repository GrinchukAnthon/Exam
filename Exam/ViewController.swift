//
//  ViewController.swift
//  Exam
//
//  Created by Антон Гринчук on 04.06.2022.
//

import UIKit
import Alamofire

final class ViewController: UIViewController {
    
    private let url = "https://demo.api-platform.com"
    
    @IBOutlet private weak var tableView: UITableView!
    
//    private var books: [Book] = []
    private var books: [HydraMember] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        tableView.register(UINib(nibName: "BooksTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "BooksTableViewCell")
        fetchData()
    }

    private func fetchData() {
        AF.request(self.url + "/books", method: .get).responseDecodable(of: [HydraMember].self) { [weak self] response in
            print(response)
            self?.books = response.value ?? []
            self?.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate {
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BooksTableViewCell", for: indexPath) as? BooksTableViewCell {
            cell.books = self.books[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}
