//
//  ViewController.swift
//  Calculator
//
//  Created by Zhuo Li on 2/23/15.
//  Copyright (c) 2015 Zhuo Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var inTheMiddleOfTyping = false
    
    @IBAction func appendDigits(sender: UIButton) {
        let digit = sender.currentTitle!
        println("digit= \(digit)");
        
        if inTheMiddleOfTyping {
            display.text = display.text! + digit
        }
        /*else if display.text != "0"{
            display.text = display.text! + digit
            inTheMiddleOfTyping = true
        }*/
        else{
            display.text = digit
            inTheMiddleOfTyping = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if(inTheMiddleOfTyping){
            enter()
        }
        switch operation {
        case "+": performOperation { $1 + $0 }
        case "-": performOperation { $1 - $0 }
        case "*": performOperation { $1 * $0 }
        case "/": performOperation { $1 / $0 }
        case "sqrt": performOperation() { sqrt($0) }
        default: break;
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if(operandStack.count >= 2) {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: (Double) -> Double) {
        if(operandStack.count >= 1) {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()

    @IBAction func enter() {
        inTheMiddleOfTyping = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            inTheMiddleOfTyping = false
        }
    }
}









