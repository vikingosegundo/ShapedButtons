//
//  ViewController.swift
//  Triangles
//
//  Created by Manuel Meyer on 31.01.17.
//  Copyright © 2017 Manuel Meyer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leftButton: ShapedButton!
    @IBOutlet weak var button: ShapedButton!
    @IBOutlet weak var rightButton: ShapedButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for (idx, b) in [leftButton, button, rightButton].enumerated() {
            if let b = b {
                if idx % 2 == 0 {
                    b.configureDownFacingTriangle()
                } else {
                    b.configureUpFacingTriangle()
                }
            }
        }
    }
}
