//
//  CustomLibraryView.swift
//  LexusApp
//
//  Created by MacOS on 7/17/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit
import Spruce
import Spring

protocol CustomLibraryViewProtocol {
    func didTapImage(withView View: CustomLibraryView,withIndex index: Int )
}

class CustomLibraryView: UIView {

    fileprivate lazy var animateToBottom: [StockAnimation] = [.fadeIn]
    fileprivate lazy var animateToTop: [StockAnimation] = [.fadeIn]
    fileprivate lazy var animateToLeft: [StockAnimation] = [.fadeIn]
    fileprivate lazy var animateToRight: [StockAnimation] = [.fadeIn]
    
    @IBOutlet weak var topRightView: UIView?
    @IBOutlet weak var topLeftView: UIView?
    
    @IBOutlet weak var topMidUpView: UIView?
    @IBOutlet weak var topMidLeftView: UIView?
    @IBOutlet weak var topMidRightView: UIView?
    
    @IBOutlet weak var bottomLeftView: UIView?
    
    @IBOutlet weak var bottomRightView: UIView?
    
    @IBOutlet weak var bottomRRightView: UIView?
    @IBOutlet weak var bottomRLeftView: UIView?
    
    var duration = 1.5
    
    var delegate: CustomLibraryViewProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topLeftView?.addGestureRecognizer(createGesture())
        topRightView?.addGestureRecognizer(createGesture())
        topMidUpView?.addGestureRecognizer(createGesture())
        topMidLeftView?.addGestureRecognizer(createGesture())
        topMidRightView?.addGestureRecognizer(createGesture())
        bottomRightView?.addGestureRecognizer(createGesture())
        bottomRRightView?.addGestureRecognizer(createGesture())
        bottomRLeftView?.addGestureRecognizer(createGesture())
    }
    
    func createGesture() -> UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(didTapImage))
    }
    
    func prepareAnimation() {
        topRightView?.spruce.prepare(with: animateToLeft)
        topLeftView?.spruce.prepare(with: animateToRight)
        topMidUpView?.spruce.prepare(with: animateToBottom)
        topMidLeftView?.spruce.prepare(with: animateToRight)
        topMidRightView?.spruce.prepare(with: animateToLeft)
        bottomLeftView?.spruce.prepare(with: animateToRight)
        bottomRightView?.spruce.prepare(with: animateToTop)
        bottomRLeftView?.spruce.prepare(with: animateToRight)
        bottomRRightView?.spruce.prepare(with: animateToLeft)
    }
    
    func startAnimation() {
        delay(delay: 0.1){
            self.topLeftView?.spruce.animate(self.animateToRight, duration: self.duration)
            self.bottomRLeftView?.spruce.animate(self.animateToRight, duration: self.duration)
        }
        
        
        
        delay(delay: 0.25) {
            let duration = self.duration - 0.5
            self.topRightView?.spruce.animate(self.animateToLeft, duration: duration)
            
            self.topMidUpView?.spruce.animate(self.animateToBottom, duration: duration)
            self.topMidLeftView?.spruce.animate(self.animateToRight, duration: duration)
            self.topMidRightView?.spruce.animate(self.animateToLeft, duration: duration)
            self.bottomLeftView?.spruce.animate(self.animateToRight, duration: duration)
            self.bottomRightView?.spruce.animate(self.animateToTop, duration: duration)
            
            self.bottomRRightView?.spruce.animate(self.animateToLeft, duration: duration)
        }
        
    }
    
    @IBAction func didTapImage(sender: UIGestureRecognizer) {
      delegate?.didTapImage(withView: self, withIndex: sender.view!.tag)
        
    }
    
    class func instanceFromNib() -> CustomLibraryView {
        return UINib(nibName: "CustomLibraryView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CustomLibraryView
    }

}

