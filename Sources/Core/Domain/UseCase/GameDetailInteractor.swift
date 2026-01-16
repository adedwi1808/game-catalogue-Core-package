//
//  GameDetailInteractor.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 07/01/26.
//

import Combine
import Foundation

@MainActor
public protocol GameDetailUseCase {
    func getGameDetail(endPoint: NetworkFactory) -> AnyPublisher<Game, Error>
    func saveToFavorite(game: Game) -> AnyPublisher<Void, Error>
    func removeFromFavorite(game: Game) -> AnyPublisher<Void, Error>
    func checkIsFavorite(id: Int) -> AnyPublisher<Bool, Error>
}

@MainActor
public final class GameDetailInteractor: GameDetailUseCase {
    private let repository: GameRepositoryProtocol

    public required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }

    public func getGameDetail(endPoint: NetworkFactory) -> AnyPublisher<Game, any Error> {
        repository.getGameDetail(endPoint: endPoint)
    }

    public func saveToFavorite(game: Game) -> AnyPublisher<Void, any Error> {
        repository.saveToFavorite(game: game)
    }

    public func removeFromFavorite(game: Game) -> AnyPublisher<Void, any Error> {
        repository.removeFromFavorite(game: game)
    }

    public func checkIsFavorite(id: Int) -> AnyPublisher<Bool, any Error> {
        repository.checkIsFavorite(id: id)
    }
}
