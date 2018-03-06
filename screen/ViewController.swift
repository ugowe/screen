//
//  ViewController.swift
//  screen
//
//  Created by Joseph Ugowe on 3/6/18.
//  Copyright © 2018 Joseph Ugowe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var captureButton: UIButton!
    @IBOutlet weak var toggleFlashButton: UIButton!
    @IBOutlet weak var toggleCameraButton: UIButton!
    @IBOutlet weak var photoModeButton: UIButton!
    @IBOutlet weak var videoModeButton: UIButton!
    
    override var prefersStatusBarHidden: Bool { return true }
    
}

extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleCaptureButton()
    }

    func styleCaptureButton() {
        captureButton.layer.borderColor = UIColor.black.cgColor
        captureButton.layer.borderWidth = 2
        
        captureButton.layer.cornerRadius = min(captureButton.frame.width, captureButton.frame.height) / 2
    }
    
    

}

