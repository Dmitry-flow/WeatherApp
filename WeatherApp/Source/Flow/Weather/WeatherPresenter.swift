
import Foundation
import CoreLocation

protocol WeatherPresenter {

    var city: String { get }
    var weather: Weather  { get }
    var dailyForecasts: [DailyWeather] { get }
}

final class WeatherPresenterImp {
    
    private var forecast: Forecast?
    
    private weak var view: WeatherView?
    private weak var coordinator: Coordinator?
    
    private let apiClient: ApiClient
    private let locationService: LocationService
    
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

private extension WeatherPresenterImp {
    
    func getData(city: String) {
        apiClient.request(cityName: city) { (forecast) in
            self.forecast = Forecast(
                dailyForecasts: forecast.dailyForecasts.map({
                    DailyWeather(
                        icon: $0.icon,
                        date: $0.date,
                        tempMin: $0.tempMin,
                        tempMax: $0.tempMax)
                }),
                weather: Weather(
                    temp: forecast.weather.temp,
                    text: forecast.weather.text,
                    feelsLike: forecast.weather.feelsLike),
                currentCity: city)
            DispatchQueue.main.async {
                self.view?.update()
            }
        }
    }
}

// MARK: - Location

private extension WeatherPresenterImp {
    
    func getLocation() {
        
        locationService.getLocation() { cityName in
            self.getData(city: cityName)
        }
    }
}




