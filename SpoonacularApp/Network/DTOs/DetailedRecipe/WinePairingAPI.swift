
import Foundation

struct WinePairingAPI: Codable {

  var pairedWines    : [String]? = []
  var pairingText    : String?   = nil
  var productMatches : [String]? = []

  enum CodingKeys: String, CodingKey {

    case pairedWines    = "pairedWines"
    case pairingText    = "pairingText"
    case productMatches = "productMatches"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    pairedWines    = try values.decodeIfPresent([String].self , forKey: .pairedWines    )
    pairingText    = try values.decodeIfPresent(String.self   , forKey: .pairingText    )
    productMatches = try values.decodeIfPresent([String].self , forKey: .productMatches )
 
  }

  init() {

  }

}
