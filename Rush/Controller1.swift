//
//  FirstViewController.swift
//  Rush
//
//  Created by Rostislav KULAHIN on 12/1/18.
//  Copyright © 2018 Rostislav KULAHIN. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class Controller1: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    @IBOutlet weak var map: MKMapView!
    var numPassedOver : Int? = -1
    @IBAction func Mylocation(_ sender: UIButton) {
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        navbar.title = ""
    }
    @IBOutlet weak var selector1: UISegmentedControl!
    @IBOutlet weak var navbar: UINavigationItem!
    @IBAction func segcount(_ sender: UISegmentedControl) {
    if sender.selectedSegmentIndex == 0
        {
            self.map.mapType = .standard
        }
        else if sender.selectedSegmentIndex == 1
        {
            self.map.mapType = .satellite
        }
        else if sender.selectedSegmentIndex == 2
        {
            self.map.mapType = .hybrid
        }
    }
    
    let manager = CLLocationManager()
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        self.map.showsUserLocation = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.mapType = .hybrid
        selector1.selectedSegmentIndex = 2
        struct Location {
            let title: String
            let subtitle: String
            let latitude: Double
            let longitude: Double
        }
        let locations = [
            Location(title: "ecole 42",subtitle : "Cybercafe, Hotel et Cinema",     latitude: 48.896599, longitude: 2.318498),
            Location(title: "UNIT",subtitle : "Cybercafe, School 42",     latitude: 50.468821, longitude: 30.462179),
            Location(title: "Silpo",subtitle : "Supermarket",     latitude: 50.470616, longitude: 30.462307),
            Location(title: "Puzata",subtitle : "Cafe",     latitude: 50.469703, longitude: 30.466663)
        ]
        for Location in locations {
            let annotation = MKPointAnnotation()
            annotation.title = Location.title
            annotation.subtitle = Location.subtitle
            annotation.coordinate = CLLocationCoordinate2D(latitude: Location.latitude, longitude: Location.longitude)
            map.addAnnotation(annotation)
            
        }
            let region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(locations[numPassedOver! + 1].latitude, locations[numPassedOver! + 1].longitude), 800, 800)
            navbar.title = locations[numPassedOver! + 1].title
            map.setRegion(region,animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



