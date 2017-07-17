//
//  CustomLibraryCell.swift
//  LexusApp
//
//  Created by MacOS on 7/17/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit
import Eureka


class CustomLibraryCell: Cell<Bool>, CellType {

    var isAnimating = true
    var libraryView: CustomLibraryView!
    public override func setup() {
        super.setup()
        
        
        libraryView = CustomLibraryView.instanceFromNib()
        
        self.addSubview(libraryView)
        
        libraryView.translatesAutoresizingMaskIntoConstraints = false
        libraryView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -10).isActive = true
        libraryView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        libraryView.topAnchor.constraint(equalTo: self.topAnchor, constant: -10).isActive = true
        libraryView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10).isActive = true
        
        prepareAnimation()
    }
    
    public override func update() {
        super.update()
        selectionStyle = .none
        
    }
    
    func prepareAnimation() {
        if isAnimating {
            libraryView.prepareAnimation()
            isAnimating = false
        }
        
    }
    
    func startAnimation() {
        if !isAnimating {
            libraryView.startAnimation()
            isAnimating = true
        }
    }
    
    
}


final class CustomLibraryRow: Row<CustomLibraryCell>, RowType {
    
    required public init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<CustomLibraryCell>(nibName: "CustomLibraryCell")
    }
    
    
}
