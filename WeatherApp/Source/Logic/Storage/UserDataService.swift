
import Foundation

protocol UserDataService {
    
    var forecasts: [DailyWeather] { get set }
}

class UserDataServiceImp {
    
    private let userDefaultsService: UserDefaultsService
    
    init(userDefaultsService: UserDefaultsService) {
        self.userDefaultsService = userDefaultsService
    }
}

//MARK: - UserDataService

extension UserDataServiceImp: UserDataService {
    
    var forecasts: [DailyWeather] {
        get {
            userDefaultsService.value(for: .forecast) ?? []
        }
        set {
            userDefaultsService.save(newValue, for: .forecast)
        }
    }
}

