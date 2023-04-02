
import Foundation

struct FilteredRecipesAPI: Codable, DecodableAPIResponse {

  var type             : String?     = nil
  var recipes         : [RecipesAPI]? = []
  var offset           : Int?        = nil
  var number           : Int?        = nil
  var totalProducts    : Int?        = nil
  var processingTimeMs : Int?        = nil
  var expires          : Int?        = nil

  enum CodingKeys: String, CodingKey {

    case type             = "type"
    case recipes         = "products"
    case offset           = "offset"
    case number           = "number"
    case totalProducts    = "totalProducts"
    case processingTimeMs = "processingTimeMs"
    case expires          = "expires"
  
  }

}

extension FilteredRecipesAPI {
    var resultstoObject: [Recipe]? {
        recipes?.map({ eachRecipe in
            eachRecipe.toObject
        })
    }
}
