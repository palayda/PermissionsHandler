import UIKit
import AVFoundation

class CameraPermissionHandler {
    
    //MARK: - Check current permission
    func check(from vc: UIViewController, completion: @escaping (PermissionHandler.Result) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            completion(.success)
        case .notDetermined:
            requestCamera(completion: completion)
        case .denied, .restricted:
            // Show some alert
            completion(.failure)
        }
    }
    
    //MARK: - Request Camera
    private func requestCamera(completion: @escaping (PermissionHandler.Result) -> Void) {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted) in
            if granted {
                completion(.success)
            } else {
                completion(.failure)
            }
        })
    }
}
