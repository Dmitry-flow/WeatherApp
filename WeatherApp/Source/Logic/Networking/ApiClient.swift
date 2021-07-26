import Foundation
import Alamofire

enum ApiDomain: String {
    case openWeather = "api.weatherapi.com"
}

enum ApiRequest {
    case weatherForecast(String)
}

protocol ApiClient {
    
    func request(cityName: String, onSuccess: @escaping (ForecastResponse) -> ())
}

final class ApiClientImp {
    
    let apiKey = "4e2d0f7b48e64258865105146210806"
}

//MARK: - ApiClient

extension ApiClientImp: ApiClient {
    
    func request(cityName: String, onSuccess: @escaping (ForecastResponse) -> ()) {
        
        let url = makeURL(request: .weatherForecast(cityName))
        
        AF.request(url, method: .get, encoding: URLEncoding.default).responseJSON { response in
            guard let data = response.data,
                  let json: ForecastResponse = try? JSONDecoder().decode(ForecastResponse.self, from: data) else { return }
            onSuccess(json)
        }
    }
    
    func makeURL(request: ApiRequest) -> URL {
        switch request {
        case .weatherForecast(let city):
            return URL(string: "http://\(ApiDomain.openWeather.rawValue)/v1/forecast.json?key=\(apiKey)&q=\(city)&days=3&aqi=no&alerts=no")!
        }
    }
}



