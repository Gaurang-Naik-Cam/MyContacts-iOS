//
//  ContactList.swift
//  MyContacts
//
//  Created by Gaurang Naik on 2023-04-03.
//

import Foundation

class ContactList {
    
    private let ContactURL : URL = {
        let directories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = directories.first!
        return documentDirectory.appending(path: "contacts.local")
    }()
    var Contacts : [Contact]
    
    init() {
        
        let data = try? Data(contentsOf: ContactURL)
        if data == nil {
            print("Sample data loading before the save.")
            
            self.Contacts = [Contact]()
            
            let JsonContact:Contact = Contact()
            JsonContact.FirstName = "Json"
            JsonContact.LastName = "Smith"
            JsonContact.PrimaryPhone = "(979)-850-1340"
            
            let AaronContact:Contact = Contact()
            AaronContact.FirstName = "Aaron"
            AaronContact.LastName = "Mckenzie"
            AaronContact.PrimaryPhone = "(859)-980-1379"
            
            let AndreaContact:Contact = Contact()
            AndreaContact.FirstName = "Andrea"
            AndreaContact.LastName = "Sanborn"
            AndreaContact.PrimaryPhone = "(979)-808-2356"
            
            let MarcContact:Contact = Contact()
            MarcContact.FirstName = "Marc"
            MarcContact.LastName = "Ponting"
            MarcContact.PrimaryPhone = "(249)-979-2700"
            
            let VishalContact:Contact = Contact()
            VishalContact.FirstName = "Vishal"
            VishalContact.LastName = "Sharma"
            VishalContact.PrimaryPhone = "(249)-989-3214"
            
            let PeterContact:Contact = Contact()
            PeterContact.FirstName = "Peter"
            PeterContact.LastName = "Jackson"
            PeterContact.PrimaryPhone = "(249)-850-7777"
            
            self.Contacts.insert(JsonContact, at: 0)
            self.Contacts.insert(AaronContact, at: 1)
            self.Contacts.insert(AndreaContact, at: 2)
            self.Contacts.insert(MarcContact, at: 3)
            self.Contacts.insert(VishalContact, at: 4)
            self.Contacts.insert(PeterContact, at: 5)
            
        }
        else{
            
            Contacts = try! NSKeyedUnarchiver.unarchivedArrayOfObjects(ofClass: Contact.self, from: data!)!
            print("Retrieving from the local storage")
            
        
    }
}
        
            
            
        
        
    
    func Save(){
        do {
            let encodedContacts = try NSKeyedArchiver.archivedData(withRootObject: Contacts, requiringSecureCoding: true)
            
            try encodedContacts.write(to: ContactURL)
            print("All objects are saved")
            
        }
        catch let err {
            preconditionFailure(err.localizedDescription)
            
        }
    }
    
 
}
