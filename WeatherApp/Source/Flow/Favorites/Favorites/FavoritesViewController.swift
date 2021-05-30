
import UIKit

protocol FavouritesView: class {

}

class FavouritesViewController: UIViewController {

    private var presenter: FavouritesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func inject(presenter: FavouritesPresenter) {
        self.presenter = presenter
    }
}

// MARK: - FavouritesView

extension FavouritesViewController: FavouritesView {
    
}
