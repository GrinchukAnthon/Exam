//
//  ViewController.swift
//  test
//
//  Created by Антон Гринчук on 07.06.2022.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var page = 1
    
    private var isLoading = false
    private var isLoaded = false
    private var requestsService: RequestServiceInput!
    
    private var hydraMember: [HydraMember] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        requestsService = RequestsService()
        fetchData(refresh: true)
        
    }
 
    private func setupTableView() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        
        tableView.register(UINib(nibName: "BookTableViewCell",
                                 bundle: nil),forCellReuseIdentifier: "BookTableViewCell")
    }
    
    @objc private func refreshData() {
        fetchData(refresh: true)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hydraMember.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell",
                                                       for: indexPath) as? BookTableViewCell else {
            return UITableViewCell()
        }
        cell.hydraMember = hydraMember[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == hydraMember.count - 2 && !isLoaded {
            fetchData(refresh: false)
        }
    }
}

private extension ViewController {
    func fetchData(refresh: Bool = false) {
        guard !isLoading else { return }
        
        isLoaded = true
        
        if refresh {
            tableView.refreshControl?.beginRefreshing()
            page = 1
        }
        
        requestsService.fetchBooks(pageNumber: page) { response in
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
