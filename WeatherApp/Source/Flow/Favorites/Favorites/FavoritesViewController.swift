
import UIKit

protocol FavouritesView: class {

}

class FavouritesViewController: UIViewController {

    private var presenter: FavouritesPresenter!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func getButton(_ sender: Any) {
        
        getData(city: "London")
        
    }
    
    func inject(presenter: FavouritesPresenter) {
        self.presenter = presenter
    }
}

// MARK: - FavouritesView

extension FavouritesViewController: FavouritesView {
    
    func getData(city: String) {
        
        let apiClient = ApiClientImp()
        apiClient.requestW(cityName: "Kharkiv") { (product) in
            print(product)
        }
        apiClient.requestF(cityName: "Kharkiv") { (product) in
            print(product)
        }
    }
}


