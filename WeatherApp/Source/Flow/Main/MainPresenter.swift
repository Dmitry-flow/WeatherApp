
import Foundation

protocol MainPresenter {

}

class MainPresenterImp {

    private weak var view: MainView?
    private weak var coordinator: Coordinator?

    init(view: MainView, coordinator: Coordinator) {
        self.view = view
        self.coordinator = coordinator
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            coordinator.navigate(to: .weather)
        }
    }
}

// MARK: - MainPresenter

extension MainPresenterImp: MainPresenter {
    
}

