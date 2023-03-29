
import Foundation

struct NutritionAPI: Codable {

  var nutrients        : [NutrientsAPI]?      = []
  var properties       : [PropertiesAPI]?     = []
  var flavonoids       : [FlavonoidsAPI]?     = []
  var ingredients      : [IngredientsAPI]?    = []
  var caloricBreakdown : CaloricBreakdownAPI? = CaloricBreakdownAPI()
  var weightPerServing : WeightPerServingAPI? = WeightPerServingAPI()

  enum CodingKeys: String, CodingKey {

    case nutrients        = "nutrients"
    case properties       = "properties"
    case flavonoids       = "flavonoids"
    case ingredients      = "ingredients"
    case caloricBreakdown = "caloricBreakdown"
    case weightPerServing = "weightPerServing"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    nutrients        = try values.decodeIfPresent([NutrientsAPI].self      , forKey: .nutrients        )
    properties       = try values.decodeIfPresent([PropertiesAPI].self     , forKey: .properties       )
    flavonoids       = try values.decodeIfPresent([FlavonoidsAPI].self     , forKey: .flavonoids       )
    ingredients      = try values.decodeIfPresent([IngredientsAPI].self    , forKey: .ingredients      )
    caloricBreakdown = try values.decodeIfPresent(CaloricBreakdownAPI.self , forKey: .caloricBreakdown )
    weightPerServing = try values.decodeIfPresent(WeightPerServingAPI.self , forKey: .weightPerServing )
 
  }

  init() {

  }

}

extension NutritionAPI {
    var toObject: Calories {
        Calories(composition: self.caloricBreakdown?.toObject)
    }
}
