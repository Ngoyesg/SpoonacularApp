
import Foundation

struct IngredientsAPI: Codable {

  var id        : Int?         = nil
  var name      : String?      = nil
  var amount    : Double?      = nil
  var unit      : String?      = nil
  var nutrients : [NutrientsAPI]? = []

  enum CodingKeys: String, CodingKey {

    case id        = "id"
    case name      = "name"
    case amount    = "amount"
    case unit      = "unit"
    case nutrients = "nutrients"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id        = try values.decodeIfPresent(Int.self         , forKey: .id        )
    name      = try values.decodeIfPresent(String.self      , forKey: .name      )
    amount    = try values.decodeIfPresent(Double.self      , forKey: .amount    )
    unit      = try values.decodeIfPresent(String.self      , forKey: .unit      )
    nutrients = try values.decodeIfPresent([NutrientsAPI].self , forKey: .nutrients )
 
  }

  init() {

  }

}
