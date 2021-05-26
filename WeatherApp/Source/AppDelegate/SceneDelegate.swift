
import UIKit
import Swinject
import SwinjectAutoregistration

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private var assembler: Assembler!

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        configureDependencies()
        configureFlow()
    }
}

//MARK: - Configure

private extension SceneDelegate {
    
    func configureDependencies() {
        let serviceAssembler = Assembler([ServiceAssembly()])
        
        let modulesAssembler = Assembler(
            [
                WeatherAssembly(),
                FavouritesAssembly()
            ],
            parent: serviceAssembler)
        
        assembler = Assembler(
            [FlowAssembly()],
            parent: modulesAssembler)
    }
    
    
    
    func configureFlow() {
        let coordinator = assembler.resolver ~> AppCoordinator.self
        coordinator.start()

        self.window?.rootViewController = coordinator.root
        self.window?.makeKeyAndVisible()
    }
}
