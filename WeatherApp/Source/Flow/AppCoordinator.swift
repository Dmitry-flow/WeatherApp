
import Foundation
import UIKit
import Swinject
import SwinjectAutoregistration

final class AppCoordinator {
    
    private let tapBarController = UITabBarController()
    
    private let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
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
        
        setupTapBar(with: [localCoordinator.root, favoritesCoordinator.root])

    }
}

// MARK: - Private

private extension AppCoordinator {
    
    func setupTapBar(with viewControllers: [UIViewController]) {
        viewControllers.first?.tabBarItem = UITabBarItem(title: "My location", image: R.image.cloudy(), tag: 0)
        viewControllers.last?.tabBarItem = UITabBarItem(title: "Favorites", image: R.image.star(), tag: 1)
        
        tapBarController.tabBar.barTintColor = .systemPurple
        tapBarController.tabBar.tintColor = .white
    }
}
 
