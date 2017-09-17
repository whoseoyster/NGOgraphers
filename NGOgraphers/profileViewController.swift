//
//  profileViewController.swift
//  NGOgraphers
//
//  Created by Rishab Ramanathan on 7/25/17.
//  Copyright © 2017 Rishab Ramanathan. All rights reserved.
//

import UIKit
//import ArcGISToolkit
import ArcGIS

class profileViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Adelle Sans", size: 20)!]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
}
