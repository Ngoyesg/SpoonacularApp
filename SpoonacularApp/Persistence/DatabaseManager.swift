//
//  DatabaseManager.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 28/03/23.
//

import Foundation
import RealmSwift

enum DBManagerError: Error {
    case unableToAddObject, unableToDeleteObject, unableToRetriveData, unableToDeleteData
}

protocol DBManagerProtocol: AnyObject {
    func getAll() throws -> [FavoriteRecipe]
    func add<T: Persistable>(object: T) throws
    func delete<T: Persistable>(object: T) throws
}

class DBManager: DBManagerProtocol {
   
    var config: Realm.Configuration!
    let realm = try! Realm()

    init(config: Realm.Configuration = Realm.Configuration.defaultConfiguration) {
        self.config = config
      }
    
    
    func getAll() -> [FavoriteRecipe] {
        let results = realm.objects(FavoriteRecipeObject.self)
        //Need to map the results here
        return [FavoriteRecipe(id: 0, title: "", image: "", imageType: "")]
    }
    
    
    func add<T: Persistable>(object: T) throws {
        do {
            try realm.write{
                realm.add(object.managedObject())
            }
        } catch {
            throw DBManagerError.unableToAddObject
        }
    }
    
    
    func delete<T: Persistable>(object: T) throws {
        do {
            try realm.write{
                realm.delete(object.managedObject())
            }
        } catch {
            throw DBManagerError.unableToDeleteObject
        }
    }
    
    
    func deleteAll() throws {
        do {
            try realm.write{
                realm.deleteAll()
            }
        } catch {
            throw DBManagerError.unableToDeleteData
        }
    }
}
