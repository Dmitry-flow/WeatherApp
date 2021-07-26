
import Foundation
import UIKit
import Rswift
import Swinject
import SwinjectAutoregistration

final class FavoritesCoordinator {
    
    private let resolver: Resolver
    
    let navigationController = UINavigationController()
    
    init(resolver: Resolver) {
        
        self.resolver = resolver
        
        appearance()
    }
}

// MARK: - Start

extension FavoritesCoordinator: Coordination {
    
    var root: UIViewController {
        navigationController
    }

    func start() {
        let favoritesViewController = resolver ~> FavouritesViewController.self
        navigationController.setViewControllers([favoritesViewController], animated: false)
    }
}

// MARK: - Navigation

extension FavoritesCoordinator: Coordinator {
    
    func navigate(to route: Route) {
        switch route {
        case .main:
            navigationController.pushViewController(UIViewController(), animated: true)
            
        case .weather:
            navigationController.pushViewController(UIViewController(), animated: true)
            
        default:
            break
        }
    }
}

// MARK: - Appearance

extension FavoritesCoordinator {
    
    func appearance() {
        navigationController.navigationBar.barTintColor = .systemBlue
    }
}
