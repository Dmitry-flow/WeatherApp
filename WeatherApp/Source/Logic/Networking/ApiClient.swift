import Foundation

enum ApiDomain: String {
    case openWeather = "api.weatherapi.com"
}

enum ApiRequest {
    case weatherForecast(String)
}

protocol ApiClient {
    
    func request(cityName: String, onSuccess: @escaping (Forecast) -> ())
}

final class ApiClientImp {
    
    let apiKey = "4e2d0f7b48e64258865105146210806"
}

//            let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
//            let main = json?["main"] as? [String: Any]
//            let temp = main?["temp"] as? Double

extension ApiClientImp: ApiClient {
    
    
    func request(cityName: String, onSuccess: @escaping (Forecast) -> ()) {
        let url = makeURL(request: .weatherForecast(cityName))
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
            
            guard let data = data,
                  let product: Forecast = try? JSONDecoder().decode(Forecast.self, from: data) else { return }
            onSuccess(product)
            
            if let error = error {
                print(error)
            }
        }
        DispatchQueue.main.async {
            dataTask.resume()
        }
    }
    
    func makeURL(request: ApiRequest) -> URL {
        switch request {
        case .weatherForecast(let city):
            return URL(string: "http://\(ApiDomain.openWeather.rawValue)/v1/forecast.json?key=\(apiKey)&q=\(city)&days=3&aqi=no&alerts=no")!
        }
    }
}

struct Weather: Decodable {
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
}

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

struct DailyWeather: Decodable {
    var date: String
    var tempMin: Double
    var tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case day
        case date
        case temp = "temp_c"
        case tempMin = "mintemp_c"
        case tempMax = "maxtemp_c"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(String.self, forKey: .date)
        let day = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .day)
        tempMin = try day.decode(Double.self, forKey: .tempMin)
        tempMax = try day.decode(Double.self, forKey: .tempMax)
    }
}


