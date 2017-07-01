//
//  CustomHeaderSectionView.swift
//  LexusApp
//
//  Created by Nguyen Quoc Vuong on 7/1/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit

class CustomHeaderSectionView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    class func instanceFromNib() -> CustomHeaderSectionView {
        return UINib(nibName: "CustomHeaderSectionView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomHeaderSectionView
    }
}
