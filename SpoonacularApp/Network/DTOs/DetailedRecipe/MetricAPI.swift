
import Foundation

struct MetricAPI: Codable {

  var amount    : Int?    = nil
  var unitShort : String? = nil
  var unitLong  : String? = nil

  enum CodingKeys: String, CodingKey {

    case amount    = "amount"
    case unitShort = "unitShort"
    case unitLong  = "unitLong"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    amount    = try values.decodeIfPresent(Int.self    , forKey: .amount    )
    unitShort = try values.decodeIfPresent(String.self , forKey: .unitShort )
    unitLong  = try values.decodeIfPresent(String.self , forKey: .unitLong  )
 
  }

  init() {

  }

}
