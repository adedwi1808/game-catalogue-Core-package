//
//  RealmManager.swift
//  game-catalogue-uikit
//
//  Created by Ade Dwi Prayitno on 23/11/25.
//

import Foundation
import RealmSwift

@MainActor
public final class RealmManager: RealmManagerProtocol {

    private let factory: RealmFactory

    public init(factory: RealmFactory = .main) {
        self.factory = factory
    }

    private func getRealm() throws -> Realm {
        do {
            return try Realm(configuration: factory.configuration)
        } catch {
            throw DatabaseError.migrationError(message: error.localizedDescription)
        }
    }

    public func fetch<T: Object>(type: T.Type) async throws -> [T] {
        do {
            let realm = try self.getRealm()
            let results = realm.objects(type)
            return Array(results.freeze())
        } catch {
            throw DatabaseError.fetchFailed(message: error.localizedDescription)
        }
    }

    public func fetch<T: Object>(type: T.Type, filter: String) async throws -> [T] {
        do {
            let realm = try self.getRealm()
            let results = realm.objects(type).filter(filter)
            return Array(results.freeze())
        } catch {
            throw DatabaseError.fetchFailed(message: error.localizedDescription)
        }
    }

    public func save<T: Object>(object: T) async throws {
        do {
            let realm = try self.getRealm()
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
#if DEBUG
            print("Realm Write Error: \(error)")
#endif
            throw DatabaseError.writeFailed(message: error.localizedDescription)
        }
    }

    public func save<T: Object>(objects: [T]) async throws {
        do {
            let realm = try self.getRealm()
            try realm.write {
                realm.add(objects, update: .modified)
            }
        } catch {
            throw DatabaseError.writeFailed(message: error.localizedDescription)
        }
    }

    public func delete<T: Object>(object: T) async throws {
        do {
            let realm = try self.getRealm()
            if let primaryKey = object.objectSchema.primaryKeyProperty?.name,
               let id = object.value(forKey: primaryKey) {

                if let objectToDelete = realm.object(ofType: T.self, forPrimaryKey: id) {
                    try realm.write {
                        realm.delete(objectToDelete)
                    }
                } else {
                    throw DatabaseError.objectNotFound(message: "Object to delete not found in Realm")
                }
            } else {
                throw DatabaseError.writeFailed(message: "Object does not have Primary Key")
            }

        } catch {
            throw DatabaseError.writeFailed(message: error.localizedDescription)
        }
    }

    public func deleteAll<T: Object>(type: T.Type) async throws {
        do {
            let realm = try self.getRealm()
            let objects = realm.objects(type)
            try realm.write {
                realm.delete(objects)
            }
        } catch {
            throw DatabaseError.writeFailed(message: error.localizedDescription)
        }
    }
}
