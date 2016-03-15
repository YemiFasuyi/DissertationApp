//
//  ViewController.swift
//  v1LetsGiveItATry
//
//  Created by Opeyemi Fasuyi on 08/02/2016.
//  Copyright © 2016 Opeyemi Fasuyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    //lazy var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 200, 20))
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 0, 0))
    var toPassVariable:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchBar.placeholder = "Search for a service, business or industry"
        navigationItem.titleView = searchBar
        //let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        //self.navigationItem.leftBarButtonItem = leftNavBarButton

        // Do any additional setup after loading the view, typically from a nib.
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