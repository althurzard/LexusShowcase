//
//  CustomOverviewCell.swift
//  LexusApp
//
//  Created by Nguyen Quoc Vuong on 6/30/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit
import Eureka
import Spruce
import Spring
class CustomOverviewCell: Cell<Bool>, CellType {
    
    
    fileprivate lazy var animation: [StockAnimation] = [.fadeIn,.expand(.moderately)]
    
    fileprivate var isAnimating = false

    public override func setup() {
        super.setup()
        prepareAnimation()
    }
    
    public override func update() {
        super.update()
        backgroundColor =  .black
    }

    func startAnimation() {
        if !isAnimating {

            for view in self.subviews {
                for subview in view.subviews {
                    if let image = subview as? SpringImageView {

                        image.animate()

                    }
                }
               
            }
            
            isAnimating = true
        }
        
    }
    
    func prepareAnimation() {
        isAnimating = false
        //self.spruce.hideAllSubviews()
        for view in self.subviews {
            for subview in view.subviews {
                if let image = subview as? SpringImageView {
                    image.alpha = 0.0
                    
                }
            }
            
        }
        //self.spruce.prepare(with: animation)
    }
    
    
}

final class CustomOverviewRow: Row<CustomOverviewCell>, RowType {
    
    required public init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<CustomOverviewCell>(nibName: "CustomOverviewCell")
    }
    
}
