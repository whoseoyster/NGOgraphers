//
//  storyMapViewController.swift
//  NGOgraphers
//
//  Created by Rishab Ramanathan on 7/22/17.
//  Copyright © 2017 Rishab Ramanathan. All rights reserved.
//

import UIKit
import SafariServices

class storyMapViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        webView.loadRequest(URLRequest(url: URL(string: globalVars.url!)!))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
}

