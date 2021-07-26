
import UIKit

protocol FavouritesView: class {
    
}

class FavouritesViewController: UIViewController {
    
    private var presenter: FavouritesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradientColor()
    }
    
    func inject(presenter: FavouritesPresenter) {
        self.presenter = presenter
    }
}

// MARK: - GradientColor

extension FavouritesViewController: FavouritesView {

        func gradientColor() {
            let newLayer = CAGradientLayer()
            newLayer.colors = [UIColor.systemBlue.cgColor, UIColor.purple.cgColor]
            newLayer.frame = view.frame
            view.layer.insertSublayer(newLayer, at: 0)
        }
}


