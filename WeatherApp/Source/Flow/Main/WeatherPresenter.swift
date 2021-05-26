
import Foundation

protocol WeatherPresenter {

}

class WeatherPresenterImp {

    private weak var view: WeatherView?
    private weak var coordinator: Coordinator?

    init(view: WeatherView, coordinator: Coordinator) {
        self.view = view
        self.coordinator = coordinator
        
    }
}

// MARK: - WeatherPresenter

extension WeatherPresenterImp: WeatherPresenter {
    
}

