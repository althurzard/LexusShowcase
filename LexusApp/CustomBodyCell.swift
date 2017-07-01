//
//  CustomBodyCell.swift
//  LexusApp
//
//  Created by Nguyen Quoc Vuong on 6/30/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit
import Eureka
import Spruce

class CustomBodyCell: Cell<Bool>, CellType {
    
    fileprivate lazy var animation: [StockAnimation] = [.fadeIn,.slide(.left, .moderately)]
    
    fileprivate var isAnimating = false
    
    public override func setup() {
        super.setup()
        //prepareAnimation()
    }
    
    public override func update() {
        super.update()

        
    }
    
    func startAnimation() {
        if !isAnimating {
            self.spruce.animate(animation, duration: 1.5)
            isAnimating = true
        }
        
    }
    
    func prepareAnimation() {
        isAnimating = false
        self.spruce.prepare(with: animation)
    }
}


final class CustomBodyRow: Row<CustomBodyCell>, RowType {
    
    required public init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<CustomBodyCell>(nibName: "CustomBodyCell")
        
    }
    
}
