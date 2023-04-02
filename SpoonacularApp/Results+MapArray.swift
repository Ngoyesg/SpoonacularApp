//
//  Results+MapArray.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 28/03/23.
//

import Foundation
import RealmSwift

extension Results {
    func toArray() -> [Element] {
        return map { $0 }
    }
}
