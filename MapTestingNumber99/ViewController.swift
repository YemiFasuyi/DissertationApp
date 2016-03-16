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
    
    //lazy var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 200, 20))
    //lazy var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 0, 0))
    var toPassVariable:String!
    var searchController:UISearchController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        //self.navigationItem.leftBarButtonItem = leftNavBarButton

        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func showSearchBar(sender: AnyObject) {
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self
        presentViewController(searchController, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        toPassVariable = searchBar.text
        
        /*let alert = UIAlertController(title: "Alert!!!", message: toPassVariable, preferredStyle: UIAlertControllerStyle.Alert)
        let okayButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(okayButton)
        
        presentViewController(alert, animated: true, completion: nil)*/
        
        self.performSegueWithIdentifier("mySegue", sender: nil)
        
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
    }
    
    /*func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        print("searchText \(searchBar.text)")
    }*/

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
            
            /*let alert = UIAlertController(title: "Alert!!!", message: toPassVariable, preferredStyle: UIAlertControllerStyle.Alert)
            let okayButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(okayButton)
            
            presentViewController(alert, animated: true, completion: nil)*/
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