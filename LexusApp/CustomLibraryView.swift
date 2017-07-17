//
//  CustomLibraryView.swift
//  LexusApp
//
//  Created by MacOS on 7/17/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit
import Spruce

class CustomLibraryView: UIView {

    fileprivate lazy var animateToBottom: [StockAnimation] = [.fadeIn,.slide(.down, .moderately)]
    fileprivate lazy var animateToTop: [StockAnimation] = [.fadeIn,.slide(.up, .moderately)]
    fileprivate lazy var animateToLeft: [StockAnimation] = [.fadeIn,.slide(.left, .moderately)]
    fileprivate lazy var animateToRight: [StockAnimation] = [.fadeIn,.slide(.right, .moderately)]
    
    @IBOutlet weak var topRightView: UIView!
    @IBOutlet weak var topLeftView: UIView!
    
    @IBOutlet weak var topMidUpView: UIView!
    @IBOutlet weak var topMidLeftView: UIView!
    @IBOutlet weak var topMidRightView: UIView!
    
    @IBOutlet weak var bottomLeftView: UIView!
    
    @IBOutlet weak var bottomRightView: UIView!
    
    @IBOutlet weak var bottomRRightView: UIView!
    @IBOutlet weak var bottomRLeftView: UIView!
    
    var duration = 1.5
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepareAnimation() {
        topRightView.spruce.prepare(with: animateToLeft)
        topLeftView.spruce.prepare(with: animateToRight)
        topMidUpView.spruce.prepare(with: animateToBottom)
        topMidLeftView.spruce.prepare(with: animateToRight)
        topMidRightView.spruce.prepare(with: animateToLeft)
        bottomLeftView.spruce.prepare(with: animateToRight)
        bottomRightView.spruce.prepare(with: animateToTop)
        bottomRLeftView.spruce.prepare(with: animateToRight)
        bottomRRightView.spruce.prepare(with: animateToLeft)
    }
    
    func startAnimation() {
        topRightView.spruce.animate(animateToLeft, duration: duration)
        topLeftView.spruce.animate(animateToRight, duration: duration)
        topMidUpView.spruce.animate(animateToBottom, duration: duration)
        topMidLeftView.spruce.animate(animateToRight, duration: duration)
        topMidRightView.spruce.animate(animateToLeft, duration: duration)
        bottomLeftView.spruce.animate(animateToRight, duration: duration)
        bottomRightView.spruce.animate(animateToTop, duration: duration)
        bottomRLeftView.spruce.animate(animateToRight, duration: duration)
        bottomRRightView.spruce.animate(animateToLeft, duration: duration)
    }
    
    class func instanceFromNib() -> CustomLibraryView {
        return UINib(nibName: "CustomLibraryView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomLibraryView
    }

}

