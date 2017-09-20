//
//  MapViewController.swift
//  SmarTree_2017Summer
//
//  Created by Stephen on 9/19/17.
//  Copyright © 2017 Appkoder. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressTextfield: UITextField!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var oldLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressTextfield.delegate = self
        self.title = "My location"
        
        oldLocation = nil
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 20
        
        mapView.showsUserLocation = true

        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let region = MKCoordinateRegionMakeWithDistance((locations.last?.coordinate)!, 1200, 1200)
        
        print(locations.last?.coordinate)
        mapView.setRegion(region, animated: true)
        
        if oldLocation == nil
        {
            oldLocation = locations.first
        }
        let newLocation = locations.last
        let distance = newLocation?.distance(from: oldLocation)
        
        if let distance = distance
        {
            //distanceLabel.text = String(format: "%0.1f meters", distance)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        let addressGeocoder = CLGeocoder()
        addressGeocoder.geocodeAddressString(addressTextfield.text!) { (placemarks, error) in
            
            if error != nil
            {
                print(error)
                return
            }
            
            if let placemarks = placemarks
            {
                let firstPlacemark = placemarks[0]
                
                let annotation = MKPointAnnotation()
                annotation.title = "This is the title"
                annotation.subtitle = "Subtitle - 83273903"
                
                if let location = firstPlacemark.location
                {
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
                
            }
        }
        
        return true
    }
}
