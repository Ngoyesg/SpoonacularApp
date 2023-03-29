
import Foundation

struct Measures: Codable {

  var us     : Us?     = Us()
  var metric : Metric? = Metric()

  enum CodingKeys: String, CodingKey {

    case us     = "us"
    case metric = "metric"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    us     = try values.decodeIfPresent(Us.self     , forKey: .us     )
    metric = try values.decodeIfPresent(Metric.self , forKey: .metric )
 
  }

  init() {

  }

}