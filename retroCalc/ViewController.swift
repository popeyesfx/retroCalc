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
    
    
    @IBOutlet weak var displayLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func numberPressed(btn : UIButton){
        AppData.instance.playSound()
        AppData.instance.runNumb += "\(btn.tag)"
        updateDisplay(AppData.instance.runNumb)
    }
    
    @IBAction func decimalPoint(sender: UIButton) {
        AppData.instance.playSound()
        AppData.instance.runNumb += "."
        updateDisplay(AppData.instance.runNumb)
    }
    @IBAction func addPressed(sender: UIButton) {
        if AppData.instance.curOperation != AppData.Operation.Empty {
            updateDisplay(AppData.instance.processOperation(AppData.Operation.Add))
        }else {
            AppData.instance.processOperation(AppData.Operation.Add)
        }
    }
    
    @IBAction func subtractPressed(sender: UIButton) {
        if AppData.instance.curOperation != AppData.Operation.Empty {
            updateDisplay(AppData.instance.processOperation(AppData.Operation.Subtract))
        }else {
            AppData.instance.processOperation(AppData.Operation.Subtract)
        }
    }
    
    @IBAction func multiplyPressed(sender: UIButton) {
        if AppData.instance.curOperation != AppData.Operation.Empty  {
            updateDisplay(AppData.instance.processOperation(AppData.Operation.Multiply))
        }else {
            AppData.instance.processOperation(AppData.Operation.Multiply)
        }
        
    }
    
    @IBAction func dividePressed(sender: UIButton) {
        if AppData.instance.curOperation != AppData.Operation.Empty {
            updateDisplay( AppData.instance.processOperation(AppData.Operation.Divide))
        }else {
            AppData.instance.processOperation(AppData.Operation.Divide)
        }
    }
    
    @IBAction func clearDisplay(sender: UIButton) {
        AppData.instance.curOperation = AppData.Operation.Empty
        AppData.instance.leftValStr = ""
        AppData.instance.rightValStr = ""
        AppData.instance.result = ""
        updateDisplay("0")
    }
    
    @IBAction func equalsPressed(sender: UIButton) {
        if AppData.instance.curOperation != AppData.Operation.Empty{
            if AppData.instance.runNumb != ""{
                AppData.instance.rightValStr = AppData.instance.runNumb
                AppData.instance.runNumb = ""
                AppData.instance.playSound()
                
                if AppData.instance.curOperation == AppData.Operation.Add{
                    AppData.instance.result = "\(Double(AppData.instance.leftValStr)! + Double(AppData.instance.rightValStr)!)"
                }else if AppData.instance.curOperation == AppData.Operation.Multiply{
                    AppData.instance.result = "\(Double(AppData.instance.leftValStr)! * Double(AppData.instance.rightValStr)!)"
                }else if AppData.instance.curOperation == AppData.Operation.Subtract{
                    AppData.instance.result = "\(Double(AppData.instance.leftValStr)! - Double(AppData.instance.rightValStr)!)"
                }else if AppData.instance.curOperation == AppData.Operation.Divide{
                    AppData.instance.result = "\(Double(AppData.instance.leftValStr)! / Double(AppData.instance.rightValStr)!)"
                }
                
                AppData.instance.leftValStr = AppData.instance.result
                updateDisplay(AppData.instance.result)
            }
            
        }
    }
    
    func updateDisplay(num: String){
        displayLbl.text = num
    }
    
}

