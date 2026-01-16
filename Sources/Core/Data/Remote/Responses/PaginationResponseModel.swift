//
//  PaginationResponseModel.swift
//  tourism-app
//
//  Created by Ade Dwi Prayitno on 18/11/25.
//

public struct PaginationResponseModel<T>: Codable where T: Codable {
    public let count: Int?
    public let next: String?
    public let previous: String?
    public let results: [T]?

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
    }
}
