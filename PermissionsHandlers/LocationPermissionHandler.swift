import UIKit
import CoreLocation

class LocationPermissionHandler: NSObject {
    
    private let locationManager = CLLocationManager()
    private var locationHandlerCompletion: ((PermissionHandler.Result) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    //MARK: - Check current permission
    func check(from vc: UIViewController, completion: @escaping (PermissionHandler.Result) -> Void) {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            completion(.success)
        case .notDetermined:
            requestLocation(completion: completion)
        case .restricted, .denied:
            // Show some alert
            completion(.failure)
        }
    }
    
    //MARK: - Request Location
    private func requestLocation(completion: @escaping (PermissionHandler.Result) -> Void) {
        locationManager.requestWhenInUseAuthorization()
        locationHandlerCompletion = { result in
            completion(result)
        }
    }
}

extension LocationPermissionHandler: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationHandlerCompletion?(.success)
        case .restricted, .denied:
            locationHandlerCompletion?(.failure)
        default:
            break
        }
    }
}
