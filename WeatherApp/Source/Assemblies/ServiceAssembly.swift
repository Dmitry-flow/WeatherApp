

import Foundation
import Swinject
import SwinjectAutoregistration

final class ServiceAssembly {}

// MARK: - Assembly

extension ServiceAssembly: Assembly {
    func assemble(container: Container) {
        assemblyNetworking(container: container)
        assemblyLocation(container: container)
    }
}

// MARK: - Private

private extension ServiceAssembly {
    
    func assemblyNetworking(container: Container) {
        container.autoregister(ApiClient.self, initializer: ApiClientImp.init)
    }
    
    func assemblyLocation(container: Container) {
        container.autoregister(LocationService.self, initializer: LocationServiceImp.init)
    }
}


