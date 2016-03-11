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
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let sndUrl = NSURL(fileURLWithPath: path!)
        do {
            try btnSnd = AVAudioPlayer(contentsOfURL: sndUrl)
            btnSnd.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberPressed(btn : UIButton){
        playSound()
    }
    
    
    func playSound(){
        btnSnd.play()
    }
}

