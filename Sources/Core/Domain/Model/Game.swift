//
//  Game.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 21/11/25.
//

public struct Game {
    public let id: Int
    public let name: String
    public let released: String
    public let backgroundImage: String?
    public let rating: Double?
    public let ratingCount: Int?
    public let platforms: [PlatformElement]
    public let genres: [Genre]
    public let description: String?
    public let added: Int?
    public let developers: String?
}

public struct Genre {
    public let id: Int
    public let name: String
}

public struct PlatformElement {
    public let id: Int
    public let name: String
    public let slug: String
}
