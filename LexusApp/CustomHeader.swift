//
//  CustomHeader.swift
//  LexusApp
//
//  Created by Nguyen Quoc Vuong on 6/30/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit

class CustomHeader: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    static let height: CGFloat = 80
    
    @IBOutlet weak var tongQuanView: UIView!

    @IBOutlet weak var thietKeView: UIView!
    
    
    @IBOutlet weak var vanHanhView: UIView!
    
    @IBOutlet weak var anToanView: UIView!
    
    @IBOutlet weak var thongSoView: UIView!
    
    @IBOutlet weak var thuVienView: UIView!
    
    
    @IBOutlet weak var underlineView: UIView!
    
    
    enum LabelName: Int {
        case TongQuan
        case ThietKe
        case VanHanh
        case AnToan
        case ThongSo
        case ThuVien
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CustomHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tongQuanView.addGestureRecognizer(createTap())
        thietKeView.addGestureRecognizer(createTap())
        vanHanhView.addGestureRecognizer(createTap())
        anToanView.addGestureRecognizer(createTap())
        thongSoView.addGestureRecognizer(createTap())
        thuVienView.addGestureRecognizer(createTap())
    }
    
    func createTap() -> UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(didTapOnLabel))
    }
    
    func didTapOnLabel(sender:UITapGestureRecognizer) {

        if let view = sender.view  {
            let lblName = LabelName(rawValue: view.tag)!
            print(lblName.rawValue)
//            switch lblName {
//            case .TongQuan:
//                
//            case .ThietKe:
//            case .VanHanh:
//            case .AnToan:
//            case .ThongSo:
//            case .ThuVien:
//            }
        }
    }

}
