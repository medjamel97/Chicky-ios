//
//  Social.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit
import MapKit
import CoreLocation


class SocialView: UIViewController, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager!
    var currentLocationStr = "Current location"
    // VAR
    var search: String = ""
    
    //Iboutlets
    @IBOutlet weak var Map: MKMapView!
    
    
    // WIDGET
    
    
    // PROTOCOLS

    
 
    
    
    // LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
       // getNearByLandmarks()
    }
    
    override func viewDidAppear(_ animated: Bool) {
           determineCurrentLocation()
       }
    
    
    @IBAction func btn_GetLocation(_ sender: UIButton) {
     
        
    }
    
    
    
    // METHODS
    func getNearByLandmarks() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.search
        
        let search = MKLocalSearch(request: request)
        search.start{(response, error) in
            if let response = response {
                let mapItems = response.mapItems
                print(mapItems)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let mUserLocation:CLLocation = locations[0] as CLLocation
            let center = CLLocationCoordinate2D(latitude: mUserLocation.coordinate.latitude, longitude: mUserLocation.coordinate.longitude)
            let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            Map.setRegion(mRegion, animated: true)

            // Get user's Current Location and Drop a pin
        let mkAnnotation: MKPointAnnotation = MKPointAnnotation()
            mkAnnotation.coordinate = CLLocationCoordinate2DMake(mUserLocation.coordinate.latitude, mUserLocation.coordinate.longitude)
            mkAnnotation.title = self.setUsersClosestLocation(mLattitude: mUserLocation.coordinate.latitude, mLongitude: mUserLocation.coordinate.longitude)
            Map.addAnnotation(mkAnnotation)
        }
    
    func setUsersClosestLocation(mLattitude: CLLocationDegrees, mLongitude: CLLocationDegrees) -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: mLattitude, longitude: mLongitude)

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
        locationManager.requestAlwaysAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }

    
    
    
    // ACTIONS
    

}
