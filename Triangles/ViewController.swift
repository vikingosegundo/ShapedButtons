//
//  ViewController.swift
//  Triangles
//
//  Created by Manuel Meyer on 31.01.17.
//  Copyright © 2017 Manuel Meyer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var topButton: PathShapedButton!
    @IBOutlet weak var rightButton: PathShapedButton!
    @IBOutlet weak var bottomButton: PathShapedButton!
    @IBOutlet weak var leftButton: PathShapedButton!
    
    @IBOutlet weak var polygonButton: PathShapedButton!
    @IBOutlet weak var circleButton: PathShapedButton!
    @IBOutlet weak var okButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttons = [topButton, rightButton, bottomButton, leftButton].flatMap { $0 }
        
        for (button, idx) in zip(buttons, 0..<TriangleFacing.allValues.count) {
            let faceInt = UInt(idx % buttons.count)
            if let facing = TriangleFacing(rawValue: faceInt) {
                button.configure(as: .triangle(facing))
            }
        }
        circleButton.configure(as: .circle)
        view.sendSubview(toBack: circleButton)
        okButton.configure(as: .triangle(.up))
        
        polygonButton.configure(as: .polygon([
            CGPoint(x: 0.50, y: 0.00),
            CGPoint(x: 1.00, y: 0.50),
            CGPoint(x: 0.75, y: 1.00),
            CGPoint(x: 0.25, y: 1.00),
            CGPoint(x: 0.00, y: 0.50)
        ])
        )
    }
}
