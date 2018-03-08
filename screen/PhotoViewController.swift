//
//  PhotoViewController.swift
//  screen
//
//  Created by Joseph Ugowe on 3/8/18.
//  Copyright © 2018 Joseph Ugowe. All rights reserved.
//

import Foundation
import UIKit

class PhotoViewController: UIViewController {
    
    var takenPhoto: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        if let availableImage = takenPhoto {
            imageView.image = availableImage
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
