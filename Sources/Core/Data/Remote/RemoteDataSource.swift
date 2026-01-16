//
//  RemoteDataSource.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 06/01/26.
//

import Combine
import Foundation

@MainActor
public protocol RemoteDataSourceProtocol: AnyObject {
    func getGames(endPoint: NetworkFactory) -> AnyPublisher<PaginationResponseModel<GamesResponse>, Error>
    func getGameDetail(endPoint: NetworkFactory) -> AnyPublisher<GamesResponse, Error>
}

@MainActor
public final class RemoteDataSource: NSObject {

    private let networker: NetworkerProtocol

    private init(networker: NetworkerProtocol) {
        self.networker = networker
    }

    @MainActor
    public static let sharedInstance: (NetworkerProtocol) -> RemoteDataSource = { networker in
        return RemoteDataSource(networker: networker)
    }

}

extension RemoteDataSource: RemoteDataSourceProtocol {
    public func getGameDetail(endPoint: NetworkFactory) -> AnyPublisher<GamesResponse, any Error> {
        return Future { completion in
            Task {
                do {
                    let response = try await self.networker
                        .taskAsync(
                            type: GamesResponse.self,
                            endPoint: endPoint,
                            isMultipart: false
                        )
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

    public func getGames(endPoint: NetworkFactory) -> AnyPublisher<PaginationResponseModel<GamesResponse>, Error> {
        return Future { completion in
            Task {
                do {
                    let response = try await self.networker
                        .taskAsync(
                            type: PaginationResponseModel<GamesResponse>.self,
                            endPoint: endPoint,
                            isMultipart: false
                        )
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }

}
