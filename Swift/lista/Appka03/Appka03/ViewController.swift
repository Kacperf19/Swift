//
//  ViewController.swift
//  Appka03
//
//  Created by Student Informatyki on 07/01/2025.
//

import Cocoa

class ViewController: NSViewController {
    
    var people : [Person] = []
    @IBOutlet weak var nameTF: NSTextField!
    @IBOutlet weak var emailTF: NSTextField!
    @IBOutlet weak var phoneTF: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    @IBAction func addPerson(_ sender: Any) {
        let name = nameTF.stringValue
        let email = emailTF.stringValue
        let phone = phoneTF.stringValue
        
        if !name.isEmpty && !email.isEmpty && !phone.isEmpty {
            let newPerson = Person(name: name, email: email, phone: phone)
            people.append(newPerson)
            tableView.reloadData()
        }else{
            let alert = NSAlert()
            alert.messageText = "Wszystkie pola są wymagane!"
            alert.icon = NSImage(named: "icon")
            alert.informativeText = "Wypełnij wszystkie pola formularza w celu dodania nowego uzytkownika!"
            alert.alertStyle = .warning
            alert.runModal()
        }
        
        nameTF.stringValue = ""
        emailTF.stringValue = ""
        phoneTF.stringValue = ""
    }
    
    @IBAction func deletePerson(_ sender: Any) {
        let selectedRow = tableView.selectedRow
        if selectedRow >= 0 {
            people.remove(at: selectedRow)
            tableView.reloadData()
        } else{
            let alert = NSAlert()
            alert.messageText = "Nie wybrano użytkownika!"
            alert.icon = NSImage(named: "icon")
            alert.informativeText = "Wybierz użytkownika z listy aby usunąć!"
            alert.alertStyle = .warning
            alert.runModal()
        }
    }
    @IBAction func editPerson(_ sender: Any) {
        let selectedRow = tableView.selectedRow
        if selectedRow >= 0 {
            nameTF.stringValue = people[selectedRow].name
            emailTF.stringValue = people[selectedRow].email
            phoneTF.stringValue = people[selectedRow].phone
            people.remove(at:selectedRow)
        } else {
            let alert = NSAlert()
            alert.messageText = "Nie wybrano użytkownika!"
            alert.icon = NSImage(named: "icon")
            alert.informativeText = "Wybierz użytkownika z listy aby edytować!"
            alert.alertStyle = .warning
            alert.runModal()
        }
    }
    @IBAction func loadPerson(_ sender: Any) {
        openFileDialog()
        
    }
    func openFileDialog() {
           let openPanel = NSOpenPanel()
           openPanel.allowedFileTypes = ["mac"]
           openPanel.canChooseFiles = true
           openPanel.canChooseDirectories = false
           openPanel.allowsMultipleSelection = false
           
           openPanel.begin { [weak self] (result) in
               if result == .OK, let url = openPanel.url {
                   self?.loadPeopleFromFile(url: url)
               }
           }
       }
       
    
    
    @IBAction func Save(_ sender: Any) {
        savePeopleToFile()
    }
    
    
       
       func loadPeopleFromFile(url: URL) {
           do {
               let data = try Data(contentsOf: url)
               let decoder = JSONDecoder()
               let loadedPeople = try decoder.decode([Person].self, from: data)
               people = loadedPeople
               tableView.reloadData()
           } catch {
               let alert = NSAlert()
               alert.messageText = "Błąd ładowania danych!"
               alert.icon = NSImage(named: "icon")
               alert.informativeText = "Nie udało się załadować danych z pliku: \(url.lastPathComponent)"
               alert.alertStyle = .warning
               alert.runModal()
           }
       }
       
    
    func savePeopleToFile() {
        let savePanel = NSSavePanel()
        savePanel.allowedFileTypes = ["mac"]
        savePanel.nameFieldStringValue = "people.mac"
        
        savePanel.begin { [weak self] (result) in
            if result == .OK, let url = savePanel.url {
                self?.saveDataToFile(url: url)
            }
        }
    }
    
    
    func saveDataToFile(url: URL) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(people) 
            try data.write(to: url)
        } catch {
            let alert = NSAlert()
            alert.messageText = "Błąd zapisywania danych!"
            alert.icon = NSImage(named: "icon")
            alert.informativeText = "Nie udało się zapisać danych do pliku: \(url.lastPathComponent)"
            alert.alertStyle = .warning
            alert.runModal()
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let newPerson = Person(name: "Jan Kowalski", email: "jkowalski@gmail.com", phone: "111-222-333")
        people.append(newPerson)
        tableView.reloadData()
    }

    override var representedObject: Any? {
        didSet {
     
        }
    }


}
extension ViewController : NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return people.count
    }
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let person = people[row]
        guard let cell = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
        
        if (tableColumn?.identifier)!.rawValue == "name" {
            cell.textField?.stringValue = person.name
        } else if (tableColumn?.identifier)!.rawValue == "email" {
            cell.textField?.stringValue = person.email
        } else {
            cell.textField?.stringValue = person.phone
        }
        return cell
    }
    
    
}
