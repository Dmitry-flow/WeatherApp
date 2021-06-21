
import Foundation
import CoreLocation
import CoreMotion
import UserNotifications

protocol LocationService {
    func getLocation(onSuccess: @escaping (String) -> ())
}

class LocationServiceImp: NSObject {
    
    var didGetCity: ((String) -> ())?
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        
        locationManager.delegate = self
    }
}

// MARK: - Start

extension LocationServiceImp: LocationService {
    
    func start() {
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getLocation(onSuccess: @escaping (String) -> ())  {
        start()
        didGetCity = onSuccess
    }
}

//MARK: - LocationManager

extension LocationServiceImp: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            if currentLocation.horizontalAccuracy > 0 {
                locationManager.stopUpdatingLocation()
                let coordinates = CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
                reverseCoordinates(coordinates)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - ReverseCoordinates

extension LocationServiceImp {
    
    func reverseCoordinates(_ coordinates: CLLocation) {
        
        CLGeocoder().reverseGeocodeLocation(coordinates) { placemarks, error in
            
            guard let city = placemarks?.first?.locality else {
                let errorString = error?.localizedDescription ?? "Unexpected Error"
                print("Unable to reverse geocode the given location. Error: \(errorString)")
                return
            }
            self.didGetCity?(city)
        }
    }
}

