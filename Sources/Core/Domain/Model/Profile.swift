//
//  Profile.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 07/01/26.
//

import Foundation

public struct Profile {
    public var name: String
    public var email: String
    public let imageURL: URL?
    
    public init(name: String, email: String, imageURL: URL?) {
        self.name = name
        self.email = email
        self.imageURL = imageURL
    }
}
