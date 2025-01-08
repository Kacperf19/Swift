
import Cocoa
class SeconWiewControler: NSViewController {
    

    @IBOutlet weak var SwitchDatePicker: NSSwitch!
    
    @IBOutlet weak var calendarOptions: NSComboBoxCell!
    @IBAction func calendarOptions(_ sender: NSComboBox) {
        if sender.indexOfSelectedItem == 0
        {
            calendar.backgroundColor = NSColor.red
        }
        else if sender.indexOfSelectedItem == 1
        {
            calendar.backgroundColor = NSColor.blue
        }
        else if sender.indexOfSelectedItem == 2
        {
            calendar.backgroundColor = NSColor.green
        }
        else{}
    }
    @IBOutlet weak var calendar: NSDatePicker!
    
    @IBAction func Data(_ sender: NSDatePickerCell) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        labb.stringValue = dateFormatter.string(from: sender.dateValue)
    }
    @IBOutlet weak var labb: NSTextFieldCell!
    @IBAction func SwitchDatePicker(_ sender: NSSwitch) {
        if SwitchDatePicker.state == NSSwitch.StateValue.on {
            calendar.isHidden = false
        } else
        {
            calendar.isHidden = true
        }
    }
    
    @IBOutlet weak var lab: NSTextField!
    
   @IBAction func Check(_ sender: NSButton) {
   if sender.state == .on {
     lab.isHidden = false
    } else {
     lab.isHidden = true
          }
    }
    


    
    
    
    override func viewDidLoad() {
        calendar.isHidden = true
        super.viewDidLoad()
        
        }

    }
    

