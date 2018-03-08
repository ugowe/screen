//
//  ViewController.swift
//  screen
//
//  Created by Joseph Ugowe on 3/6/18.
//  Copyright © 2018 Joseph Ugowe. All rights reserved.
//

import UIKit
import Photos 

class ViewController: UIViewController {

    @IBOutlet weak var capturePreviewView: UIView!
    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var toggleFlashButton: UIButton!
    @IBOutlet weak var toggleCameraButton: UIButton!
    @IBOutlet weak var photoModeButton: UIButton!
    @IBOutlet weak var videoModeButton: UIButton!
    
    override var prefersStatusBarHidden: Bool { return true }
    let cameraController = CameraController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleCaptureButton()
        configureCameraController()
    }

    func styleCaptureButton() {
        captureButton.layer.borderColor = UIColor.black.cgColor
        captureButton.layer.borderWidth = 2
        
        captureButton.layer.cornerRadius = min(captureButton.frame.width, captureButton.frame.height) / 2
    }
    
    func configureCameraController() {
        
        cameraController.prepare { (error) in
            if let error = error {
                print(error)
            }
            
            try? self.cameraController.displayPreview(on: self.capturePreviewView)
        }
    }
    
    @IBAction func captureImage(_ sender: Any) {
        
        // Call the captureImage method of CameraController to take photo
        cameraController.captureImage { (image, error) in
            guard let image = image else {
                print(error ?? "Image capture error")
                return
            }
            
            // Use the PHPhotoLibary class to save the image to the built-in photo library
            try? PHPhotoLibrary.shared().performChangesAndWait {
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            }
            
            let photoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PhotoVC") as! PhotoViewController
            
            photoVC.takenPhoto = image
            
            DispatchQueue.main.async {
                self.present(photoVC, animated: true, completion: nil)
//                self.present(photoVC, animated: true, completion: {
//                    self.stopCaptureSession()
//                })
            }

        }
    }
    
    
    @IBAction func toggleFlash(_ sender: Any) {
        if cameraController.flashMode == .on {
            cameraController.flashMode = .off
            toggleFlashButton.setImage(#imageLiteral(resourceName: "Flash Off Icon"), for: .normal)
        } else {
            cameraController.flashMode = .on
            toggleFlashButton.setImage(#imageLiteral(resourceName: "Flash On Icon"), for: .normal)
        }
    }
    
    
    @IBAction func switchCameras(_ sender: UIButton) {
        do {
            try cameraController.switchCameras()
        } catch {
            print(error)
        }
        
        switch cameraController.currentCameraPosition {
        case .some(.front):
            toggleCameraButton.setImage(#imageLiteral(resourceName: "Front Camera Icon"), for: .normal)
        case .some(.rear):
            toggleCameraButton.setImage(#imageLiteral(resourceName: "Rear Camera Icon"), for: .normal)
        case .none:
            return
        }
    }
    

}








