//
//  ShapedButton.swift
//  Triangles
//
//  Created by Manuel Meyer on 31.01.17.
//  Copyright © 2017 Manuel Meyer. All rights reserved.
//

import UIKit

enum TriangleFacing: UInt {
    case up
    case right
    case down
    case left
}

enum ShapedButtonShape {
    case triangle(TriangleFacing)
    case circle
}

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
    
    func configure(as shape: ShapedButtonShape) {
        switch shape {
        case .circle:
            configureCircle()
    
        case .triangle(.up):
            configureUpFacingTriangle()
        case .triangle(.right):
            configureRightFacingTriangle()
        case .triangle(.down):
            configureDownFacingTriangle()
        case .triangle(.left):
            configureLeftFacingTriangle()
        }
    }
    
    private func configureUpFacingTriangle() {
        let triangleBezier = UIBezierPath()
        triangleBezier.move(to: CGPoint(x: self.frame.size.width / 2, y:0))
        triangleBezier.addLine(to: CGPoint(x: 0, y: self.frame.size.height))
        triangleBezier.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        triangleBezier.close()
        self.shape = triangleBezier
        
        let pointSize = self.titleLabel?.font.pointSize ?? 0
        self.titleEdgeInsets.top = self.titleEdgeInsets.top + (self.frame.size.height - pointSize - 7)
    }
    
    private func configureLeftFacingTriangle() {
        let triangleBezier = UIBezierPath()
        triangleBezier.move(to: CGPoint(x: 0, y:self.frame.size.height / 2))
        triangleBezier.addLine(to: CGPoint(x: self.frame.size.width, y: 0))
        triangleBezier.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        triangleBezier.close()
        self.shape = triangleBezier
        
        self.titleEdgeInsets.right = -21
    }
    
    
    private func configureDownFacingTriangle() {
        let triangleBezier = UIBezierPath()
        triangleBezier.move(to: CGPoint.zero)
        triangleBezier.addLine(to: CGPoint(x: self.frame.size.width, y: 0))
        triangleBezier.addLine(to: CGPoint(x:self.frame.size.width/2, y: self.frame.size.height ))
        triangleBezier.close()
        self.shape = triangleBezier

        let pointSize = self.titleLabel?.font.pointSize ?? 0
        self.titleEdgeInsets.top = self.titleEdgeInsets.bottom - (self.frame.size.height - pointSize - 7)
    }
    
    private func configureRightFacingTriangle() {
        let triangleBezier = UIBezierPath()
        triangleBezier.move(to: CGPoint.zero)
        triangleBezier.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height / 2))
        triangleBezier.addLine(to: CGPoint(x: 0, y: self.frame.size.height ))
        triangleBezier.close()
        self.shape = triangleBezier
        self.titleEdgeInsets.left = -21
    }
    
    
    private func configureCircle() {
        let radius =  min(self.bounds.width, self.bounds.height) / 2
        let circleCenter = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        let circleBezier = UIBezierPath(arcCenter: circleCenter,
                                           radius: radius,
                                       startAngle: CGFloat(0),
                                         endAngle: CGFloat(2 * M_PI),
                                        clockwise: true)
        self.shape = circleBezier
    }
}
