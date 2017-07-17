//
//  CustomSpecificationCell.swift
//  LexusApp
//
//  Created by Nguyen Quoc Vuong on 7/1/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit
import Eureka
import YNExpandableCell

class CustomSpecificationCell: Cell<Bool>, CellType {

    var accordianTableView: CustomAccordianView!
    
    public override func setup() {
        super.setup()
        
        accordianTableView = CustomAccordianView.instanceFromNib()
        
        self.addSubview(accordianTableView)
        
        accordianTableView.translatesAutoresizingMaskIntoConstraints = false
        accordianTableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        accordianTableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        accordianTableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        accordianTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
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
