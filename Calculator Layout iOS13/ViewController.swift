import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var calculatorScreen: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    var number1 = 0
    var number2 = 0
    var operation = ""
    var nextNumber = false
    var percentageOn = false

    @IBAction func numberPressed(_ sender: UIButton) {
        if(operation == "="){
            operation = ""
            number1 = 0
            number2 = 0
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
            if(percentageOn == true){
                number1 = number1 / 100
            }
            operation = sender.currentTitle!
            nextNumber = true
            percentageOn = false
        }
        else if(number2 == 0){
            number2 = Int(calculatorScreen.text!)!
            if(percentageOn == true){
                number2 = number2 / 100
            }
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
            number2 = 0
            operation = sender.currentTitle!
            percentageOn = false
        }
        animate(sender: sender)
    }
    
    @IBAction func plusMinusButton(_ sender: UIButton) {
        var number = Int(calculatorScreen.text!)!
        number = 0 - number
        calculatorScreen.text = String(number)
    }
    
    @IBAction func percentagePressed(_ sender: UIButton) {
        percentageOn = true
    }
    
    func animate(sender: UIButton){
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
            sender.alpha = 1.0
        }
    }
}

