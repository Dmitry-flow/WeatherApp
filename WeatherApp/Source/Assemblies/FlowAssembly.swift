

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
        
        container.register(StartCordinator.self) { (resolver) in
            StartCordinator(resolver: resolver)
        }.inObjectScope(.container)
    }
}
