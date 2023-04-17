//
//  DetailsViewController.swift
//  A4_TableView
//
//  Created by Gaurang Naik on 2023-04-01.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var formTitle:UINavigationItem!
    
    var contactlist:ContactList!
    var selectedIndex:Int!
    
    @IBOutlet weak var firstNameTextfield:UITextField!
    @IBOutlet weak var lastNameTextfield:UITextField!
    @IBOutlet weak var primaryPhoneTextfield:UITextField!
    @IBOutlet weak var secondaryPhoneTextfield:UITextField!
    @IBOutlet weak var companyTextfield:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        if(selectedIndex >= 0){
            formTitle.title = "Update Contact"
            firstNameTextfield.text! = contactlist.Contacts[selectedIndex].FirstName
            lastNameTextfield.text! = contactlist.Contacts[selectedIndex].LastName
            primaryPhoneTextfield.text! = contactlist.Contacts[selectedIndex].PrimaryPhone
            secondaryPhoneTextfield.text! = contactlist.Contacts[selectedIndex].SecondaryPhone
            companyTextfield.text! = contactlist.Contacts[selectedIndex].CompanyName
            
        }
        else{
            formTitle.title = "Add Contact"
        }
        
    }
    
    @IBAction func SaveMovie(){
        
        if(selectedIndex >= 0) {
            
            let existingContact = contactlist.Contacts[selectedIndex]
            existingContact.FirstName  = firstNameTextfield.text!
            existingContact.LastName = lastNameTextfield.text!
            existingContact.PrimaryPhone = primaryPhoneTextfield.text!
            existingContact.SecondaryPhone = secondaryPhoneTextfield.text!
            existingContact.CompanyName = companyTextfield.text!
            
            
            if(existingContact.FirstName == "" || existingContact.PrimaryPhone == "")
            {
                let alert = UIAlertController(title: "Missing mandatory fields", message: " First Name and Primary phone number are mandatory fields.\nPlease fill in the same and try again.", preferredStyle: .alert)
                let alertOkAction = UIAlertAction(title: "OK", style: .default)
                
                alert.addAction(alertOkAction)
                self.present(alert, animated: true)
                return
            }
            
            contactlist.Contacts.remove(at: selectedIndex)
            contactlist.Contacts.insert(existingContact, at: selectedIndex)
            
            
            let alert = UIAlertController(title: "Updated the contact", message: " \(existingContact.FirstName) is modified as per your request. Thank you.", preferredStyle: .alert)
            let alertOkAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(alertOkAction)
            self.present(alert, animated: true)
            clearTextfields()
            
            return
        }
        else {
            let newContact = Contact()
            newContact.FirstName  = firstNameTextfield.text!
            newContact.LastName = lastNameTextfield.text!
            newContact.PrimaryPhone = primaryPhoneTextfield.text!
            newContact.SecondaryPhone = secondaryPhoneTextfield.text!
            newContact.CompanyName = companyTextfield.text!
            
            
            if(newContact.FirstName == "" || newContact.PrimaryPhone == "")
            {
                let alert = UIAlertController(title: "Missing mandatory fields", message: " First Name and Primary phone number are mandatory fields.\nPlease fill in the same and try again.", preferredStyle: .alert)
                let alertOkAction = UIAlertAction(title: "OK", style: .default)
                
                alert.addAction(alertOkAction)
                self.present(alert, animated: true)
                return
            }
            
            let result = contactlist.Contacts.first(where: {$0.PrimaryPhone == newContact.PrimaryPhone || $0.SecondaryPhone == newContact.PrimaryPhone})
            
            if(result != nil)
            {
                let alert = UIAlertController(title: "Duplicate entry", message: " \(newContact.PrimaryPhone) is already present in your contact list. Please add another contact.", preferredStyle: .alert)
                let alertOkAction = UIAlertAction(title: "OK", style: .default)
                
                alert.addAction(alertOkAction)
                self.present(alert, animated: true)
                return
                
            }
            
            contactlist.Contacts.append(newContact)
         //   contactlist.Contacts.insert(newContact, at: contactlist.Contacts.count)
            print("New item added in details " + String(contactlist.Contacts.count))
            
            let alert = UIAlertController(title: "Saved the contact", message: " \(newContact.FirstName) is added to your contact list. Thank you.", preferredStyle: .alert)
            let alertOkAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(alertOkAction)
            self.present(alert, animated: true)
            clearTextfields()
            
            return
        }
    }
    
    func clearTextfields(){
        firstNameTextfield.text = ""
        lastNameTextfield.text = ""
        primaryPhoneTextfield.text = ""
        secondaryPhoneTextfield.text = ""
        companyTextfield.text = ""
    }
    
}
