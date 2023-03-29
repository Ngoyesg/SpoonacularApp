
import Foundation

struct RecipiesResults: Codable {

  var id        : Int?    = nil
  var title     : String? = nil
  var image     : String? = nil
  var imageType : String? = nil

  enum CodingKeys: String, CodingKey {

    case id        = "id"
    case title     = "title"
    case image     = "image"
    case imageType = "imageType"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id        = try values.decodeIfPresent(Int.self    , forKey: .id        )
    title     = try values.decodeIfPresent(String.self , forKey: .title     )
    image     = try values.decodeIfPresent(String.self , forKey: .image     )
    imageType = try values.decodeIfPresent(String.self , forKey: .imageType )
 
  }

  init() {

  }

}
