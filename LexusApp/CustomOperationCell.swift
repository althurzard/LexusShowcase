//
//  CustomOperationCell.swift
//  LexusApp
//
//  Created by MacOS on 7/15/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit
import Eureka
import Spruce
import IncrementableLabel

class Operation {
    var speedTime = 7.5
    var power = 241
    var maxSpeed = 230
}
class CustomOperationCell: CustomBodyCell {

    @IBOutlet weak var numberView: UIView!
    
    @IBOutlet weak var lblNumberSpeedTime: IncrementableLabel!

    @IBOutlet weak var lblNumberPower: IncrementableLabel!
    
    @IBOutlet weak var lblNumberMaxSpeed: IncrementableLabel!
    
    var operation = Operation()
    
    public override func setup() {
        super.setup()
        
    }
    
    public override func update() {
        super.update()
        
    }
    
    override func startAnimation() {
        if !isAnimating {
            super.startAnimation()
            self.numberView.spruce.animate(animationToUp, duration: duration)
            
            lblNumberSpeedTime.option = .EaseInOut
            lblNumberSpeedTime.stringFormatter = { value in
                return String(format: "%.1f", value)
            }
            lblNumberSpeedTime.incrementFromZero(toValue: operation.speedTime, duration: duration)
            
            lblNumberPower.option = .EaseInOut
            lblNumberPower.stringFormatter = { value in
                return String(format: "%d", Int(value))
            }
            lblNumberPower.incrementFromZero(toValue: Double(operation.power), duration: duration)
            
            lblNumberMaxSpeed.option = .EaseInOut
            lblNumberMaxSpeed.stringFormatter = { value in
                return String(format: "%d", Int(value))
            }
            lblNumberMaxSpeed.incrementFromZero(toValue: Double(operation.maxSpeed), duration: duration)
           
        }
        
    }
    
    override func prepareAnimation() {
        if isAnimating {
            super.prepareAnimation()
            self.numberView.spruce.prepare(with: animationToUp)
            
        }
    }
    
}


final class CustomOperationRow: Row<CustomOperationCell>, RowType {
    
    required public init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<CustomOperationCell>(nibName: "CustomOperationCell")
        
    }
    
    var currentContentOffset: CGPoint {
        get { return CGPoint(x: 0, y: self.cell!.height!() * 3) }
    }
    
}
