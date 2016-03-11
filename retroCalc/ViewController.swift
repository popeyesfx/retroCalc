//
//  ViewController.swift
//  retroCalc
//
//  Created by Jack Hider on 11/03/2016.
//  Copyright © 2016 Jack Hider. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operators: String{
        case Add = "+"
        case Subtract = "-"
        case Multiply = "*"
        case Divide = "/"
        case Empty = ""
        case Equals = "="
    }
    
    var btnSnd: AVAudioPlayer!
    
    
    @IBOutlet weak var displayLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

