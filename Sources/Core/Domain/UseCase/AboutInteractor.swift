//
//  AboutInteractor.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 07/01/26.
//

import Foundation
import Common

@MainActor
public protocol AboutUseCase {
    func getProfile() -> Profile
    func saveProfile(name: String, email: String)
}

@MainActor
public final class AboutInteractor: AboutUseCase {

    public init() {}

    public func getProfile() -> Profile {
        Profile(
            name: UserDefaults.name ?? "Ade Dwi Prayitno",
            email: UserDefaults.email ?? "adedwip1808@gmail.com",
            imageURL: URL(
                string: "https://avatars.githubusercontent.com/u/56765011?v=4"
            )
        )
    }

    public func saveProfile(name: String, email: String) {
        UserDefaults.name = name
        UserDefaults.email = email
    }
}
