//
//  ViewController.swift
//  retroCalculator
//
//  Created by Caio Alcântara on 23/01/2017.
//  Copyright © 2017 Caio Alcântara. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    var soundButton : AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValString = ""
    var rightValString = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            
            try soundButton = AVAudioPlayer(contentsOf: soundURL)
            soundButton.prepareToPlay()
            
        } catch let err as NSError {
            
            print(err.debugDescription)
            
        }
     
        outputLabel.text = "0 "
    }
    
    @IBAction func numberButton(_ sender: UIButton) {
        
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    
    @IBAction func onDividePressed(_ sender: UIButton) {
        processOperation(operation: .Divide)
        
    }
    
    @IBAction func onMultiplyPressed(_ sender: UIButton) {
        processOperation(operation: .Multiply)

    }
    
    @IBAction func onSubtractPressed(_ sender: UIButton) {
        processOperation(operation: .Subtract)

    }
    
    @IBAction func onPlusPressed(_ sender: UIButton) {
        processOperation(operation: .Add)

    }
  
    @IBAction func onEqualPressed(_ sender: UIButton) {
        processOperation(operation: currentOperation)
    }
    
    func playSound() {
        
        if soundButton.isPlaying {
            
            soundButton.stop()
        }
        
        soundButton.play()
    }
    
    func processOperation(operation : Operation){
        playSound()
        if(currentOperation != Operation.Empty){
            
            if runningNumber != ""{
                rightValString = runningNumber
                runningNumber = ""

                if currentOperation == Operation.Multiply {
                    
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                    
                } else if currentOperation == Operation.Divide {
                    
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                    
                } else if currentOperation == Operation.Subtract {
                    
                    result = "\(Double(leftValString)! - Double(rightValString)!)"

                } else if currentOperation == Operation.Add {
                    
                    result = "\(Double(leftValString)! + Double(rightValString)!)"

                }
                
                leftValString = result
                outputLabel.text = result
            }
            
            currentOperation = operation
        } else {
            
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = operation 
        }
    }
    
}

