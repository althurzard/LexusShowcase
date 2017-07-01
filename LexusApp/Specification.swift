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
    static let cellHeight: CGFloat = 50.0
    
    init(title: String?, description: String?) {
        self.title = title
        self.description = description
    }
}
