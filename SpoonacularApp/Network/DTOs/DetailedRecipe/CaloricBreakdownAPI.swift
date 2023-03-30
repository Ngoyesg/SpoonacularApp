
import Foundation

struct CaloricBreakdownAPI: Codable {

  var percentProtein : Double? = nil
  var percentFat     : Double? = nil
  var percentCarbs   : Double? = nil

  enum CodingKeys: String, CodingKey {

    case percentProtein = "percentProtein"
    case percentFat     = "percentFat"
    case percentCarbs   = "percentCarbs"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    percentProtein = try values.decodeIfPresent(Double.self , forKey: .percentProtein )
    percentFat     = try values.decodeIfPresent(Double.self , forKey: .percentFat     )
    percentCarbs   = try values.decodeIfPresent(Double.self , forKey: .percentCarbs   )
 
  }

  init() {

  }

}


extension CaloricBreakdownAPI {
    var caloriesToObject: CaloricBreakdown {
        CaloricBreakdown(percentProtein: self.percentProtein, percentFat: self.percentFat, percentCarbs: self.percentCarbs)
    }
}
