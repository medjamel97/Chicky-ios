//
//  Social.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import UIKit
import MapKit
import CoreLocation


class SocialView: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, ModalTransitionListener {

    // variables
    var selectedCategory = ""
    let locationManager = CLLocationManager()
    let myPin = MKPointAnnotation()
    var chosenLocation = ""
    
    // iboutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var checkOutPlaceButton: UIButton!
    
    // protocols
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "locationSegue" {
            let destination = segue.destination as! SelectedLocationView
            destination.chosenLocationName = chosenLocation
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let pinAnnotation = view.annotation as? PinAnnotation
        
        if pinAnnotation?.title != nil {
            chosenLocation = (pinAnnotation?.title)!
            
            checkOutPlaceButton.isHidden = false
            
            checkOutPlaceButton.setTitle("Check the " + selectedCategory + " : " + (pinAnnotation?.title)!, for: .normal)
            checkOutPlaceButton.subtitleLabel?.text = "0 Personnes"
            
            if selectedCategory == "Coffee" {
                checkOutPlaceButton.setImage(UIImage(named: "icon-cofee"), for: .normal)
            } else {
                checkOutPlaceButton.setImage(UIImage(named: "icon-map"), for: .normal)
            }
            
        }
    }
    
    internal func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
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
    
    internal func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? PinAnnotation {
            mapView.removeAnnotation(annotation)
        }
    }
    
    // METHODS
    func setUsersClosestLocation(mLattitude: CLLocationDegrees, mLongitude: CLLocationDegrees) -> String {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: mLattitude, longitude: mLongitude)
        
        print("User location")
        print(location)
        
        geoCoder.reverseGeocodeLocation(location) {
            (placemarks, error) -> Void in
            
            /*if let mPlacemark = placemarks{
                if let dict = mPlacemark[0].addressDictionary as? [String: Any]{
                    if (dict["Name"] as? String) != nil{
                        if (dict["City"] as? String) != nil{
                            //self.currentLocationStr = Name + ", " + City
                        }
                    }
                }
            }*/
        }
        return "Current location"
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error - locationManager: \(error.localizedDescription)")
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
    
 
    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkOutPlaceButton.isHidden = true
        ModalTransitionMediator.instance.setListener(listener: self)
        setupMap()
    }
    
    func popoverDismissed() {
        if UserDefaults.standard.string(forKey: "selectedCat") != nil {
            selectedCategory = UserDefaults.standard.string(forKey: "selectedCat")!
            print(selectedCategory)
            initializeLocations()
        }
    }
    
    // methods
    func setupMap() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SocialView.handleTap(gestureRecognizer:)))
        self.mapView.addGestureRecognizer(tapGesture)
    }
    
    func initializeLocations() {
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = selectedCategory
        
        let search = MKLocalSearch(request: request)
        search.start{(response, error) in
            if let response = response {
                var pinAnnotations : [PinAnnotation] = []
                
                var findTheFirstLocation = true
                
                for mapItem in response.mapItems {
                    
                    if findTheFirstLocation {
                        
                        print ("------ Checking out here --------")
                        print(mapItem)
                        
                        let enregistrement = Enregistrement(lieu: mapItem.name!)
                        EnregistrementViewModel.sharedInstance.ajouter(enregistrement: enregistrement) { success in
                            if success {
                                print ("---------------------------------")
                                print("location saved")
                            } else {
                                print ("---------------------------------")
                                print("location failed to save")
                            }
                        }
                        
                        print ("---------------------------------")
                        
                        findTheFirstLocation = false
                    }
                    
                    let pinAnnotation = PinAnnotation()
                    pinAnnotation.setCoordinate(newCoordinate: CLLocationCoordinate2DMake((mapItem.placemark.location?.coordinate.latitude)!, (mapItem.placemark.location?.coordinate.longitude)!))
                    pinAnnotation.title = mapItem.name
                    pinAnnotation.id = "parking._id"
                    
                    pinAnnotations.append(pinAnnotation)
                }
                
                self.determineCurrentLocation()
                self.mapView.addAnnotations(pinAnnotations)
            }
        }
    }
    
    func determineCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    @objc func handleTap(gestureRecognizer: UITapGestureRecognizer){
        
        if gestureRecognizer.state != UITapGestureRecognizer.State.began{
            //mapView.removeAnnotation(myPin)
            checkOutPlaceButton.isHidden = true
        }
    }
    
    @IBAction func checkOutPlace(_ sender: Any) {
        self.performSegue(withIdentifier: "locationSegue", sender: chosenLocation)
    }
}
