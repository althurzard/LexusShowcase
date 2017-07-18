//
//  BaseCollectionViewCell.swift
//  LexusApp
//
//  Created by MacOS on 7/18/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit
import Spring

class BaseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: DesignableImageView!
    
    static let identifier = "BaseCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let selectedView = UIView(frame: self.frame)
        selectedView.backgroundColor = .white
        selectedView.layer.borderWidth = imageView.borderWidth
        selectedView.layer.cornerRadius = imageView.cornerRadius
        self.selectedBackgroundView = selectedView
    }

}
