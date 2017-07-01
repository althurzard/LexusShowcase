//
//  CustomHeader.swift
//  LexusApp
//
//  Created by Nguyen Quoc Vuong on 6/30/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit

class CustomHeader: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CustomHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }

}
