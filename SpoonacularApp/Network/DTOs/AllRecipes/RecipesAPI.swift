
import Foundation

struct RecipesAPI: Codable {

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

}

extension RecipesAPI {
    var toObject: Recipe {
        Recipe(id: self.id ?? 0, title: self.title, image: self.image)
    }
}
