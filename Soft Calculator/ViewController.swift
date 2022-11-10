import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVAudioPlayer!
    @IBOutlet weak var calculatorScreen: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var percentageButton: UIButton!
    @IBOutlet var operatorButtons: [UIButton]!
    var number1: Double = 0
    var number2: Double = 0
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
        for button in operatorButtons{
            button.alpha = 1.0
        }
        animate(sender: sender)
        playSound(btn:"calculatorPress")
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        if(calculatorScreen.text?.trimmingCharacters(in: .whitespaces) != "0"){
            calculatorScreen.text = "0"
            number2 = 0
            sender.setTitle("AC", for: .normal)
            for button in operatorButtons{
                if(button.currentTitle == operation){
                    button.alpha = 0.5
                }
            }
        }
        else{
            calculatorScreen.text = "0"
            number1 = 0
            number2 = 0
            operation = ""
            sender.setTitle("AC", for: .normal)
            
            //setting operator button opacity to normal (1.0)
            for button in operatorButtons{
                button.alpha = 1.0
            }
        }
        animate(sender: sender)
        playSound(btn:"calculatorPress2")
    }
    
    @IBAction func operatorPressed(_ sender: UIButton) {
        if(operation == ""){
            number1 = Double(calculatorScreen.text!)!
            if(percentageOn == true){
                number1 = number1 / 100
                calculatorScreen.text = String(number1) // to show the first number being / by 100
            }
            operation = sender.currentTitle!
            nextNumber = true
            percentageOn = false
            percentageButton.alpha = 1.0
        }
        else if(number2 == 0){
            number2 = Double(calculatorScreen.text!)!
            if(percentageOn == true){
                number2 = number2 / 100
            }
            var result:Double = 0
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
            
            if(floor(result)==result){                      // not to display only zero after decimal marker
                calculatorScreen.text = String(Int(result))
            }
            else{
                calculatorScreen.text = String(result) // displays result
            }
            
            nextNumber = true
            number1 = result
            number2 = 0
            operation = sender.currentTitle!
            percentageOn = false
            percentageButton.alpha = 1.0
        }
//        animate(sender: sender)
        for button in operatorButtons{
            button.alpha = 1.0
        }
        if(sender.currentTitle != "="){
            sender.alpha = 0.5
        }
        playSound(btn:"calculatorPress2")
    }
    
    @IBAction func plusMinusButton(_ sender: UIButton) {
        var number = Double(calculatorScreen.text!)!
        number = 0 - number
        if(floor(number)==number){                      // not to display only zero after decimal marker
            calculatorScreen.text = String(Int(number))
        }
        else{
            calculatorScreen.text = String(number) // displays result
        }
        playSound(btn:"calculatorPress2")
        animate(sender: sender)
    }
    
    @IBAction func percentagePressed(_ sender: UIButton) {
        if(percentageOn == false){
            percentageOn = true
            sender.alpha = 0.5
        }
        else{
            percentageOn = false
            sender.alpha = 1.0
        }
        playSound(btn:"calculatorPress2")
    }
    
    @IBAction func decimalMarkerPressed(_ sender: UIButton) {
        //adding . with new numbers zero
        if(nextNumber == true){
            calculatorScreen.text = "0."
            nextNumber = false
            
            //increasing opacity for any operator pressed before
            for button in operatorButtons{
                button.alpha = 1.0
            }
        }
        
        //adding . with current displayed number if . is not there already
        if(!calculatorScreen.text!.contains(".")){
            calculatorScreen.text?.append(".")
        }
        animate(sender: sender)
        playSound(btn:"calculatorPress")
    }
    
    func animate(sender: UIButton){
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
            sender.alpha = 1.0
        }
    }
    
    func playSound(btn: String) {
        let fileType = "wav"
        let url = Bundle.main.url(forResource: btn, withExtension: fileType)
        player = try! AVAudioPlayer(contentsOf: url!)
        player.volume = 0.1
        player.play()
    }

}

