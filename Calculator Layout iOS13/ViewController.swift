//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calculatorScreen: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    var number1 = 0
    var number2 = 0
    var operation = ""
    var nextNumber = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func numberPressed(_ sender: UIButton) {
        if(operation == "="){
            operation = ""
        }
        let number:Int = Int(sender.currentTitle!)!
        if(calculatorScreen.text?.trimmingCharacters(in: .whitespaces) == "0" || nextNumber == true){
            calculatorScreen.text = String(number)
            nextNumber = false
            clearButton.setTitle("C", for: .normal)
        }
        else{
            calculatorScreen.text?.append(String(number))
        }
        animate(sender: sender)
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        if(calculatorScreen.text?.trimmingCharacters(in: .whitespaces) != "0"){
            calculatorScreen.text = "0"
            number2 = 0
            sender.setTitle("AC", for: .normal)
        }
        else{
            calculatorScreen.text = "0"
            number1 = 0
            number2 = 0
            operation = ""
            sender.setTitle("AC", for: .normal)
        }
        animate(sender: sender)
    }
    
    @IBAction func operatorPressed(_ sender: UIButton) {
        if(operation == ""){
            number1 = Int(calculatorScreen.text!)!
            operation = sender.currentTitle!
            nextNumber = true
        }
        else{
            number2 = Int(calculatorScreen.text!)!
            var result = 0
            switch(operation){
            case "+":
                result = number1 + number2
                break
            case "×":
                result = number1 * number2
                break
            case "-":
                result = number1 - number2
                break
            case "÷":
                if(number2 == 0){
                    result = 0
                }
                else{
                    result = number1 / number2
                }
                break
            case "=":
                result = number1
                break
            default:
                break
            }
            calculatorScreen.text = String(result)
            nextNumber = true
            number1 = result
            operation = sender.currentTitle!
        }
        animate(sender: sender)
    }
    
    @IBAction func plusMinusButton(_ sender: UIButton) {
        var number = Int(calculatorScreen.text!)!
        number = 0 - number
        calculatorScreen.text = String(number)
    }
    
    func animate(sender: UIButton){
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
            sender.alpha = 1.0
        }
    }
}

