//
//  FavoriteInteractor.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 07/01/26.
//

import Combine
import Foundation

@MainActor
public protocol FavoriteUseCase {
    func getLocaleGames() -> AnyPublisher<[Game], Error>
}

@MainActor
public final class FavoriteInteractor: FavoriteUseCase {

    private let repository: GameRepositoryProtocol

    public required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }

    public func getLocaleGames() -> AnyPublisher<[Game], Error> {
        repository.getLocaleGames()
    }
}
