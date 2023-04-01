//
//  RecipesPresenterBuilder.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

class RecipesPresenterBuilder {
    
    func build() -> RecipesPresenter {
        
        //Common webService
        let apiToModelConverter = AllRecipesAPIToModelMap()
        
        let getRecipesService = GetRecipesWebService(converter: apiToModelConverter)
        
        let getImageService = ImageWebService()
        
        let mapperFromRecipeService = RecipesToRecipesWithImages()
        
        let imagesRetrieverService = GetRecipesWithImagesWebService(getRecipesService: getRecipesService, getImageService: getImageService, mapperFromRecipeService: mapperFromRecipeService)
        
        //Filtering use case
        let filterConverter = FilteredRecipesAPIToModelMap()
        
        let filteredRecipesRetrieverService = FilteredRecipesWebService(converter: filterConverter)
        
        let filteringUseCase = FilteringUseCase(filteredRecipesRetrieverService: filteredRecipesRetrieverService, imagesRetrieverService: imagesRetrieverService)
        
        //All Recipes use case
        let recipesRetrieverService = GetRecipesWebService(converter: apiToModelConverter)
        
        let recipesRetrieverUseCase = RecipesRetrieverUseCase(recipesRetrieverService: recipesRetrieverService, imagesRetrieverService: imagesRetrieverService)
        
        //Mapper
        
        let mapperRecipesToDisplay = MapRecipeToDisplay()
        
        //WebServiceFacade
        
        let webServiceFacade = WebServicesFacade(filteringUseCase: filteringUseCase, recipesRetrieverUseCase: recipesRetrieverUseCase, mapperRecipesToDisplay: mapperRecipesToDisplay)
        
        //DB Saving use case
        let favoriteToObjectConverter = FavoriteRecipeToObject()
        
        let dbManagerAddService = DBAddManager(converter: favoriteToObjectConverter)
        
        let saveFavoriteUseCase = SaveFavoriteUseCase(dbManagerAddService: dbManagerAddService)
        
        //DB Deleting use case
        let dbManagerDeleteService = DBDeleteManager(converter: favoriteToObjectConverter)
        
        let deleteFavoriteUseCase = DeleteFavoriteUseCase(dbManagerDeleteService: dbManagerDeleteService)
        
        //DBFacade
        let dbFacade = DBFacade(saveFavoriteUseCase: saveFavoriteUseCase, deleteFavoriteUseCase: deleteFavoriteUseCase)
        
        // Return
        return RecipesPresenter(webServiceFacade: webServiceFacade, dbFacade: dbFacade)
    }
}
