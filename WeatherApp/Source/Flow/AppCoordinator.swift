
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
    
    let rootViewController = UITabBarController()
    
    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }
}

extension AppCoordinator: Coordinator {
    
    func navigate(to route: Route) {
    }
    
    var root: UIViewController {
        rootViewController
    }
    
    func start() {
        let startCoordinator = resolver ~> StartCordinator.self
        rootViewController.setViewControllers([startCoordinator.root, UIViewController()], animated: false)
        startCoordinator.start()
    }
}
 
