//
//  CameraController.swift
//  screen
//
//  Created by Joseph Ugowe on 3/6/18.
//  Copyright © 2018 Joseph Ugowe. All rights reserved.
//

import Foundation
import AVFoundation

class CameraController {
    
    var captureSession: AVCaptureSession?
    var frontCamera: AVCaptureDevice?
    var rearCamera: AVCaptureDevice?
    var currentCameraPosition: CameraPosition?
    var frontCameraInput: AVCaptureDeviceInput?
    var rearCameraInput: AVCaptureDeviceInput?
    
    /*
     Since configuring and starting a capture session is a relatively intensive procedure, we’re going to decouple it from
     init and create this function 'prepare', that prepares our capture session for use and calls a completion handler
     when it’s done.
    */
    func prepare(completionHandler: @escaping (Error?) -> Void) {
        
        func createCaptureSession() {
            //  Creates a new AVCaptureSession instance and stores it in the captureSession property.
            self.captureSession = AVCaptureSession()
        }
        
        func configureCaptureDevices() throws {
            // Use AVCaptureDeviceDiscoverySession to find all of the wide angle cameras available on the current device and convert them into an array of non-optional AVCaptureDevice instances.
            let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
            let cameras = (session.devices.flatMap { $0 })
            
            // Loop through available cameras & determines whether camera is front or rear
            for camera in cameras {
                if camera.position == .front {
                    self.frontCamera = camera
                }
                
                if camera.position == .back {
                    self.rearCamera = camera
                    
                    // Configure rear camera to autofocus
                    try camera.lockForConfiguration()
                    camera.focusMode = .continuousAutoFocus
                    camera.unlockForConfiguration()
                }
            }
        }
        
        func configureDeviceInputs() throws {}
        func configurePhotoOutput() throws {}
        
        DispatchQueue(label: "prepare").async {
            do {
                createCaptureSession()
                try configureCaptureDevices()
                try configureDeviceInputs()
                try configurePhotoOutput()
            }
            
            catch {
                DispatchQueue.main.async {
                    completionHandler(error)
                }
                return
            }
            
            DispatchQueue.main.async {
                completionHandler(nil)
            }
            
        }
    }
}

extension CameraController {
    
    enum CameraControllerError: Swift.Error {
        case captureSessionAlreadyRunning
        case captureSessionIsMissing
        case inputsAreInvalid
        case invalidOperation
        case noCamerasAvailable
        case unknown
    }
    
    public enum CameraPosition {
        case front
        case rear
    }
}
