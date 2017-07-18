//
//  CustomRadioBarView.swift
//  LexusApp
//
//  Created by MacOS on 7/18/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit

class CustomRadioBarView: UIView {

    

    class func instanceFromNib() -> CustomRadioBarView {
        return UINib(nibName: "CustomRadioBarView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomRadioBarView
    }
}
