
import UIKit

protocol WeatherView: class {
    func update()
}

class WeatherViewController: UIViewController {
    
    private var presenter: WeatherPresenter!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var fellsLikeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let weatherCellId = "WeatherTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: weatherCellId, bundle: nil), forCellReuseIdentifier: weatherCellId)
        tableView.rowHeight = 70
        tableView.separatorColor = .none
        
        updateLabel()
    }
    
    func inject(presenter: WeatherPresenter) {
        self.presenter = presenter
    }
}

// MARK: - WeatherView

extension WeatherViewController: WeatherView {
    func update() {
        updateLabel()
        tableView.reloadData()
    }
    
    
}

// MARK: - TableView

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.dailyForecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: weatherCellId, for: indexPath) as! WeatherTableViewCell
        cell.selectionStyle = .none
        let modelForecast = presenter.dailyForecasts[indexPath.row]
        cell.update(model: modelForecast)
        return cell
    }
    
    
}

// MARK: - Update

extension WeatherViewController {
    
    func updateLabel() {
        let temperature = String(presenter.weather.temp)
        let fellsLikeTemperature = String(presenter.weather.feelsLike)
        cityLabel.text = presenter.city
        statusLabel.text = presenter.weather.text
        tempLabel.text = temperature
        fellsLikeLabel.text = "Feels like: \(fellsLikeTemperature)"
    }
}
