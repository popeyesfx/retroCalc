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
    
    
    @IBOutlet private weak var displayLbl: UILabel!
    private var userIsInTheMiddleOfTyping = false
    
    private var displayValue: Double {
        get {
            return Double(displayLbl.text!)!
        }
        set {
            displayLbl.text = String(newValue)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction private func numberPressed(btn : UIButton){
        let digit = btn.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = displayLbl.text!
            displayLbl.text = textCurrentlyInDisplay + digit
        }else {
            displayLbl.text = digit
        }
        userIsInTheMiddleOfTyping = true
        AppData.instance.playSound()
    }
    
    @IBAction private func periodPressed(sender: UIButton) {
       var displaytext : String = String(displayValue)
        displaytext = displaytext.substringWithRange(Range<String.Index>(start: displaytext.startIndex, end: displaytext.endIndex.advancedBy(-1)))
        displayLbl.text = displaytext
        
    }
    
    
    @IBAction private func performOperation(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            AppData.instance.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathmaticalSymbol = sender.currentTitle {
            
            AppData.instance.performOperation(mathmaticalSymbol)
            
        }
        displayValue = AppData.instance.res
        
    }
    
    
    @IBAction private func clearDisplay(sender: UIButton) {
        AppData.instance.clearDisplay()
        userIsInTheMiddleOfTyping = false
        displayValue = 0
    }
}

