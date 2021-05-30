
import Foundation

protocol FavouritesPresenter {

}

class FavouritesPresenterImp {

    private weak var view: FavouritesView?
    private weak var coordinator: Coordinator?
    

    init(view: FavouritesView, coordinator: Coordinator) {
        self.view = view
        self.coordinator = coordinator
    }
}

// MARK: - FavouritesPresenter

extension FavouritesPresenterImp: FavouritesPresenter {
    
}

