
import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

extension WeatherTableViewCell {
    
    func update(model: DailyWeather) {
        var max = String(model.tempMax)
        var min = String(model.tempMin)
        dayLabel.text = model.date
        maxTempLabel.text = max
        minTempLabel.text = min
    }
}
