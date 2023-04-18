//
//  Contact.swift
//  MyContacts
//
//  Created by Gaurang Naik on 2023-04-03.
//

import Foundation

class Contact : NSObject, NSCoding, NSSecureCoding
{
    static var supportsSecureCoding: Bool = true
    
    var FirstName: String
    var LastName: String
    var PrimaryPhone: String
    var SecondaryPhone: String
    var CompanyName: String
    
    
    override init() {
        self.FirstName = ""
        self.LastName = ""
        self.PrimaryPhone = ""
        self.SecondaryPhone = ""
        self.CompanyName = ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(FirstName, forKey: "firstName")
        coder.encode(LastName, forKey: "lastName")
        coder.encode(PrimaryPhone, forKey: "primaryPhone")
        coder.encode(SecondaryPhone, forKey: "secondaryPhone")
        coder.encode(CompanyName, forKey: "companyName")
    }
    
    required init?(coder: NSCoder) {
        FirstName = coder.decodeObject(forKey: "firstName") as! String
        LastName = coder.decodeObject(forKey: "lastName") as! String
        PrimaryPhone = coder.decodeObject(forKey: "primaryPhone") as! String
        SecondaryPhone = coder.decodeObject(forKey: "secondaryPhone") as! String
        CompanyName = coder.decodeObject(forKey: "companyName") as! String
    }
}
