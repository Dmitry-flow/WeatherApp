
import Foundation

struct WeatherResponse: Decodable {
    var temp: Double
    var text: String
    var feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case condition
        case temp = "temp_c"
        case text
        case feelsLike = "feelslike_c"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temp = try container.decode(Double.self, forKey: .temp)
        feelsLike = try container.decode(Double.self, forKey: .feelsLike)
        let condition = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .condition)
        text = try condition.decode(String.self, forKey: .text)
    }
    
    init(temp: Double, text: String, feelsLike: Double) {
        self.temp = temp
        self.text = text
        self.feelsLike = feelsLike
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(temp, forKey: .temp)
        try container.encode(text, forKey: .text)
        try container.encode(feelsLike, forKey: .feelsLike)
    }
}

struct Weather: Codable {
    var temp: Double
    var text: String
    var feelsLike: Double
}
