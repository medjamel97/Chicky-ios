//
//  PinAnnotation.swift
//  Chicky
//
//  Created by Jamel & Maher on 8/12/2021.
//

import Foundation
import MapKit

class PinAnnotation : NSObject, MKAnnotation {
    
    private var coord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    private var _id : String = String("")
    private var _title: String = String("")
    private var _subtitle: String = String("")
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return coord
        }
    }
    
    func setCoordinate(newCoordinate: CLLocationCoordinate2D) {
        self.coord = newCoordinate
    }
    
    var id: String? {
        get {
            return _id
        }
        set (value) {
            self._id = value!
        }
    }
    
    var title: String? {
        get {
            return _title
        }
        set (value) {
            self._title = value!
        }
    }
    
    var subtitle: String? {
        get {
            return _subtitle
        }
        set (value) {
            self._subtitle = value!
        }
    }
}
