//
//  RoundedView.swift
//  mobilab
//
//  Created by Arilson do Carmo on 4/14/16.
//  Copyright © 2016 Arilson do Carmo. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedView: UIView {
    @IBInspectable var radius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = radius
            layer.masksToBounds = radius > 0
        }
    }
}
