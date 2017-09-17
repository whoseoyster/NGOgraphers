//
//  CustomButton.swift
//  NGOgraphers
//
//  Created by Rishab Ramanathan on 7/22/17.
//  Copyright © 2017 Rishab Ramanathan. All rights reserved.
//

import UIKit

public class CustomButton: UIButton {
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)

        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor(red: (239/255), green: (242/255), blue: (242/255), alpha: 1.0)
        self.setTitleColor(UIColor(red: (132/255), green: (130/255), blue: (132/255), alpha: 1.0), for: UIControlState.normal)
        self.titleLabel?.textAlignment = NSTextAlignment.center
    }

}

public class CustomButton2: UIButton {
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 8
    }
    
}


public class CustomView: UIView {
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }

}

public class CustomView2: UIView {
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
}

