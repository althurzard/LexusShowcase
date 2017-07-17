//
//  CustomSafetyCell.swift
//  LexusApp
//
//  Created by MacOS on 7/17/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit
import Eureka
import Spruce
class CustomSafetyCell: CustomBodyCell  {

    public override func setup() {
        super.setup()
        
    }
    
    public override func update() {
        super.update()
        
    }

}

final class CustomSafetyRow: Row<CustomSafetyCell>, RowType {
    
    required public init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<CustomSafetyCell>(nibName: "CustomSafetyCell")
        
    }
    
}
