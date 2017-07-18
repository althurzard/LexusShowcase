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
    
    @IBOutlet weak var colorPickerView: UIView!
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
        
        let collectionView = ColorPickerView.instanceFromNib()
        colorPickerView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: colorPickerView.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: colorPickerView.rightAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: colorPickerView.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: colorPickerView.bottomAnchor, constant: 0).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(didTapSelectColorCell), name: Notification.Name.init(rawValue: ColorPickerView.notificationName), object: nil)
    }
    
    public override func update() {
        super.update()
        backgroundColor = .white
        selectionStyle = .none
    }
    
    
    
    func didTapSelectColorCell(notification: Notification) {
    
        if let cell = notification.object as? ColorPickerViewCell {
            switch cell.indexPath.item {
            case 0:
                switchModel(colorModel: ColorModel.SonicTitanium(cell.colorName!))
            case 1:
                switchModel(colorModel: ColorModel.SonicQuartz(cell.colorName!))
            case 2:
                switchModel(colorModel: ColorModel.PlatinumSilverMetallic(cell.colorName!))
            case 3:
                switchModel(colorModel: ColorModel.MecuryGrayMC(cell.colorName!))
            case 4:
                switchModel(colorModel: ColorModel.Black(cell.colorName!))
            case 5:
                switchModel(colorModel: ColorModel.GraphiteBlack(cell.colorName!))
            case 6:
                switchModel(colorModel: ColorModel.RadiantRedCl(cell.colorName!))
            default:
                print("Model is unavailable")
            }
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
