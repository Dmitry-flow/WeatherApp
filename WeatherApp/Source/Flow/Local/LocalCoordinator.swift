
import Foundation
import UIKit
import Rswift
import Swinject
import SwinjectAutoregistration

class LocalCordinator {
    
    private let resolver: Resolver
    
    let rootViewController = UINavigationController()
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
}

// MARK: - Start

extension LocalCordinator: Coordination {
    
    var root: UIViewController {
        rootViewController
    }
    
    func start() {
        let localViewController = resolver ~> WeatherViewController.self
        rootViewController.setViewControllers([localViewController], animated: false)
    }
}

// MARK: - Navigate

extension LocalCordinator: Coordinator {
    
    func navigate(to route: Route) {
        switch route {
        case .main:
            rootViewController.pushViewController(UIViewController(), animated: true)
            
        case .weather:
            rootViewController.pushViewController(UIViewController(), animated: true)
            
        default:
            break
        }
    }
}

