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
        runNumb += "\(btn.tag)"
        updateDisplay(runNumb)
    }
    
    @IBAction func decimalPoint(sender: UIButton) {
        playSound()
        runNumb += "."
        updateDisplay(runNumb)
    }
    @IBAction func addPressed(sender: UIButton) {
        processOperation(Operation.Add)
    }
    
    @IBAction func subtractPressed(sender: UIButton) {
        processOperation(Operation.Subtract)
    }
   
    @IBAction func multiplyPressed(sender: UIButton) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func dividePressed(sender: UIButton) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func clearDisplay(sender: UIButton) {
        curOperation = Operation.Empty
        leftValStr = ""
        rightValStr = ""
        result = ""
        updateDisplay("0")
    }
    
    @IBAction func equalsPressed(sender: UIButton) {
        if curOperation != Operation.Empty{
            if runNumb != ""{
                rightValStr = runNumb
                runNumb = ""
                playSound()
                
                if curOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }else if curOperation == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }else if curOperation == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }else if curOperation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }
                
                leftValStr = result
                updateDisplay(result)
            }

        }
    }

    func processOperation(op: Operation){
        
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
            updateDisplay(result)
            }
            curOperation = op
        }else{
            
            leftValStr = runNumb
            runNumb = ""
            playSound()
            curOperation = op

        }
        
        
    }
    
    
    func updateDisplay(num: String){
        displayLbl.text = num
    }
    
    func playSound(){
        btnSnd.play()
    }
}

