//
//  ShapedButton.swift
//  Triangles
//
//  Created by Manuel Meyer on 31.01.17.
//  Copyright © 2017 Manuel Meyer. All rights reserved.
//

import UIKit

class ShapedButton: UIButton {
    
    var shape: UIBezierPath = UIBezierPath() {
        didSet{
            let l = CAShapeLayer()
            l.path = shape.cgPath
            self.layer.mask = l
        }
    }
    

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return  shape.cgPath.contains(point)
    }
    
    
    func configureUpFacingTriangle() {
        let triangleBezier = UIBezierPath()
        triangleBezier.move(to: CGPoint(x: self.frame.size.width / 2, y:0))
        triangleBezier.addLine(to: CGPoint(x: 0, y: self.frame.size.height))
        triangleBezier.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        triangleBezier.close()
        self.shape = triangleBezier
        
        let pointSize = self.titleLabel?.font.pointSize ?? 0
        self.titleEdgeInsets.top = self.titleEdgeInsets.top + (self.frame.size.height - pointSize - 7)
    }
    
    func configureDownFacingTriangle() {
        let triangleBezier = UIBezierPath()
        triangleBezier.move(to: CGPoint.zero)
        triangleBezier.addLine(to: CGPoint(x: self.frame.size.width, y: 0))
        triangleBezier.addLine(to: CGPoint(x:self.frame.size.width/2, y: self.frame.size.height ))
        triangleBezier.close()
        self.shape = triangleBezier

        let pointSize = self.titleLabel?.font.pointSize ?? 0
        self.titleEdgeInsets.top = self.titleEdgeInsets.bottom - (self.frame.size.height - pointSize - 7)
    }
}
