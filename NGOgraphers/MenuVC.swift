//
//  MenuVC.swift
//  NGOgraphers
//
//  Created by Rishab Ramanathan on 7/22/17.
//  Copyright © 2017 Rishab Ramanathan. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {
    
    @IBOutlet weak var imageBorderView: UIView!
    @IBOutlet weak var profilePicture: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2
        profilePicture.clipsToBounds = true
        
        imageBorderView.layer.cornerRadius = imageBorderView.frame.height/2
        imageBorderView.clipsToBounds = true
        imageBorderView.layer.borderColor = UIColor(red: (255/255), green: (255/255), blue: (255/255), alpha: 1.0).cgColor
        imageBorderView.layer.borderWidth = 2

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
