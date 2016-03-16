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
    var detailsAddress:String!
    var detailsNumber:String!
    var detailsUrl:String!
    
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
                self.detailsName = "\(item.name)"
                self.detailsNumber = "\(item.phoneNumber)"
                self.detailsAddress = "\(item.placemark)"
                self.detailsUrl = "\(item.url)"
                
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
            //return nil so map view draws "blue dot" for standard user location
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
        
        //let selectedLoc = view.annotation
        //matchingItems.
        
        //print("Annotation '\(selectedLoc!.title!)' has been selected")
        //print("Description '\(selectedLoc!.)' has been selected")
        //print("Coordinate '\(selectedLoc!.coordinate)' has been selected")
        
        /*let currentLocMapItem = MKMapItem.mapItemForCurrentLocation()
        
        let selectedPlacemark = MKPlacemark(coordinate: selectedLoc!.coordinate, addressDictionary: nil)
        let selectedMapItem = MKMapItem(placemark: selectedPlacemark)
        
        
        mapItems = [selectedMapItem, currentLocMapItem]
        print(selectedMapItem)*/
        
        if control == view.rightCalloutAccessoryView {
            performSegueWithIdentifier("DetailsSegue", sender: self)
        }
        
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError){
        print("Error: " + error.localizedDescription)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                DetailsTableViewController
                
                //destination.mapItems = self.matchingItems.indexOf(<#T##element: MKMapItem##MKMapItem#>)
            }
            else
            {
                let destination = segue.destinationViewController as!
                ResultsTableViewController
            
                destination.mapItems = self.matchingItems
            }
    }
}

