
import Foundation
import CoreLocation
import CoreMotion
import UserNotifications

protocol LocationService {
    
    func getLocation(onSuccess: @escaping (String) -> ())
}

final class LocationServiceImp: NSObject {
    
    var cityCompletion: ((String) -> ())?
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
        cityCompletion = onSuccess
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

private extension LocationServiceImp {
    
    func reverseCoordinates(_ coordinates: CLLocation) {
        
        CLGeocoder().reverseGeocodeLocation(coordinates) { placemarks, error in
            
            guard let city = placemarks?.first?.locality else {
                let errorString = error?.localizedDescription ?? "Unexpected Error"
                print("Unable to reverse geocode the given location. Error: \(errorString)")
                return
            }
            self.cityCompletion?(city)
        }
    }
}

