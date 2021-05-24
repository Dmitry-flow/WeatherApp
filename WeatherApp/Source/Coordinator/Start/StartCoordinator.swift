
import Foundation
import UIKit
import Rswift
import Swinject
import SwinjectAutoregistration

class StartCordinator {
    
    private let resolver: Resolver
    
    let rootViewController = UINavigationController()

    init(resolver: Resolver) {
        self.resolver = resolver
    }
}

extension StartCordinator: Coordinator {
    
    var root: UIViewController {
        rootViewController
    }
    
    func start() {
        let startViewController = resolver ~> MainViewController.self
        rootViewController.setViewControllers([startViewController], animated: false)
    }
    
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

