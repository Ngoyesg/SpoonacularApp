//
//  RecipesPresenterBuilder.swift
//  SpoonacularApp
//
//  Created by Natalia Goyes on 30/03/23.
//

import Foundation

class RecipesPresenterBuilder {
    
    private func getDatabaseFacade() -> DBFacade {
        
        let favoriteToObjectConverter = FavoriteRecipeToObject()
        
        let dbManagerAddService = DBAddManager(converter: favoriteToObjectConverter)
        
        let saveFavoriteUseCase = SaveFavoriteUseCase(dbManagerAddService: dbManagerAddService)
        
        let dbManagerDeleteService = DBDeleteManager(converter: favoriteToObjectConverter)
        
        let deleteFavoriteUseCase = DeleteFavoriteUseCase(dbManagerDeleteService: dbManagerDeleteService)
        
        return DBFacade(saveFavoriteUseCase: saveFavoriteUseCase, deleteFavoriteUseCase: deleteFavoriteUseCase)
    }
    
    private func getFilteringUseCase() -> FilteringUseCaseStep {
        
        let filterConverter = FilteredRecipesAPIToModelMap()
        
        let filteredRecipesRetrieverService = FilteredRecipesWebService(converter: filterConverter)
        
        let imagesRetrieverService = getImagesRetrieverService()
        
        return FilteringUseCaseStep(filteredRecipesRetrieverService: filteredRecipesRetrieverService, imagesRetrieverService: imagesRetrieverService)
        
    }
    
    private func getLocalRecipeUseCase() -> GetLocalRecipeUseCaseStep {
        let favoriteRecipeFromObjectConverter = FavoriteRecipeFromObject()
        
        let dbGetManager = DBGetManager(converter: favoriteRecipeFromObjectConverter)
        
        return GetLocalRecipeUseCaseStep(dbGetManager: dbGetManager)
    }
    
    
    private func getImagesRetrieverService() -> GetRecipesWithImagesWebService {
        
        let getRecipesService = getRecipesWebService()
        
        let getImageService = ImageWebService(responseDecoder: ImageDecoder())
        
        let mapperFromRecipeService = RecipesToRecipesWithImages()
        
       return GetRecipesWithImagesWebService(getRecipesService: getRecipesService, getImageService: getImageService, mapperFromRecipeService: mapperFromRecipeService)
    }
    
    private func getRecipesWebService() -> GetRecipesWebService {
        
        let apiToModelConverter = AllRecipesAPIToModelMap()
        
        return GetRecipesWebService(converter: apiToModelConverter)
        
    }
    
    private func getRecipesRetrieverUseCase() -> RecipesRetrieverUseCaseStep {

        let imagesRetrieverService = getImagesRetrieverService()
        
        let recipesRetrieverService = getRecipesWebService()
        
        return RecipesRetrieverUseCaseStep(recipesRetrieverService: recipesRetrieverService, imagesRetrieverService: imagesRetrieverService)
    }
    
    private func getProductionFetchRecipesUseCase() -> FetchRecipesUseCase {
        let filteringUseCase = getFilteringUseCase()
        
        let recipesRetrieverUseCase = getRecipesRetrieverUseCase()
        
        let mapperRecipesToDisplay = MapRecipeToDisplay()

        let getLocalRecipeUseCase = getLocalRecipeUseCase()
        
        return FetchRecipesUseCase(filteringUseCase: filteringUseCase, recipesRetrieverUseCase: recipesRetrieverUseCase, mapperRecipesToDisplay: mapperRecipesToDisplay, getLocalRecipeUseCase: getLocalRecipeUseCase)
    }
    
    private func getDevelopmentFetchRecipesUseCase() -> FakeFetchRecipesUseCase {
        return FakeFetchRecipesUseCase()
    }
    
    private func getFetchRecipesUseCase() -> FetchRecipesUseCaseProtocol {
        #if DEBUG
            return getDevelopmentFetchRecipesUseCase()
        #else
            return getProductionFetchRecipesUseCase()
        #endif
    }
    
    func build() -> RecipesPresenter {
      
        let fetchRecipesUseCase = getFetchRecipesUseCase()
    
        let dbFacade = getDatabaseFacade()
        
        return RecipesPresenter(fetchRecipesUseCase: fetchRecipesUseCase, dbFacade: dbFacade)
    }
}
