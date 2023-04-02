//
//  FavoritesUseCases.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 1/04/23.
//

import Foundation

enum FavoritesUseCases: String {
    case fetching = "Fetching favorites done"
    case deleteOne = "Deleting favorite done"
    case deleteAll = "Deleting all favorites done"
}

enum FavoritesUseCasesStatus: String {
    case failure = "Error"
    case success = "Success"
}
