//
//  Specification.swift
//  LexusApp
//
//  Created by Nguyen Quoc Vuong on 7/1/17.
//  Copyright © 2017 Vuong Nguyen. All rights reserved.
//

import UIKit

open class Specification {
    var title: String?
    var description: String?
    var cellHeight: CGFloat!
    var font: String?
    
    init(title: String?, description: String? = nil, cellHeight: CGFloat = 40.0, font: String? = nil) {
        self.title = title
        self.description = description
        self.cellHeight = cellHeight
        self.font = font
    }
}
