//
//  Social.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit
import MapKit
import CoreLocation


class SocialView: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var locationManager:CLLocationManager!
    var currentLocationStr = "Current location"
    // VAR
    var search: String = ""
    
    //Iboutlets
    @IBOutlet weak var mapView: MKMapView!
    
    
    // WIDGET
    
    
    // PROTOCOLS
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("nezlet")
        let pinAnnotation = mapView.annotations
        debugPrint(view.annotation)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is PinAnnotation {
            
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "")
            pinAnnotationView.tintColor = UIColor(named: "accentColor")
            pinAnnotationView.isDraggable = true
            pinAnnotationView.canShowCallout = true
            pinAnnotationView.animatesDrop = true
            return pinAnnotationView
            
        }
        return nil
    }
    
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        determineCurrentLocation()
    
        getThem()
    }
    
    
    @IBAction func btn_GetLocation(_ sender: UIButton) {
        getThem()
        
    }
    
    func getThem() {
        getNearByLandmarks { mapItems in
            
            var pinAnnotations : [PinAnnotation] = []
            for mapItem in mapItems {
                print ("------ Map items--------")
                print(mapItem)
                print ("------ Map items--------")
                
                let pinAnnotation = PinAnnotation()
                pinAnnotation.setCoordinate(newCoordinate: CLLocationCoordinate2DMake((mapItem.placemark.location?.coordinate.latitude)!, (mapItem.placemark.location?.coordinate.longitude)!))
                pinAnnotation.title = mapItem.name
                pinAnnotation.id = "parking._id"
                
                pinAnnotations.append(pinAnnotation)
            }
            
            
            self.mapView.addAnnotations(pinAnnotations)
        }
    }
    
    
    // METHODS
    func getNearByLandmarks(completed: @escaping ([MKMapItem]) -> Void ) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.search
        
        let search = MKLocalSearch(request: request)
        search.start{(response, error) in
            if let response = response {
                completed(response.mapItems)
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let mUserLocation:CLLocation = locations[0] as CLLocation
        let center = CLLocationCoordinate2D(latitude: mUserLocation.coordinate.latitude, longitude: mUserLocation.coordinate.longitude)
        let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(mRegion, animated: true)
        
        // Get user's Current Location and Drop a pin
        let mkAnnotation: MKPointAnnotation = MKPointAnnotation()
        mkAnnotation.coordinate = CLLocationCoordinate2DMake(mUserLocation.coordinate.latitude, mUserLocation.coordinate.longitude)
        mkAnnotation.title = self.setUsersClosestLocation(mLattitude: mUserLocation.coordinate.latitude, mLongitude: mUserLocation.coordinate.longitude)
        mapView.addAnnotation(mkAnnotation)
    }
    
    func setUsersClosestLocation(mLattitude: CLLocationDegrees, mLongitude: CLLocationDegrees) -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: mLattitude, longitude: mLongitude)
        
        print(location)
        
        geoCoder.reverseGeocodeLocation(location) {
            (placemarks, error) -> Void in
            
            if let mPlacemark = placemarks{
                if let dict = mPlacemark[0].addressDictionary as? [String: Any]{
                    if let Name = dict["Name"] as? String{
                        if let City = dict["City"] as? String{
                            self.currentLocationStr = Name + ", " + City
                        }
                    }
                }
            }
        }
        return currentLocationStr
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error - locationManager: \(error.localizedDescription)")
    }
    //MARK:- Intance Methods
    
    func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    
    
    
    // ACTIONS
    
    
}
