//
//  CustomColorPickerCell.swift
//  LexusApp
//
//  Created by Nguyen Quoc Vuong on 6/30/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit
import Eureka
import Spruce
import Spring
class CustomColorPickerCell: Cell<Bool>, CellType {

    @IBOutlet weak var carImageView: DesignableImageView!
    
    @IBOutlet weak var lblColorModel: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblCarModel: UILabel!
    

    fileprivate var isAnimating = true
    
    enum ColorModel {
        case SonicTitanium(String)
        case SonicQuartz(String)
        case PlatinumSilverMetallic(String)
        case MecuryGrayMC(String)
        case Black(String)
        case GraphiteBlack(String)
        case RadiantRedCl(String)
    }
    
    fileprivate lazy var animation: [StockAnimation] = [.fadeIn,.slide(.left, .moderately)]
    fileprivate lazy var animateToBottom: [StockAnimation] = [.fadeIn,.slide(.down, .moderately)]
    fileprivate lazy var animateToTop: [StockAnimation] = [.fadeIn,.slide(.up, .moderately)]
    
    public override func setup() {
        super.setup()
        self.prepareAnimation()
    }
    
    public override func update() {
        super.update()
        backgroundColor = .white
        selectionStyle = .none
    }
    
    @IBAction func didTapSelectColorButton(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            switchModel(colorModel: ColorModel.SonicTitanium(sender.currentTitle!))
        case 1:
            switchModel(colorModel: ColorModel.SonicQuartz(sender.currentTitle!))
        case 2:
            switchModel(colorModel: ColorModel.PlatinumSilverMetallic(sender.currentTitle!))
        case 3:
            switchModel(colorModel: ColorModel.MecuryGrayMC(sender.currentTitle!))
        case 4:
            switchModel(colorModel: ColorModel.Black(sender.currentTitle!))
        case 5:
            switchModel(colorModel: ColorModel.GraphiteBlack(sender.currentTitle!))
        case 6:
            switchModel(colorModel: ColorModel.RadiantRedCl(sender.currentTitle!))
        default:
            print("Model is unavailable")
        }
    
    }
    
    func switchModel(colorModel: ColorModel) {
        switch colorModel {
        case .Black(let color):
            self.carImageView.image = UIImage(named: "Den-Black-(212)")
            self.lblColorModel.text = color
        case .GraphiteBlack(let color):
            self.carImageView.image = UIImage(named: "Den-Graaphite-Black-(223)")
            self.lblColorModel.text = color
        case .MecuryGrayMC(let color) :
            self.carImageView.image = UIImage(named: "Xam-Mecury-Gray-MC.-(1H9)")
            self.lblColorModel.text = color
        case .PlatinumSilverMetallic(let color):
            self.carImageView.image = UIImage(named: "Bac-Platinum-Silver-ME.-(1J4)")
            self.lblColorModel.text = color
        case .RadiantRedCl(let color):
            self.carImageView.image = UIImage(named: "Do--Radiant-Red-CL.-(3T5)")
            self.lblColorModel.text = color
        case .SonicQuartz(let color):
            self.carImageView.image = UIImage(named: "Trang-Sonic-Quartz-(085)")
            self.lblColorModel.text = color
        case .SonicTitanium(let color):
            self.carImageView.image = UIImage(named: "Ghi-Sonic-Titanium-(1J7)")
            self.lblColorModel.text = color
        }
        
    }
    @IBOutlet weak var colorStackView: UIStackView!
    
    @IBOutlet weak var bottomLeftView: UIView!
    @IBOutlet weak var topLeftView: UIView!
    
    func startAnimation() {
        if !isAnimating {
            colorStackView.spruce.animate(animation,duration: 1.5)
            bottomLeftView.spruce.animate(animateToTop, duration: 1.5)
            topLeftView.spruce.animate(animateToBottom, duration: 1.5)
            isAnimating = true
        }
        
    }
    
    func prepareAnimation() {
        if isAnimating {
            colorStackView.spruce.prepare(with: animation)
            bottomLeftView.spruce.prepare(with: animateToTop)
            topLeftView.spruce.prepare(with: animateToBottom)
            isAnimating = false
        }
    }
    
    
}

final class CustomColorPickerRow: Row<CustomColorPickerCell>, RowType {
    
    required public init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<CustomColorPickerCell>(nibName: "CustomColorPickerCell")
        
    }
    
    var currentContentOffset: CGPoint {
        get { return CGPoint(x: 0, y: self.cell!.height!()) }
    }
    
}
