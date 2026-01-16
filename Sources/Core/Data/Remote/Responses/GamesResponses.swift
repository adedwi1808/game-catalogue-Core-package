//
//  GamesResponses.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 21/11/25.
//

import Foundation

// MARK: - GamesResponse
public struct GamesResponse: Codable {
    public let id: Int?
    public let slug: String?
    public let name: String?
    public let released: String?
    public let backgroundImage: String?
    public let rating: Double?
    public let ratingCount: Int?
    public let parentPlatforms: [ParentPlatformResponse]?
    public let genres: [GenreResponse]?
    public let description: String?
    public let added: Int?
    public let developers: [DevelopersResponse]?

    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case released
        case backgroundImage = "background_image"
        case rating
        case parentPlatforms = "parent_platforms"
        case ratingCount = "ratings_count"
        case genres
        case description = "description_raw"
        case added
        case developers
    }
}

// MARK: - GenreResponse
public struct GenreResponse: Codable {
    public let id: Int?
    public let name, slug: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
    }
}

// MARK: - ParentPlatform
public struct ParentPlatformResponse: Codable {
    public let platform: PlatformResponse?
}

// MARK: - PlatformResponse
public struct PlatformResponse: Codable {
    public let id: Int?
    public let name, slug: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
    }
}

// MARK: - DevelopersResponse
public struct DevelopersResponse: Codable {
    public let id: Int?
    public let name: String?

    enum CodingKeys: String, CodingKey {
        case id, name
    }
}

extension GamesResponse {
    func toDomain() -> Game {
        return Game(
            id: id ?? 0,
            name: name ?? "-",
            released: released ?? "-",
            backgroundImage: backgroundImage,
            rating: rating,
            ratingCount: ratingCount,
            platforms: parentPlatforms?.map { $0.toDomain() } ?? [],
            genres: genres?.map { $0.toDomain() } ?? [],
            description: description,
            added: added,
            developers: developers?.first?.name
        )
    }
}

extension ParentPlatformResponse {
    func toDomain() -> PlatformElement {
        PlatformElement(
            id: platform?.id ?? 0,
            name: platform?.name ?? "-",
            slug: platform?.slug ?? "-"
        )
    }
}

extension GenreResponse {
    func toDomain() -> Genre {
        Genre(
            id: id ?? 0,
            name: name ?? "-"
        )
    }
}
