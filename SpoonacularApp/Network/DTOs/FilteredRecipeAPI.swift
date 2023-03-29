
import Foundation

struct FilteredRecipesAPI: Codable {

  var type             : String?     = nil
  var products         : [Products]? = []
  var offset           : Int?        = nil
  var number           : Int?        = nil
  var totalProducts    : Int?        = nil
  var processingTimeMs : Int?        = nil
  var expires          : Int?        = nil

  enum CodingKeys: String, CodingKey {

    case type             = "type"
    case products         = "products"
    case offset           = "offset"
    case number           = "number"
    case totalProducts    = "totalProducts"
    case processingTimeMs = "processingTimeMs"
    case expires          = "expires"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    type             = try values.decodeIfPresent(String.self     , forKey: .type             )
    products         = try values.decodeIfPresent([Products].self , forKey: .products         )
    offset           = try values.decodeIfPresent(Int.self        , forKey: .offset           )
    number           = try values.decodeIfPresent(Int.self        , forKey: .number           )
    totalProducts    = try values.decodeIfPresent(Int.self        , forKey: .totalProducts    )
    processingTimeMs = try values.decodeIfPresent(Int.self        , forKey: .processingTimeMs )
    expires          = try values.decodeIfPresent(Int.self        , forKey: .expires          )
 
  }

  init() {

  }

}
