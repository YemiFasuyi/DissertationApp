//
//  RetrieveUserNameAndNumber.swift
//  MapTestingNumber99
//
//  Created by Opeyemi Fasuyi on 14/03/2016.
//  Copyright © 2016 Opeyemi Fasuyi. All rights reserved.
//

import Foundation
import Contacts

/*class GetUserInfo: CNContact {
    
    let contact:CNContact!
    
    func test(){
        if (contact.isKeyAvailable(CNContactPhoneNumbersKey)) {
            for phoneNumber:CNLabeledValue in contact.phoneNumbers {
                let a = phoneNumber.value as! CNPhoneNumber
                print("\(a.stringValue)")
            }
        }

    }
}*/
/*var contactStore = CNContactStore()
var contacts = [CNContact]()


func findContacts() -> [CNContact] {
    
    let store = CNContactStore()
    let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),
        CNContactImageDataKey,
        CNContactPhoneNumbersKey]
    
    let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
    
    [CNContactGivenNameKey,
        CNContactNamePrefixKey,
        CNContactNameSuffixKey,
        CNContactMiddleNameKey,
        CNContactFamilyNameKey,
        CNContactTypeKey]
    
    var contacts = [CNContact]()
    
    do {
        try store.enumerateContactsWithFetchRequest(fetchRequest, usingBlock: { (let contact, let stop) -> Void in
            contacts.append(contact)
        })
    }
    catch let error as NSError {
        print(error.localizedDescription)
    }
    
    return contacts
}*/
/* view did load
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
self.contacts = self.findContacts()

dispatch_async(dispatch_get_main_queue()) {
self.displayName()
}
}*/

/*func displayName(){

var numberArray = [String]()
for number in contacts[0].phoneNumbers {
let phoneNumber = number.value as! CNPhoneNumber
numberArray.append(phoneNumber.stringValue)
}

let alert = UIAlertController(title: "Alert!!!", message: numberArray[0], preferredStyle: UIAlertControllerStyle.Alert)
let okayButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
alert.addAction(okayButton)

presentViewController(alert, animated: true, completion: nil)
}
*/

