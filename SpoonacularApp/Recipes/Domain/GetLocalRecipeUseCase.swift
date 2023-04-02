//
//  GetLocalRecipeUseCase.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 1/04/23.
//

import Foundation

protocol GetLocalRecipeUseCaseStepProtocol {
    func getLocalRecipe(by id: Int) -> FavoriteRecipe?
}

class GetLocalRecipeUseCaseStep: GetLocalRecipeUseCaseStepProtocol {
    private let dbGetManager: DBGetManagerProtocol
    init(dbGetManager: DBGetManagerProtocol) {
        self.dbGetManager = dbGetManager
    }
    
    func getLocalRecipe(by id: Int) -> FavoriteRecipe? {
        try? dbGetManager.getById(id: id)
    }
}
