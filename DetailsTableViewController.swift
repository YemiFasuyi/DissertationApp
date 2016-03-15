//
//  DetailsTableViewController.swift
//  MapTestingNumber99
//
//  Created by Opeyemi Fasuyi on 15/03/2016.
//  Copyright © 2016 Opeyemi Fasuyi. All rights reserved.
//
import UIKit
import MapKit
import AddressBookUI
import Contacts

class DetailsTableViewController: UITableViewController {
    var mapItems: [MKMapItem]!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of rows in the section
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "detailsCell", forIndexPath: indexPath) as! DetailsTableViewCell
        
        // Configure the cell...
        let row = indexPath.row
        let item = mapItems[row]
        cell.lblName.text = item.name
        cell.txtAddress.text = ABCreateStringWithAddressDictionary(item.placemark.addressDictionary!, false)
        cell.lblNumber.text = item.phoneNumber
        cell.txtWebsite.text = "\(item.url)"
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject?) {
            let routeViewController = segue.destinationViewController
                as! RouteViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow!
            
            let row = indexPath.row
            
            routeViewController.destination = mapItems![row]
    }


}
