//
//  ViewController.swift
//  Stoper
//
//  Created by Student Informatyki on 17/12/2024.
//

import Cocoa

class ViewController: NSViewController {
    
    
    var ourtimer=Timer()
    var TimerDisplay = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Start(_ sender: Any) {
        ourtimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(Action), userInfo: nil, repeats: true)
    }
    
    @IBAction func Stop(_ sender: Any) {
        ourtimer.invalidate()
    }
    

    @IBAction func Reset(_ sender: Any) {
        TimerDisplay = 0
            Label.stringValue = "00:00"
            ourtimer.invalidate()
        
    }
        @objc func Action(){
            TimerDisplay += 1
            Label.stringValue = String(format: "%02d:%02d", Int(TimerDisplay) / 60, Int(TimerDisplay) % 60)
            

            
        }
    
    @IBAction func timestmap(_ sender: Any) {
        
        time.stringValue = String(format: "%02d:%02d", Int(TimerDisplay) / 60, Int(TimerDisplay) % 60)
        
    }
   
    @IBOutlet weak var time: NSTextField!
    
    @IBOutlet weak var Label: NSTextField!
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

