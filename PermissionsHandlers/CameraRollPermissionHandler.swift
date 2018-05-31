import UIKit
import Photos

class CameraRollPermissionHandler {
    
    //MARK: - Check current permission
    func check(from vc: UIViewController, completion: @escaping (PermissionHandler.Result) -> Void) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            completion(.success)
        case .notDetermined:
            requestCameraRoll(completion: completion)
        case .denied, .restricted:
            // Show some alert
            completion(.failure)
        }
    }
    
    //MARK: - Request Camera Roll
    private func requestCameraRoll(completion: @escaping (PermissionHandler.Result) -> Void) {
        PHPhotoLibrary.requestAuthorization({ status in
            DispatchQueue.main.async {
                if status == .authorized {
                    completion(.success)
                } else {
                    completion(.failure)
                }
            }
        })
    }
}
