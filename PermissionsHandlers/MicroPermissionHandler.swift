import UIKit
import AVFoundation

class MicroPermissionHandler {
    
    //MARK: - Check current permission
    func check(from vc: UIViewController, completion: @escaping (PermissionHandler.Result) -> Void) {
        switch AVAudioSession.sharedInstance().recordPermission() {
        case .granted:
            completion(.success)
        case .undetermined:
            requestMicro(completion: completion)
        case .denied:
            // Show some alert
            completion(.failure)
        }
    }
    
    //MARK: - Request Microphone
    private func requestMicro(completion: @escaping (PermissionHandler.Result) -> Void) {
        AVAudioSession.sharedInstance().requestRecordPermission { (granted) in
            if granted {
                completion(.success)
            } else {
                completion(.failure)
            }
        }
    }
}
