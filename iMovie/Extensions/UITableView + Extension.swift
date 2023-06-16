//
//  UITableView + Extension.swift
//  iMovie
//
//  Created by Irisandromeda on 16.06.2023.
//

import UIKit

extension UITableView {
    var cellSpacing: CGFloat {
        get { return self.rowHeight }
        set { self.rowHeight = newValue }
    }
}
