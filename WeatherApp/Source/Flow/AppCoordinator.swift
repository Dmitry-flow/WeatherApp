
import Foundation
import UIKit
import Swinject
import SwinjectAutoregistration

enum Route {
    case main
    case search
    case weather
}

class AppCoordinator {
    
    private let tapBarController = UITabBarController()
    
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
        
        setupTapBar()
    }
}

// MARK: - Navigate

extension AppCoordinator: Coordinator {
    
    func navigate(to route: Route) {
    }
}

// MARK: - Start

extension AppCoordinator: Coordination {
    
    var root: UIViewController {
        tapBarController
    }
    
    func start() {
        let localCoordinator = resolver ~> LocalCordinator.self
        let favoritesCoordinator = resolver ~> FavoritesCoordinator.self

        tapBarController.setViewControllers([localCoordinator.root, favoritesCoordinator.root], animated: false)
        localCoordinator.start()
        favoritesCoordinator.start()
        

    }
}

// MARK: - Private

private extension AppCoordinator {
    
    func setupTapBar() {
        
    }
}
 
