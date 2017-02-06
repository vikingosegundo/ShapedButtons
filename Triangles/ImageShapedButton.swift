    //
//  ImageShapedButton.swift
//  Triangles
//
//  Created by Manuel Meyer on 01.02.17.
//  Copyright © 2017 Manuel Meyer. All rights reserved.
//

import UIKit

class ImageShapedButton: UIButton {

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if let image = self.backgroundImage(for: self.state) {
            
            guard self.bounds.contains(point) else { return false }

            
            let iSize = image.size
            let bSize = self.bounds.size
            var point = point
            point.x *= (bSize.width != 0) ? (iSize.width / bSize.width) : 1
            point.y *= (bSize.height != 0) ? (iSize.height / bSize.height) : 1
            
            
            let colorAtPoint = try! image.color(at: point)

            var alpha = CGFloat(0)
            
            colorAtPoint.getRed(nil, green: nil, blue: nil, alpha: &alpha)
            
            return alpha > 0.5
        }
        return super.point(inside: point, with: event)
    }

    
    
}
