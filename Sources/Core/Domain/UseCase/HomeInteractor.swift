//
//  HomeInteractor.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 06/01/26.
//

import Combine
import Foundation

@MainActor
public protocol HomeUseCase {
    func getGames(endPoint: NetworkFactory) -> AnyPublisher<[Game], Error>
}

@MainActor
public final class HomeInteractor: HomeUseCase {

    private let repository: GameRepositoryProtocol

    public required init(repository: GameRepositoryProtocol) {
        self.repository = repository
    }

    public func getGames(endPoint: NetworkFactory) -> AnyPublisher<[Game], any Error> {
        repository.getGames(endPoint: endPoint)
    }
}
