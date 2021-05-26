

import Foundation
import Swinject
import SwinjectAutoregistration

final class FlowAssembly {
    
}

//MARK: - FlowAssembly

extension FlowAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AppCoordinator.self) { (resolver) in
            AppCoordinator(resolver: resolver)
        }.inObjectScope(.container)
        
        container.register(LocalCordinator.self) { (resolver) in
            LocalCordinator(resolver: resolver)
        }.inObjectScope(.container)
        
        container.register(FavoritesCoordinator.self) { (resolver) in
            FavoritesCoordinator(resolver: resolver)
        }.inObjectScope(.container)
    }
}
