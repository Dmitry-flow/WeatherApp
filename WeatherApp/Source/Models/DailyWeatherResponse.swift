
import Foundation

struct DailyWeatherResponse: Decodable {
    var icon: String
    var date: String
    var tempMin: Double
    var tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case condition
        case day
        case date
        case tempMin = "mintemp_c"
        case tempMax = "maxtemp_c"
        case icon
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(String.self, forKey: .date)
        let day = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .day)
        tempMin = try day.decode(Double.self, forKey: .tempMin)
        tempMax = try day.decode(Double.self, forKey: .tempMax)
        let condition = try day.nestedContainer(keyedBy: CodingKeys.self, forKey: .condition)
        icon = "http:\(try condition.decode(String.self, forKey: .icon))"
    }
}

struct DailyWeather: Codable {
    var icon: String
    var date: String
    var tempMin: Double
    var tempMax: Double
}
