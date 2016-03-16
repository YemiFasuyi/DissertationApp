//
//  ViewController.swift
//  v1LetsGiveItATry
//
//  Created by Opeyemi Fasuyi on 08/02/2016.
//  Copyright © 2016 Opeyemi Fasuyi. All rights reserved.
//

import UIKit
import AddressBookUI
import Contacts
import ContactsUI
import CloudKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    var toPassVariable:String!
    var searchController:UISearchController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func showSearchBar(sender: AnyObject) {
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self
        presentViewController(searchController, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        toPassVariable = searchBar.text
        
        self.performSegueWithIdentifier("mySegue", sender: nil)
        
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
    }

    @IBAction func btnATMClicked(sender: AnyObject) {
        toPassVariable = "atm"
    }
    
    @IBAction func btnRestaurantClicked(sender: AnyObject) {
        toPassVariable = "restaurant"
    }
    
    @IBAction func btnHotelClicked(sender: AnyObject) {
        toPassVariable = "hotel"
    }
    
    @IBAction func btnParking(sender: AnyObject) {
        toPassVariable = "parking"
    }
    
    @IBAction func btnPetrolClicked(sender: AnyObject) {
        toPassVariable = "petrol station"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject?) {
            if(segue.identifier == "mySegue")
            {
                let test = segue.destinationViewController as! MapViewController
                test.toPass = toPassVariable
            }
            else
            {
                let test = segue.destinationViewController as! MapViewController
                test.toPass = toPassVariable
            }
    }
}