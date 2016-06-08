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
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    
    var operations: Dictionary<String,Operation> = [
        
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" :  Operation.UnaryOperation(sqrt),
        "cos" :Operation.UnaryOperation(cos),
        "x" : Operation.BinaryOperation({ $0 * $1  }),
        "/" : Operation.BinaryOperation({ $0 / $1  }),
        "+" : Operation.BinaryOperation({ $0 + $1  }),
        "-" : Operation.BinaryOperation({ $0 - $1  }),
        "=" : Operation.Equals
        
    ]
    
    
    private var accumulator = 0.0
    private var btnSnd: AVAudioPlayer!
    private var pending: PendingBinaryOperationInfo?
    
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
    
    struct PendingBinaryOperationInfo {
        var binaryFunction:(Double, Double) -> Double
        var firstOperand: Double
    }
    
    var res: Double {
        get {
            
            return accumulator
        }
    }
    
    func setOperand(operand: Double) {
        
        accumulator = operand
        
    }
    
    func performOperation(symbol: String) {
        
        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let opp):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: opp, firstOperand: accumulator)
            case.Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    func clearDisplay() {
        pending = nil
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
        
    }
    
    func playSound(){
        btnSnd.play()
    }
    
    
}