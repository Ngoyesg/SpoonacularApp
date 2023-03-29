//
//  DBDeleteManager.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 29/03/23.
//

import Foundation

protocol DBDeleteManagerProtocol: AnyObject {
    func delete<T: Persistable>(object: T) throws
    func deleteAll() throws
}

class DBDeleteManager: DBManager {
    
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
