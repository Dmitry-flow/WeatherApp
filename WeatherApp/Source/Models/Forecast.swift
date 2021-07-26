
import Foundation

struct Forecast: Decodable {
    var dailyForecasts: [DailyWeather]
    var weather: Weather
    var currentCity: String
    
    enum CodingKeys: String, CodingKey {
        case location
        case currentCity = "name"
        case current
        case forecast
        case dailyForecasts = "forecastday"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let location = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .location)
        currentCity = try location.decode(String.self, forKey: .currentCity)
        weather = try container.decode(Weather.self, forKey: .current)
        let forecast = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .forecast)
        dailyForecasts = try forecast.decode([DailyWeather].self, forKey: .dailyForecasts)
    }
}
