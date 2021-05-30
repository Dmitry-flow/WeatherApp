
import UIKit

protocol WeatherView: class {
    
}

class WeatherViewController: UIViewController {
    
    private var presenter: WeatherPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func inject(presenter: WeatherPresenter) {
        self.presenter = presenter
    }
}

// MARK: - WeatherView

extension WeatherViewController: WeatherView {
    
}
