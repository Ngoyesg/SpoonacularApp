
import Foundation

struct Nutrition: Codable {

  var nutrients        : [Nutrients]?      = []
  var properties       : [Properties]?     = []
  var flavonoids       : [Flavonoids]?     = []
  var ingredients      : [Ingredients]?    = []
  var caloricBreakdown : CaloricBreakdown? = CaloricBreakdown()
  var weightPerServing : WeightPerServing? = WeightPerServing()

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

    nutrients        = try values.decodeIfPresent([Nutrients].self      , forKey: .nutrients        )
    properties       = try values.decodeIfPresent([Properties].self     , forKey: .properties       )
    flavonoids       = try values.decodeIfPresent([Flavonoids].self     , forKey: .flavonoids       )
    ingredients      = try values.decodeIfPresent([Ingredients].self    , forKey: .ingredients      )
    caloricBreakdown = try values.decodeIfPresent(CaloricBreakdown.self , forKey: .caloricBreakdown )
    weightPerServing = try values.decodeIfPresent(WeightPerServing.self , forKey: .weightPerServing )
 
  }

  init() {

  }

}