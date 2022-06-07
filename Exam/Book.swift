//
//  Photo.swift
//  Exam
//
//  Created by Антон Гринчук on 05.06.2022.
//

import Foundation

//struct Book: Decodable {
//
//    let title: String?
//
//}

struct Book: Codable {
    let context, id, type: String
    let hydraMember: [HydraMember]
    let hydraTotalItems: Int
    let hydraView: HydraView
    let hydraSearch: HydraSearch

    enum CodingKeys: String, CodingKey {
        case context = "@context"
        case id = "@id"
        case type = "@type"
        case hydraMember = "hydra:member"
        case hydraTotalItems = "hydra:totalItems"
        case hydraView = "hydra:view"
        case hydraSearch = "hydra:search"
    }
}

// MARK: - HydraMember
struct HydraMember: Codable {
    let id: String
    let type: String
    let hydraMemberID: String
    let isbn: String
    let title: String
    let hydraMemberDescription: String
    let author: String
    let publicationDate: Date
    let reviews: [Review]

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case type = "@type"
        case hydraMemberID = "id"
        case isbn = "isbn"
        case title = "title"
        case hydraMemberDescription = "description"
        case author, publicationDate, reviews
    }
}

// MARK: - Review
struct Review: Codable {
    let id: String
    let type: String
    let reviewID, body: String

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case type = "@type"
        case reviewID = "id"
        case body
    }
}

// MARK: - HydraSearch
struct HydraSearch: Codable {
    let type, hydraTemplate, hydraVariableRepresentation: String
    let hydraMapping: [HydraMapping]

    enum CodingKeys: String, CodingKey {
        case type = "@type"
        case hydraTemplate = "hydra:template"
        case hydraVariableRepresentation = "hydra:variableRepresentation"
        case hydraMapping = "hydra:mapping"
    }
}

// MARK: - HydraMapping
struct HydraMapping: Codable {
    let type, variable: String
    let property: String?
    let hydraMappingRequired: Bool

    enum CodingKeys: String, CodingKey {
        case type = "@type"
        case variable, property
        case hydraMappingRequired = "required"
    }
}

// MARK: - HydraView
struct HydraView: Codable {
    let id, type, hydraFirst, hydraLast: String
    let hydraNext: String

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case type = "@type"
        case hydraFirst = "hydra:first"
        case hydraLast = "hydra:last"
        case hydraNext = "hydra:next"
    }
}
