//
//  ViewController.swift
//  MapMe
//
//  Created by Adam Rikardsen-Smith on 13/11/2018.
//  Copyright © 2018 Adam Rikardsen-Smith. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    var locationManager: CLLocationManager?
    var regionRadius: CLLocationDistance = 1000

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        
        checkLocationAuthStatus()
        centerMapOnUserLocation()
        
        
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addLocation()
    }

    @IBAction func backToMaps(_ segue: UIStoryboardSegue) {
        
    }

    func checkLocationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedAlways{
            locationManager?.startUpdatingLocation()
        } else{
            locationManager?.requestAlwaysAuthorization()
        }
        
    }
    
    func centerMapOnUserLocation(){
        let coordinateRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addLocation(){
        let annotation = MKPointAnnotation()
        annotation.coordinate = mapView.userLocation.coordinate
        annotation.title = "Pizza"
        annotation.subtitle = "Great pizza place with incredibly tasty, fresh and authentic italian chow"
        mapView.addAnnotation(annotation)
    }
    
}

extension MapViewController: MKMapViewDelegate{
    
}

extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthStatus()
        if status == .authorizedAlways{
            checkLocationAuthStatus()
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        }
    }
}
