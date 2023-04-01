//
//  DatabaseManager.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 28/03/23.
//

import Foundation
import RealmSwift

enum DBManagerError: Error {
    case unableToAddObject, unableToDeleteObject, unableToRetriveData, unableToDeleteData, unexpectedError
}

enum DBManagerResultStatus: String {
    case failure = "Error"
    case success = "Success"
}

class DBManager {
   
    var config: Realm.Configuration!
    let realm = try! Realm()

    init(config: Realm.Configuration = Realm.Configuration.defaultConfiguration) {
        self.config = config
      }
 
}
