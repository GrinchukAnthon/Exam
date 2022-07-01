//
//  Book.swift
//  test
//
//  Created by Антон Гринчук on 07.06.2022.
//

import Foundation

struct Book: Codable {
    let hydraMember: [HydraMember]

    enum CodingKeys: String, CodingKey {
        case hydraMember = "hydra:member"
    }
}

struct HydraMember: Codable {
    let title: String

    enum CodingKeys: String, CodingKey {
        case title = "title"
    }
}
