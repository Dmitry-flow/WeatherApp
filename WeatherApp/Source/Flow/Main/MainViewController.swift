
import UIKit

protocol MainView: class {
    
}

class MainViewController: UIViewController {
    
    private var presenter: MainPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
    
    func inject(presenter: MainPresenter) {
        self.presenter = presenter
    }
}

// MARK: - MainView

extension MainViewController: MainView {
    
}
