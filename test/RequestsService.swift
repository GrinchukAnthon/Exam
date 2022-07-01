//
//  RequestsService.swift
//  test
//
//  Created by Антон Гринчук on 01.07.2022.
//

import Foundation
import Alamofire

protocol RequestServiceInput: AnyObject {
    func fetchBooks(pageNumber: Int, result: @escaping (DataResponse<Book, AFError>) -> Void)
}

final class RequestsService: RequestServiceInput {
    
    func fetchBooks(pageNumber: Int, result: @escaping (DataResponse<Book, AFError>) -> Void) {
        let url = "https://demo.api-platform.com/books?page=\(pageNumber)&itemsPerPage=41"
        AF.request(url, method: .get).responseDecodable(of: Book.self, completionHandler: result)
    }
}
