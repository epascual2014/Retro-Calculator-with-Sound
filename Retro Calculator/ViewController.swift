//
//  ViewController.swift
//  Retro Calculator
//
//  Created by Edrick Pascual on 9/27/16.
//  Copyright © 2016 Edge Designs. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    
    var buttonSound: AVAudioPlayer!
    
    var currentRunningNumber = ""
    var leftValueString = ""
    var rightValueString = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBAction func numberPressed(btn: UIButton) {
        buttonSound.play()
        
        currentRunningNumber += "\(btn.tag)"
        outputLabel.text = currentRunningNumber
        
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processedOperation(Operation.Divide)
        
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processedOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processedOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processedOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processedOperation(currentOperation)
    }
    
    
    func processedOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            
            
            if currentRunningNumber != "" {
                rightValueString = currentRunningNumber
                currentRunningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValueString)! * Double(rightValueString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValueString)! / Double(rightValueString)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValueString)! - Double(rightValueString)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValueString)! + Double(rightValueString)!)"
                }
                
                leftValueString = result
                outputLabel.text = result
                
            }
            
            currentOperation = op
            
        } else {
            leftValueString = currentRunningNumber
            currentRunningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if buttonSound.playing {
            buttonSound.stop()
        }
        buttonSound.play()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getSoundBundle()
        
    }
    
    
    func getSoundBundle() {
        // Assign path and name, and  type of sound
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        // Assign the url of the sound
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        // In case audio does not play
        do {
            try buttonSound = AVAudioPlayer(contentsOfURL: soundUrl)
            // Prep sound
            buttonSound.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
}

