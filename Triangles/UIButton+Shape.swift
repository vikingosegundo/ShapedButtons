//
//  UIButton+Shape.swift
//  Triangles
//
//  Created by Manuel Meyer on 31.01.17.
//  Copyright © 2017 Manuel Meyer. All rights reserved.
//

import UIKit

enum TriangleFacing: UInt, EnumCollection {
    case up
    case right
    case down
    case left
}

enum ButtonShape {
    case triangle(TriangleFacing)
    case polygon([CGPoint])
    case circle
}

extension UIButton {
    var shape: UIBezierPath {
        
        set {
            let l = CAShapeLayer()
            l.path = newValue.cgPath
            self.layer.mask = l
        }
        get {
            if let l = self.layer.mask as? CAShapeLayer,
               let p = l.path {
                return UIBezierPath(cgPath: p)
            }
            return UIBezierPath()
        }
    }
    
    func configure(as shape: ButtonShape) {
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
            
        case .polygon(let points):
            configurePolygon(normalizedPoints: points)
        }
    }
}

fileprivate
extension UIButton {
    
    func denormalize(point:CGPoint) -> CGPoint {
        return CGPoint(x: point.x * self.bounds.size.width, y: point.y * self.bounds.size.height)
    }
    
    func configurePolygon(normalizedPoints points: [CGPoint]) {
        var points = points
        guard
            points.count > 2
            else {
            fatalError("a polygon needs more than 2 points")
        }
        
        let polygonBezier = UIBezierPath()
        polygonBezier.move(to: denormalize(point: points.removeFirst()))
        for point in points {
            polygonBezier.addLine(to: denormalize(point: point))
        }
        polygonBezier.close()
        self.shape = polygonBezier
    }
    
    func configureUpFacingTriangle() {
        configurePolygon(normalizedPoints: [
            CGPoint(x: 0.5, y: 0.0),
            CGPoint(x: 0.0, y: 1.0),
            CGPoint(x: 1.0, y: 1.0)
        ])
        let pointSize = self.titleLabel?.font.pointSize ?? 0
        self.titleEdgeInsets.top = self.titleEdgeInsets.top + (self.frame.size.height - pointSize - 7)
    }
    
    func configureLeftFacingTriangle() {
        configurePolygon(normalizedPoints: [
            CGPoint(x: 0.0, y: 0.5),
            CGPoint(x: 1.0, y: 0.0),
            CGPoint(x: 1.0, y: 1.0)
        ])
        self.titleEdgeInsets.right = -21
    }
    
    
    func configureDownFacingTriangle() {
        configurePolygon(normalizedPoints: [
            CGPoint.zero,
            CGPoint(x: 1.0, y: 0.0),
            CGPoint(x: 0.5, y: 1.0)
        ])
        let pointSize = self.titleLabel?.font.pointSize ?? 0
        self.titleEdgeInsets.top = self.titleEdgeInsets.bottom - (self.frame.size.height - pointSize - 7)
    }
    
    func configureRightFacingTriangle() {
        configurePolygon(normalizedPoints: [
            CGPoint.zero,
            CGPoint(x: 1.0, y: 0.5),
            CGPoint(x: 0.0, y: 1.0)
        ])
        self.titleEdgeInsets.left = -21
    }
    
    
    func configureCircle() {
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
