//
//  Detail.swift
//  MapTestingNumber99
//
//  Created by Opeyemi Fasuyi on 15/03/2016.
//  Copyright © 2016 Opeyemi Fasuyi. All rights reserved.
//

import UIKit
import MapKit

class DetailsTableViewController: UITableViewController {
    var mapItems: [MKMapItem]!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblWebsite: UILabel!
    
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
        
        /*let cell = tableView.dequeueReusableCellWithIdentifier(
            "resultCell", forIndexPath: indexPath) as! ResultsTableViewCell
        
        // Configure the cell...
        let row = indexPath.row
        let item = mapItems[row]
        cell.nameLabel.text = item.name
        cell.phoneLabel.text = item.phoneNumber
        return cell*/
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
