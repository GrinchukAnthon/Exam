//
//  ViewController.swift
//  test
//
//  Created by Антон Гринчук on 07.06.2022.
//

import UIKit
import Alamofire

final class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let url = "https://demo.api-platform.com/books"
    
    private var hydraMember: [HydraMember] = []
    private var books: Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        tableView.register(UINib(nibName: "BookTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "BookTableViewCell")
        fetchData()
        
    }

    private func fetchData() {
        
        AF.request(self.url, method: .get).responseDecodable(of: Book.self) {response in
//            print(response)
            
            switch response.result {
            case .success(let responcse):
                self.hydraMember = responcse.hydraMember
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            self.tableView.reloadData()
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
        return self.hydraMember.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as? BookTableViewCell {
            cell.hydraMember = self.hydraMember[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}
