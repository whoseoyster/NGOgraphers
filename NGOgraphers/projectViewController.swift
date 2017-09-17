//
//  projectViewController.swift
//  NGOgraphers
//
//  Created by Rishab Ramanathan on 7/22/17.
//  Copyright © 2017 Rishab Ramanathan. All rights reserved.
//

import UIKit
//import ArcGISToolkit
import ArcGIS
import SafariServices

class projectViewController: UIViewController {

    @IBOutlet weak var projectNameLabel: UILabel!
    
    @IBOutlet weak var charityNameLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var donorsLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var fundedLabel: UILabel!
    @IBOutlet weak var toGoLabel: UILabel!
    @IBOutlet weak var donationGraph: LinearGraph!
    
    var url:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        projectNameLabel.text = globalVars.projectData?["Project"] as! String
        charityNameLabel.text = "by \(globalVars.projectData?["Entity"] as! String)"
        
        donorsLabel.text = "\(globalVars.projectData?["NumDonors"] as! Int) DONORS"
        let type = globalVars.projectData?["ProjCateg"] as! String
        
        let targ = globalVars.projectData?["TargAmount"] as! Int
        let curr = globalVars.projectData?["CurrAmount"] as! Int
        
        deadlineLabel.text = "\(globalVars.projectData?["NumDonors"] as! Int + 7) DAYS TO GO"
        
        descriptionLabel.text = globalVars.projectData?["ProjDesc"] as! String
        
        fundedLabel.text = "$\(curr) Funded"
        toGoLabel.text = "$\(targ - curr) To Go"
        
        let percentage: Double = Double(curr)/Double(targ)
        
        donationGraph.percentage = CGFloat(percentage)
        
        globalVars.url = globalVars.projectData?["StoryMap"] as! String
        
        switch type {
        case "HE":
            typeLabel.text = "HEALTH CARE"
        case "ENV":
            typeLabel.text = "ENVIRONMENTAL"
        case "EDU":
            typeLabel.text = "EDUCATION"
        case "DR":
            typeLabel.text = "DISASTER RELIEF"
        case "CW":
            typeLabel.text = "CLEAN WATER"
        default:
            break
        }
        
        
        print(globalVars.projectData?["ExpirDate"])
        
//        deadlineLabel.text = "\(globalVars.projectData?["ExpirDate"] as! String) DAYS TO GO"

        
    }
    
//    @IBAction func storyMapButtonPressed(_ sender: Any) {
//        let svc = SFSafariViewController(url: URL(string:url)!)
//        self.present(svc, animated: true, completion: nil)
//    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        donationGraph.animateLine(duration: 0.8)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func viewStorymapPressed(_ sender: Any) {
    }
    
    @IBAction func donatePressed(_ sender: Any) {
    }

    
}

