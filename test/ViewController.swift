//
//  ViewController.swift
//  test
//
//  Created by Антон Гринчук on 07.06.2022.
//

import UIKit
import Alamofire

final class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private let url = "https://demo.api-platform.com/books"
    private var numberPage = "?page="
    private var page = 1
    private let itemsPerPage = "&itemsPerPage=41"
    
    private var isLoading: Bool = false
    private var isLoaded = false
    
    private var hydraMember: [HydraMember] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        tableView.register(UINib(nibName: "BookTableViewCell",
                                 bundle: nil),forCellReuseIdentifier: "BookTableViewCell")
        fetchData(refresh: true)
    }

    @objc private func refreshData() {
        fetchData(refresh: true)
    }
    
    private func fetchData(refresh: Bool = false) {
        guard !isLoading else { return }
        isLoaded = true
        if refresh {
            tableView.refreshControl?.beginRefreshing()
            page = 1
        }
        AF.request(self.url + numberPage + "\(page)" + itemsPerPage, method: .get).responseDecodable(of: Book.self) {response in
            
            if refresh {
                self.tableView.refreshControl?.endRefreshing()
            }
            
            switch response.result {
            case .success(let response):
                if refresh {
                    self.page = 2
                    self.hydraMember = response.hydraMember
                } else {
                    self.page += 1
                    self.hydraMember.append(contentsOf: response.hydraMember)
                }
                self.isLoaded = response.hydraMember.isEmpty
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            self.tableView.reloadData()
            self.isLoading = false
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell",
                                                    for: indexPath) as? BookTableViewCell {
            cell.hydraMember = self.hydraMember[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == hydraMember.count - 2 && !isLoaded {
            fetchData(refresh: false)
        }
    }
}
