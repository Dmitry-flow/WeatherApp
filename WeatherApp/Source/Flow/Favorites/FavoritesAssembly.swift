
import Foundation
import Rswift
import Swinject
import SwinjectAutoregistration

class FavouritesAssembly {
    
}

// MARK: - FavouritesAssembly

extension FavouritesAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(FavouritesViewController.self) { resolver in
            let view = R.storyboard.favorites.instantiateInitialViewController()!
            
            let presenter = resolver.resolve(FavouritesPresenter.self, argument: view)!
            view.inject(presenter: presenter)
            
            return view
        }
        
        container.register(FavouritesPresenter.self) { (resolver, view: FavouritesViewController) in
            let coordinator = resolver ~> FavoritesCoordinator.self
            return FavouritesPresenterImp(view: view, coordinator: coordinator)
        }
    }
}

