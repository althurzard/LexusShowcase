//
//  ColorPickerViewCell.swift
//  LexusApp
//
//  Created by MacOS on 7/18/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit

class ColorPickerViewCell: UICollectionViewCell {

    static let identifier = "ColorPickerViewCell"
    
    var indexPath: IndexPath!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var colorName: String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initSelectedBackgroundView()
    }
    
    func initSelectedBackgroundView() {
        let selectedView = UIView(frame: self.frame)
        selectedView.backgroundColor = .white
        selectedView.layer.borderWidth = 1.5
        selectedView.clipsToBounds = true
        selectedView.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2  + 5
        selectedView.layer.borderColor = UIColor.gray.cgColor
        selectedView.backgroundColor = .clear
        self.selectedBackgroundView = selectedView
    }
    
    

}
