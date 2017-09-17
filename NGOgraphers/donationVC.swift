//
//  donationVC.swift
//  NGOgraphers
//
//  Created by Rishab Ramanathan on 7/23/17.
//  Copyright © 2017 Rishab Ramanathan. All rights reserved.
//

import UIKit

class donationVC: UIViewController {
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBOutlet weak var charityLabel: UILabel!
    
    @IBOutlet weak var projectLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        amountTextField.becomeFirstResponder()
        
        projectLabel.text = "Project: \(globalVars.projectData?["Project"] as! String)"
        charityLabel.text = globalVars.projectData?["Entity"] as! String
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
