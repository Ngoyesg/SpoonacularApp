
import Foundation

struct WeightPerServingAPI: Codable {

  var amount : Int?    = nil
  var unit   : String? = nil

  enum CodingKeys: String, CodingKey {

    case amount = "amount"
    case unit   = "unit"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    amount = try values.decodeIfPresent(Int.self    , forKey: .amount )
    unit   = try values.decodeIfPresent(String.self , forKey: .unit   )
 
  }

  init() {

  }

}
