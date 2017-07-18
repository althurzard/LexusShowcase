//
//  CustomFooterView.swift
//  LexusApp
//
//  Created by MacOS on 7/17/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit

class CustomFooterView: UIView {

    static let height:CGFloat = 20.0
    class func instanceFromNib() -> CustomFooterView {
        return UINib(nibName: "CustomFooterView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomFooterView
    }

}
