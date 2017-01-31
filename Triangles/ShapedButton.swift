//
//  ShapedButton.swift
//  Triangles
//
//  Created by Manuel Meyer on 31.01.17.
//  Copyright © 2017 Manuel Meyer. All rights reserved.
//

import UIKit

class ShapedButton: UIButton {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return  shape.cgPath.contains(point)
    }
}
