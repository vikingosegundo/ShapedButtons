//
//  ViewController.swift
//  Triangles
//
//  Created by Manuel Meyer on 31.01.17.
//  Copyright © 2017 Manuel Meyer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var topButton: ShapedButton!
    @IBOutlet weak var rightButton: ShapedButton!
    @IBOutlet weak var bottomButton: ShapedButton!
    @IBOutlet weak var leftButton: ShapedButton!
    
    @IBOutlet weak var circleButton: ShapedButton!
    @IBOutlet weak var okButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        for (idx, button) in ([topButton, rightButton, bottomButton, leftButton].flatMap{ $0 }).enumerated() {
            
            let faceInt = UInt(idx % 4)
            if let facing = TriangleFacing(rawValue: faceInt) {
                button.configure(as: .triangle(facing))
            }
        }
        
        circleButton.configure(as: .circle)
        view.sendSubview(toBack: circleButton)
        
        okButton.configure(as: .triangle(.up))
    }
}
