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
    
    lazy var animationToLeft: [StockAnimation] = [.fadeIn,.slide(.left, .moderately)]
    lazy var animationToRight: [StockAnimation] = [.fadeIn,.slide(.right, .moderately)]
    lazy var animationToBottom: [StockAnimation] = [.fadeIn,.slide(.down, .moderately)]
    lazy var animationToUp: [StockAnimation] = [.fadeIn,.slide(.up, .moderately)]
    
    var isAnimating = true
    let duration = 1.5
    
    @IBOutlet weak var stackViewTopLeft: UIStackView?
    
    @IBOutlet weak var stackViewTopMiddle: UIStackView?
    
    @IBOutlet weak var stackViewTopRight: UIStackView?
    
    @IBOutlet weak var stackViewBottomLeft: UIStackView?
    
    @IBOutlet weak var stackViewBottomMiddle: UIStackView?
    
    @IBOutlet weak var stackViewBottomRight: UIStackView?
    
    public override func setup() {
        super.setup()
        prepareAnimation()
    }
    
    public override func update() {
        super.update()
        selectionStyle = .none
        
    }
    
    open func startAnimation() {
        if !isAnimating {
            self.stackViewTopLeft?.spruce.animate(animationToRight, duration: duration)
            self.stackViewBottomLeft?.spruce.animate(animationToRight, duration: duration)
            self.stackViewTopRight?.spruce.animate(animationToLeft, duration: duration)
            self.stackViewBottomRight?.spruce.animate(animationToLeft, duration: duration)
            self.stackViewTopMiddle?.spruce.animate(animationToBottom, duration: duration)
            self.stackViewBottomMiddle?.spruce.animate(animationToUp, duration: duration)
            
            isAnimating = true
        }
        
    }
    
    open func prepareAnimation() {
        if isAnimating {
        isAnimating = false
        self.stackViewTopLeft?.spruce.prepare(with: animationToRight)
        self.stackViewBottomLeft?.spruce.prepare(with: animationToRight)
        self.stackViewTopRight?.spruce.prepare(with: animationToLeft)
        self.stackViewBottomRight?.spruce.prepare(with: animationToLeft)
        self.stackViewTopMiddle?.spruce.prepare(with: animationToBottom)
        self.stackViewBottomMiddle?.spruce.prepare(with: animationToUp)
        }
    }
}


final class CustomBodyRow: Row<CustomBodyCell>, RowType {
    
    required public init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<CustomBodyCell>(nibName: "CustomBodyCell")
        
    }
    
}
