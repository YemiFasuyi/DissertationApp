//
//  RouteViewController.swift
//  MapTestingNumber99
//
//  Created by Opeyemi Fasuyi on 05/03/2016.
//  Copyright © 2016 Opeyemi Fasuyi. All rights reserved.
//

import UIKit
import MapKit

class RouteViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var routeMap: MKMapView!
    var destination:MKMapItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        routeMap.showsUserLocation = true
        routeMap.delegate = self
        self.getDirections()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDirections() {
        
        let request = MKDirectionsRequest()
        request.source = MKMapItem.mapItemForCurrentLocation()
        request.destination = destination!
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        
        directions.calculateDirectionsWithCompletionHandler({(response:
            MKDirectionsResponse?, error: NSError?) in
            
            if error != nil {
                print("Error getting directions")
            } else {
                self.showRoute(response!)
            }
            
        })
    }
    
    func showRoute(response: MKDirectionsResponse) {
        
        for route in response.routes {
            
            routeMap.addOverlay(route.polyline,
                level: MKOverlayLevel.AboveRoads)
            
            for step in route.steps {
                print(step.instructions)
            }
        }
        if let userLocation = routeMap.userLocation.location {
            let region = MKCoordinateRegionMakeWithDistance(
                userLocation.coordinate, 500, 500)
            routeMap.setRegion(region, animated: true)
        }
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay
        overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            
            renderer.strokeColor = UIColor.blueColor()
            renderer.lineWidth = 5.0
            return renderer
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
