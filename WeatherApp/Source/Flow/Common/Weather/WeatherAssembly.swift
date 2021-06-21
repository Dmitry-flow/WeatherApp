
import Foundation
import Rswift
import Swinject
import SwinjectAutoregistration

class WeatherAssembly {
}

// MARK: - WeatherAssembly

extension WeatherAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(WeatherViewController.self) { resolver in
            let view = R.storyboard.weather.instantiateInitialViewController()!
            
            let presenter = resolver.resolve(WeatherPresenter.self, argument: view)!
            view.inject(presenter: presenter)
            
            return view
        }
        
        container.register(WeatherPresenter.self) { (resolver, view: WeatherViewController) in
            let coordinator = resolver ~> LocalCordinator.self
            return WeatherPresenterImp(
                view: view,
                coordinator: coordinator,
                apiClient: resolver~>,
                locationService: resolver~>)
        }
    }
}


