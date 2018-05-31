import UIKit

class PermissionHandler {
    enum Result {
        case success
        case failure
    }
    
    enum PermissionType {
        case camera
        case cameraRoll
        case location
        case micro
        case facebook
        case twitter
    }
    
    static let shared = PermissionHandler()
    
    private let cameraPermissionHandler = CameraPermissionHandler()
    private let cameraRollPermissionHander = CameraRollPermissionHandler()
    private let locationPermissionHandler = LocationPermissionHandler()
    private let microPermissionHandler = MicroPermissionHandler()
    private let facebookPermissionHandler = FacebookPermissionHandler()
    private let twitterPermissionHandler = TwitterPermissionHandler()
    
    func check(permission: PermissionType, from vc: UIViewController, completion: @escaping (Result) -> Void) {
        switch permission {
        case .camera:
            cameraPermissionHandler.check(from: vc, completion: completion)
        case .cameraRoll:
            cameraRollPermissionHander.check(from: vc, completion: completion)
        case .location:
            locationPermissionHandler.check(from: vc, completion: completion)
        case .micro:
            microPermissionHandler.check(from: vc, completion: completion)
        case .facebook:
            facebookPermissionHandler.check(from: vc, completion: completion)
        case .twitter:
            twitterPermissionHandler.check(from: vc, completion: completion)
        }
    }
}
