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
    
    
    fileprivate lazy var animation1: [StockAnimation] = [.fadeIn,.slide(.left, .moderately)]
    fileprivate lazy var animation2: [StockAnimation] = [.fadeIn]
    fileprivate var isAnimating = true
    @IBOutlet weak var desktopImageView: DesignableImageView!
    @IBOutlet weak var overlayImageView: DesignableImageView!
    @IBOutlet weak var desktopView: UIView!
    public override func setup() {
        super.setup()
        prepareAnimation()
    }
    

    
    public override func update() {
        super.update()
        backgroundColor =  .white
        selectionStyle = .none
    }

    func startAnimation() {
        if !isAnimating {

           
            desktopView.spruce.animate(animation1, duration: 1.5)
            overlayImageView.animate()
            
            isAnimating = true
        }
        
    }
    
    func prepareAnimation() {
        if isAnimating {
        isAnimating = false
        desktopView.spruce.prepare(with: animation1)
        overlayImageView.alpha = 0.0

        }
    }
    
    
}

final class CustomOverviewRow: Row<CustomOverviewCell>, RowType {
    
    required public init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<CustomOverviewCell>(nibName: "CustomOverviewCell")
    }
    
    
    var currentContentOffset: CGPoint {
        get { return CGPoint(x: 0, y: 0) }
    }
    
    
}
