
import Foundation

struct Nutrients: Codable {

  var name                : String? = nil
  var amount              : Int?    = nil
  var unit                : String? = nil
  var percentOfDailyNeeds : Double? = nil

  enum CodingKeys: String, CodingKey {

    case name                = "name"
    case amount              = "amount"
    case unit                = "unit"
    case percentOfDailyNeeds = "percentOfDailyNeeds"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    name                = try values.decodeIfPresent(String.self , forKey: .name                )
    amount              = try values.decodeIfPresent(Int.self    , forKey: .amount              )
    unit                = try values.decodeIfPresent(String.self , forKey: .unit                )
    percentOfDailyNeeds = try values.decodeIfPresent(Double.self , forKey: .percentOfDailyNeeds )
 
  }

  init() {

  }

}