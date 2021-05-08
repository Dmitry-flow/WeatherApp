

import Foundation
import Swinject
import SwinjectAutoregistration

final class FlowAssembly {
    
}

//MARK: - FlowAssembly

extension FlowAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(AppFlow.self) { (resolver) in
            AppFlow(resolver: resolver)
        }.inObjectScope(.container)
    }
}
