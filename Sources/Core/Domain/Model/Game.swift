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
    
    public init(id: Int, name: String, released: String, backgroundImage: String?, rating: Double?, ratingCount: Int?, platforms: [PlatformElement], genres: [Genre], description: String?, added: Int?, developers: String?) {
        self.id = id
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.ratingCount = ratingCount
        self.platforms = platforms
        self.genres = genres
        self.description = description
        self.added = added
        self.developers = developers
    }
}

public struct Genre {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

public struct PlatformElement {
    public let id: Int
    public let name: String
    public let slug: String
    
    public init(id: Int, name: String, slug: String) {
        self.id = id
        self.name = name
        self.slug = slug
    }
}
