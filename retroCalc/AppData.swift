//
//  AppData.swift
//  retroCalc
//
//  Created by Jack Hider on 06/06/2016.
//  Copyright © 2016 Jack Hider. All rights reserved.
//

import Foundation
import AVFoundation

class AppData {
    
    static let instance = AppData()
    
    enum Operation: String{
        case Add = "+"
        case Subtract = "-"
        case Multiply = "*"
        case Divide = "/"
        case Empty = ""
        case Equals = "="
    }

    var btnSnd: AVAudioPlayer!
    var runNumb = String("")
    var leftValStr = String("")
    var rightValStr = String("")
    var result = String("")
    var curOperation :Operation = Operation.Empty
    
    
    
    private init() {
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let sndUrl = NSURL(fileURLWithPath: path!)
        do {
            try btnSnd = AVAudioPlayer(contentsOfURL: sndUrl)
            btnSnd.prepareToPlay()
        }catch let err as NSError{
            print(err.debugDescription)
        }
     }
    
    
    func processOperation(op: Operation) -> String{
        
        if curOperation != Operation.Empty{
            
            if runNumb != ""{
                rightValStr = runNumb
                runNumb = ""
                playSound()
                
                if op == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }else if op == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }else if op == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }else if op == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }
                
                leftValStr = result
                return result
            }
            curOperation = op
        }else{
            
            leftValStr = runNumb
            runNumb = ""
            playSound()
            curOperation = op
            
        }
        
        return result
    }

    
    func playSound(){
        btnSnd.play()
    }
    
}