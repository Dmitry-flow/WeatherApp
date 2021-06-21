
import Foundation
import CoreLocation

protocol WeatherPresenter {
    
    var city: String { get }
    var weather: Weather  { get }
    var dailyForecasts: [DailyWeather] { get }
}

class WeatherPresenterImp {
    
    private var forecast: Forecast?
    
    private weak var view: WeatherView?
    private weak var coordinator: Coordinator?
    private let apiClient: ApiClient
    private var locationService: LocationService
    
    init(
        view: WeatherView,
        coordinator: Coordinator,
        apiClient: ApiClient,
        locationService: LocationService) {
        
        self.view = view
        self.coordinator = coordinator
        self.apiClient = apiClient
        self.locationService = locationService
        getLocation()
    }
}

// MARK: - WeatherPresenter

extension WeatherPresenterImp: WeatherPresenter {
    
    var dailyForecasts: [DailyWeather] {
        forecast?.dailyForecasts ?? []
    }
    
    var weather: Weather {
        forecast?.weather ?? .init(temp: 0.0, text: "Error", feelsLike: 0.0)
    }
    
    var city: String {
        forecast?.currentCity ?? ""
    }
}

// MARK: - Request

extension WeatherPresenterImp {
    
    func getData(city: String) {
        apiClient.request(cityName: city) { (forecast) in
            self.forecast = forecast
            
            DispatchQueue.main.async {
                self.view?.update()
            }
        }
    }
}

// MARK: - Location

extension WeatherPresenterImp {
    
    func getLocation() {
        
        locationService.getLocation() { cityName in
            self.getData(city: cityName)
        }
    }
}
