
import Foundation

struct ExtendedIngredientsAPI: Codable {

  var id           : Int?      = nil
  var aisle        : String?   = nil
  var image        : String?   = nil
  var consistency  : String?   = nil
  var name         : String?   = nil
  var nameClean    : String?   = nil
  var original     : String?   = nil
  var originalName : String?   = nil
  var amount       : Int?      = nil
  var unit         : String?   = nil
  var meta         : [String]? = []
  var measures     : MeasuresAPI? = MeasuresAPI()

  enum CodingKeys: String, CodingKey {

    case id           = "id"
    case aisle        = "aisle"
    case image        = "image"
    case consistency  = "consistency"
    case name         = "name"
    case nameClean    = "nameClean"
    case original     = "original"
    case originalName = "originalName"
    case amount       = "amount"
    case unit         = "unit"
    case meta         = "meta"
    case measures     = "measures"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id           = try values.decodeIfPresent(Int.self      , forKey: .id           )
    aisle        = try values.decodeIfPresent(String.self   , forKey: .aisle        )
    image        = try values.decodeIfPresent(String.self   , forKey: .image        )
    consistency  = try values.decodeIfPresent(String.self   , forKey: .consistency  )
    name         = try values.decodeIfPresent(String.self   , forKey: .name         )
    nameClean    = try values.decodeIfPresent(String.self   , forKey: .nameClean    )
    original     = try values.decodeIfPresent(String.self   , forKey: .original     )
    originalName = try values.decodeIfPresent(String.self   , forKey: .originalName )
    amount       = try values.decodeIfPresent(Int.self      , forKey: .amount       )
    unit         = try values.decodeIfPresent(String.self   , forKey: .unit         )
    meta         = try values.decodeIfPresent([String].self , forKey: .meta         )
    measures     = try values.decodeIfPresent(MeasuresAPI.self , forKey: .measures     )
 
  }

  init() {

  }

}
