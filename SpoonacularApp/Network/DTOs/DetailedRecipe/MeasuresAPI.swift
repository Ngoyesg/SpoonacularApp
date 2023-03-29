
import Foundation

struct MeasuresAPI: Codable {

  var us     : USMetricAPI?     = USMetricAPI()
  var metric : MetricAPI? = MetricAPI()

  enum CodingKeys: String, CodingKey {

    case us     = "us"
    case metric = "metric"
  
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    us     = try values.decodeIfPresent(USMetricAPI.self     , forKey: .us     )
    metric = try values.decodeIfPresent(MetricAPI.self , forKey: .metric )
 
  }

  init() {

  }

}
