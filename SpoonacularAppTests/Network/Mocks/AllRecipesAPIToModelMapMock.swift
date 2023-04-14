//
//  AllRecipesAPIToModelMapMock.swift
//  SpoonacularAppTests
//
//  Created by Natalia Goyes on 2/04/23.
//

import Foundation
@testable import SpoonacularApp

class AllRecipesAPIToModelMapMock: AllRecipesAPIToModelMapProtocol {
    func convert(_ input: AllRecipesAPI) -> AllRecipesModel {
        return AllRecipesModel(recipes: input.resultstoObject, offset: input.offset, number: input.number, totalResults: input.totalResults)
    }

}

