//
//  MapViewController.swift
//  BabySitter
//
//  Created by Mina Shehata Gad on 1/29/17.
//  Copyright © 2017 Mina Shehata Gad. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController ,MKMapViewDelegate, CLLocationManagerDelegate{

    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet var txtTimeDistance: UILabel!
    
    var locationManager = CLLocationManager()
    var myPosition = CLLocationCoordinate2D()
    
    // creae a variable destination for directions
    
    var destination:MKMapItem = MKMapItem()
    var employee:Employee?
    var DLC = MKMapItem()
    var SLC = MKMapItem()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let DestlocCoord = CLLocationCoordinate2DMake(Double((employee?.FromLat)!)!, Double((employee?.ToLong)!)!)
        let sourceLocationCord = CLLocationCoordinate2DMake(Double((employee?.ToLat)!)!, Double((employee?.FromLong)!)!)

        let span = MKCoordinateSpanMake(0.05, 0.05)
        
        
        let region1 = MKCoordinateRegion(center: DestlocCoord, span: span)
        let region2 = MKCoordinateRegion(center: sourceLocationCord, span: span)
        
        self.mapView.setRegion(region1, animated: true)
        self.mapView.setRegion(region2, animated: true)
        
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = DestlocCoord
        annotation.title = "Destination "
        
        
        let annotationS = MKPointAnnotation()
        
        annotationS.coordinate = sourceLocationCord
        annotationS.title = "Sourse"
        
        mapView.addAnnotations([annotationS , annotation])

        
        
        let placeMarkD = MKPlacemark(coordinate: DestlocCoord, addressDictionary: nil)
        let placeMarkS = MKPlacemark(coordinate: sourceLocationCord, addressDictionary: nil)
        
        
        DLC = MKMapItem(placemark: placeMarkD)
        SLC = MKMapItem(placemark: placeMarkS)

        
        self.mapView.addAnnotation(annotation)

        let request = MKDirectionsRequest()
        request.source = DLC
        
        
        request.destination = SLC
        
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        
        directions.calculate (completionHandler: {
            (response: MKDirectionsResponse?, error: Error?) in
            if error != nil {
                print("error")
            }else{
                for route in (response?.routes)!  {
                    
                    self.mapView.add(route.polyline, level: MKOverlayLevel.aboveRoads)
                    for next in route.steps{
                        print(next.instructions)
                        
                    }
                    
                }
                
            }
        })
        
    }
   
    
    
    
    @IBAction func addPin(_ sender: UILongPressGestureRecognizer) {
        
        
        let location = sender.location(in: self.mapView)
        
        let locCoord = self.mapView.convert(location, toCoordinateFrom: self.mapView)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = locCoord
        annotation.title = "MyLocation"
        annotation.subtitle = "this is Current Location Of User"
        
        
        
        // create a place mark and a map item
        
        let placeMark = MKPlacemark(coordinate: locCoord, addressDictionary: nil)
        
        
        // This is needed when we need to get direction
        
        destination = MKMapItem(placemark: placeMark)
        
        
        
        
        //self.mapView.removeAnnotations(mapView.annotations)
        
        self.mapView.addAnnotation(annotation)
        
    }
    
    
    
    
    @IBAction func showDirections(_ sender: AnyObject) {
        
        
        
        let request = MKDirectionsRequest()
        request.source = destination
        
        
        request.destination = DLC
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)
        
        directions.calculate (completionHandler: {
            (response: MKDirectionsResponse?, error: Error?) in
            if error != nil {
                print("error")
                
            }else{
                
             
                for route in (response?.routes)!  {
                    
                    self.mapView.add(route.polyline, level: MKOverlayLevel.aboveRoads)
                    self.txtTimeDistance.text =  "the Distance From Distination to Current Location :\(route.distance) M and Time Taken is \(route.expectedTravelTime) Minute"

                    for next in route.steps{
                        print(next.instructions)
                        
                    }
                    
                }
                
            }
        })
        
        
    }
    
    

    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
    {
        let draw = MKPolylineRenderer(overlay: overlay)
        draw.strokeColor = UIColor.purple
        draw.lineWidth = 5.0
        return draw
    }
    
    
    
    
}

