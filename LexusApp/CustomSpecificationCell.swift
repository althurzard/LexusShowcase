//
//  CustomSpecificationCell.swift
//  LexusApp
//
//  Created by Nguyen Quoc Vuong on 7/1/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit
import Eureka

class CustomSpecificationCell: Cell<Bool>, CellType {

    var dataSource: [String] = ["ĐỘNG CƠ","VẬN HÀNH","KHUNG GẦM","KÍCH THƯỚC","BÁNH VÀ LỐP XE","TIỆN NGHI","THIẾT BỊ TIÊU CHUẨN","HỆ THỐNG GIẢI TRÍ","AN TOÀN","CÁC TÍNH NĂNG KHÁC"]
    
    @IBOutlet weak var rightView: AccordionView!
    @IBOutlet weak var leftView: AccordionView!
    public override func setup() {
        super.setup()
        setupLeftView()
        setupRightView()
        
        
        
    }
    
    func setupLeftView() {
        // Left
        let item1 = Parent(state: .collapsed, childs: ["SubItem 1", "SubItem 2", "SubItem 3"], title: "VẬN HÀNH VÀ HỆ DẪN ĐỘNG")
        let item2 = Parent(state: .collapsed, childs: ["SubItem 1", "SubItem 2"], title: "KHUNG GẦM")
        let item3 = Parent(state: .collapsed, childs: ["SubItem 1", "SubItem 2", "SubItem 3"], title: "KÍCH THƯỚC")
        let item4 = Parent(state: .collapsed, childs: ["SubItem 1", "SubItem 2"], title: "VÀNH VÀ LỐP")
        
        
        leftView.tableView.register(UINib(nibName: "ExpandableCell", bundle: nil), forCellReuseIdentifier: leftView.parentCellIdentifier)
        leftView.tableView.register(UINib(nibName: "DetailSpecificationCell", bundle: nil), forCellReuseIdentifier: leftView.childCellIdentifier)
        
        
        leftView.sectionTitle = "THÔNG SỐ KỸ THUẬT"
        
        leftView.dataSource = [item1, item2, item3, item4]
        leftView.numberOfCellsExpanded = .one
        leftView.total = 4
        
    }
    
    func setupRightView() {
        let item1 = Parent(state: .collapsed, childs: ["SubItem 1", "SubItem 2", "SubItem 3"], title: "AN TOÀN VÀ NHANH")
        let item2 = Parent(state: .collapsed, childs: ["SubItem 1", "SubItem 2"], title: "NGOẠI THẤT")
        let item3 = Parent(state: .collapsed, childs: ["SubItem 1", "SubItem 2", "SubItem 3"], title: "NỘI THẤT")
        let item4 = Parent(state: .collapsed, childs: ["SubItem 1", "SubItem 2"], title: "GHẾ")
        let item5 = Parent(state: .collapsed, childs: ["SubItem 1", "SubItem 2"], title: "HỆ THỐNG ĐIỀU HOÀ")
        let item6 = Parent(state: .collapsed, childs: ["SubItem 1", "SubItem 2"], title: "HỆ THỐNG GIẢI TRÍ")
        
        rightView.tableView.register(UINib(nibName: "ExpandableCell", bundle: nil), forCellReuseIdentifier: leftView.parentCellIdentifier)
        rightView.tableView.register(UINib(nibName: "DetailSpecificationCell", bundle: nil), forCellReuseIdentifier: leftView.childCellIdentifier)
        
        rightView.sectionTitle = "CÔNG NGHỆ ỨNG DỤNG TRÊN XE"
        rightView.dataSource = [item1, item2, item3, item4, item5, item6]
        rightView.numberOfCellsExpanded = .one
        rightView.total = 6
    }
    
    
    public override func update() {
        super.update()
        selectionStyle = .none
        
    }
    
}



final class CustomSpecificationRow: Row<CustomSpecificationCell>, RowType {
    
    required public init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<CustomSpecificationCell>(nibName: "CustomSpecificationCell")
        
    }
    
}
