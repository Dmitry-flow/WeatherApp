
import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellSet()
    }
}

// MARK: - WeatherTableViewCell

extension WeatherTableViewCell {
    
    func update(model: DailyWeather) {
        let max = String(model.tempMax)
        let min = String(model.tempMin)
        let url = URL(string: model.icon)
        
        maxTempLabel.text = max
        minTempLabel.text = min
        
        dayLabel.text = getData(date: model.date)
        loadImage(url: url!)
    }
    
    func cellSet() {
        selectionStyle = .none
        backgroundColor = .clear
    }
}

// MARK: - loadImage

extension WeatherTableViewCell {
    
    func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.iconImage.image = image
                }
            }
        }
    }
}

// MARK: - formattedData

extension WeatherTableViewCell {
    
    func getData(date: String) -> String {
        var dateToday = ""
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy, MM, dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "EEEE"
        
        if let today = dateFormatterGet.date(from: date) {
            dateToday = dateFormatterPrint.string(from: today)
        } else {
            print("There was an error decoding the string")
        }
        return dateToday
    }
}

