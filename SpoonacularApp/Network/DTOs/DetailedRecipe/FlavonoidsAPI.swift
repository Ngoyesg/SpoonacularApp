
import Foundation

struct FlavonoidsAPI: Codable {

  var name   : String? = nil
  var amount : Double?    = nil
  var unit   : String? = nil

  enum CodingKeys: String, CodingKey {

    case name   = "name"
    case amount = "amount"
    case unit   = "unit"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    name   = try values.decodeIfPresent(String.self , forKey: .name   )
    amount = try values.decodeIfPresent(Double.self    , forKey: .amount )
    unit   = try values.decodeIfPresent(String.self , forKey: .unit   )
 
  }

  init() {

  }

}
