//
//  RecipesPresenterBuilder.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

class RecipesPresenterBuilder {
    
    func getFilteringUseCase() {
        #warning("Organizar esto")
    }
    func build() -> RecipesPresenter {
        
        //Common webService
        let apiToModelConverter = AllRecipesAPIToModelMap()
        
        let getRecipesService = GetRecipesWebService(converter: apiToModelConverter)
        
        let getImageService = ImageWebService(responseDecoder: ImageDecoder())
        
        let mapperFromRecipeService = RecipesToRecipesWithImages()
        
        let imagesRetrieverService = GetRecipesWithImagesWebService(getRecipesService: getRecipesService, getImageService: getImageService, mapperFromRecipeService: mapperFromRecipeService)
        
        //Filtering use case
        let filterConverter = FilteredRecipesAPIToModelMap()
        
        let filteredRecipesRetrieverService = FilteredRecipesWebService(converter: filterConverter)
        
        let filteringUseCase = FilteringUseCaseStep(filteredRecipesRetrieverService: filteredRecipesRetrieverService, imagesRetrieverService: imagesRetrieverService)
        
        //All Recipes use case
        let recipesRetrieverService = GetRecipesWebService(converter: apiToModelConverter)
        
        let recipesRetrieverUseCase = RecipesRetrieverUseCaseStep(recipesRetrieverService: recipesRetrieverService, imagesRetrieverService: imagesRetrieverService)
        
        //Mapper
        
        let mapperRecipesToDisplay = MapRecipeToDisplay()
        
        //WebServiceFacade
        
        let favoriteRecipeFromObjectConverter = FavoriteRecipeFromObject()
        let dbGetManager = DBGetManager(converter: favoriteRecipeFromObjectConverter)
        let getLocalRecipeUseCase = GetLocalRecipeUseCaseStep(dbGetManager: dbGetManager)
        
        let fetchRecipesUseCase = FetchRecipesUseCase(filteringUseCase: filteringUseCase, recipesRetrieverUseCase: recipesRetrieverUseCase, mapperRecipesToDisplay: mapperRecipesToDisplay, getLocalRecipeUseCase: getLocalRecipeUseCase)
        
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
        return RecipesPresenter(fetchRecipesUseCase: fetchRecipesUseCase, dbFacade: dbFacade)
    }
}
