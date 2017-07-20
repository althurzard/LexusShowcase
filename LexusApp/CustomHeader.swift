//
//  CustomHeader.swift
//  LexusApp
//
//  Created by Nguyen Quoc Vuong on 6/30/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit

protocol CustomHeaderProtocol {
    func didTapCategory(name: CustomHeader.LabelName)
}

class CustomHeader: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var logoHeaderButton: UIButton!
    
    static let height: CGFloat = 70
    
    @IBOutlet weak var tongQuanStackView: UIStackView!
    
    @IBOutlet weak var thietKeStackView: UIStackView!
    
    @IBOutlet weak var vanHanhStackView: UIStackView!
    
    @IBOutlet weak var anToanStackView: UIStackView!
    
    @IBOutlet weak var thongSoStackView: UIStackView!
    
    @IBOutlet weak var thuVienStackView: UIStackView!
    
    @IBOutlet weak var containerStackView: UIStackView!
    
    var delegate: CustomHeaderProtocol?
    public enum LabelName: Int {
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
        tongQuanStackView.addGestureRecognizer(createTap())
        thietKeStackView.addGestureRecognizer(createTap())
        vanHanhStackView.addGestureRecognizer(createTap())
        anToanStackView.addGestureRecognizer(createTap())
        thongSoStackView.addGestureRecognizer(createTap())
        thuVienStackView.addGestureRecognizer(createTap())
    }
    
    func createTap() -> UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(didTapOnLabel))
    }
    
    func didTapOnLabel(sender:UITapGestureRecognizer) {

        if let view = sender.view  {
            
            let lblName = LabelName(rawValue: view.tag)!
            delegate?.didTapCategory(name: lblName)
        }
    }
    
    func switchState(category: LabelName) {
        hideUnderline()
        
        switch category {
        case .TongQuan:
            showUnderline(view: tongQuanStackView)
        case .ThietKe:
            showUnderline(view: thietKeStackView)
        case .VanHanh:
            showUnderline(view: vanHanhStackView)
        case .AnToan:
            showUnderline(view: anToanStackView)
        case .ThongSo:
            showUnderline(view: thongSoStackView)
        case .ThuVien:
            showUnderline(view: thuVienStackView)
        }
    }
    
    
    func showUnderline(view: UIView) {
        for subView in  view.subviews {
            if subView.isKind(of: UIView.self) {
                    subView.alpha = 1.0
            }
        }
    }
    
    func hideUnderline() {
        for stackView in containerStackView.subviews {
            for view in stackView.subviews {
                if view.isKind(of: UILabel.self) { continue }
                if view.isKind(of: UIView.self) {
                    view.alpha = 0.0
                }
            }
        }
    }

}
