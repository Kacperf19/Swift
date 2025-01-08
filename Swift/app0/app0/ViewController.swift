//
//  ViewController.swift
//  app0
//
//  Created by Student Informatyki on 26/11/2024.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var Username: NSTextField!
    @IBOutlet weak var Userpassword: NSSecureTextField!
    @IBOutlet weak var WelcomeField: NSTextField!
    @IBOutlet weak var NextButton: NSButton!
    
    
    @IBAction func NextWindowButton(_ sender: NSButton) {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let nextWindow = storyboard.instantiateController(withIdentifier: "SecondWindow") as!NSWindowController
        nextWindow.showWindow(self)
        self.view.window?.close()
    }
    
    @IBAction func WelcomeButtonClick(_ sender: NSButton) {
        
        if  Userpassword.stringValue == "123"{
            WelcomeField.textColor = .green
            WelcomeField.stringValue = "Welcome \(Username.stringValue)"
            NextButton.isHidden = false}
        else {
            WelcomeField.stringValue = "Invalid username or password"
            NextButton.isHidden = true
            WelcomeField.textColor = .red
        }
        Username.stringValue = ""
        Userpassword.stringValue = ""
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WelcomeField.stringValue = ""
        NextButton.isHidden = true
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

