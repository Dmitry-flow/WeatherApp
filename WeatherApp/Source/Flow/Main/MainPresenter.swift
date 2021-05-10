
import Foundation

protocol MainPresenter {

}

class MainPresenterImp {

    private weak var view: MainView?
    
    init(view: MainView) {
        self.view = view
    }
}

// MARK: - MainPresenter

extension MainPresenterImp: MainPresenter {
    
}

