
import UIKit

protocol MainView: class {
    
}

class MainViewController: UIViewController {
    
    private var presenter: MainPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
    
    func inject(presenter: MainPresenter) {
        self.presenter = presenter
    }
}

// MARK: - MainView

extension MainViewController: MainView {
    
}
