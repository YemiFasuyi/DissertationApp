//
//  ViewController.swift
//  v1LetsGiveItATry
//
//  Created by Opeyemi Fasuyi on 08/02/2016.
//  Copyright © 2016 Opeyemi Fasuyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var toPassVariable:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
            /*let alert = UIAlertController(title: "Alert!!!", message: toPassVariable, preferredStyle: UIAlertControllerStyle.Alert)
            let okayButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(okayButton)
            
            presentViewController(alert, animated: true, completion: nil)*/
            
            let test = segue.destinationViewController as! MapViewController
            
            test.toPass = toPassVariable

    }
    
}