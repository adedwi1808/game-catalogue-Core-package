//
//  GameRepository.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 06/01/26.
//

import Combine
import Foundation

@MainActor
public protocol GameRepositoryProtocol {
    // Locale
    func getGames(endPoint: NetworkFactory) -> AnyPublisher<[Game], Error>
    func getGameDetail(endPoint: NetworkFactory) -> AnyPublisher<Game, Error>

    // Remote
    func saveToFavorite(game: Game) -> AnyPublisher<Void, Error>
    func removeFromFavorite(game: Game) -> AnyPublisher<Void, Error>
    func checkIsFavorite(id: Int) -> AnyPublisher<Bool, Error>
    func getLocaleGames() -> AnyPublisher<[Game], Error>
}

@MainActor
public final class GameRepository: NSObject {
    public typealias GameInstance = (LocaleDataSource, RemoteDataSource) -> GameRepository

    fileprivate let locale: LocaleDataSource
    fileprivate let remote: RemoteDataSource

    public init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }

    public static let sharedInstance: GameInstance = { localeRepo, remoteRepo in
        return GameRepository(locale: localeRepo, remote: remoteRepo)
    }
}

extension GameRepository: GameRepositoryProtocol {
    public func getGames(endPoint: NetworkFactory) -> AnyPublisher<[Game], Error> {
        return self.remote.getGames(endPoint: endPoint)
            .map { $0.results?.map { $0.toDomain() } ?? [] }
            .eraseToAnyPublisher()
    }

    public func getGameDetail(endPoint: NetworkFactory) -> AnyPublisher<Game, Error> {
        return self.remote.getGameDetail(endPoint: endPoint)
            .map {
                $0.toDomain()
            }
            .eraseToAnyPublisher()
    }

    public func saveToFavorite(game: Game) -> AnyPublisher<Void, Error> {
        return self.locale.saveToFavorite(
            game: game.toEntity()
        ).eraseToAnyPublisher()
    }

    public func removeFromFavorite(game: Game) -> AnyPublisher<Void, Error> {
        return self.locale
            .removeFromFavorite(game: game.toEntity())
            .eraseToAnyPublisher()
    }

    public func checkIsFavorite(id: Int) -> AnyPublisher<Bool, Error> {
        return self.locale
            .checkIsFavorite(id: id)
            .eraseToAnyPublisher()
    }

    public func getLocaleGames() -> AnyPublisher<[Game], Error> {
        return self.locale
            .getLocaleGames()
            .map { $0.map { $0.toDomain() } }
            .eraseToAnyPublisher()
    }
}
