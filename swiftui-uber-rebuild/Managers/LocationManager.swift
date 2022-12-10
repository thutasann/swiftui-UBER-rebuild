//
//  LocationManager.swift
//  swiftui-uber-rebuild
//
//  Created by Thuta sann on 12/6/22.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject{
    
    private let locationManager = CLLocationManager()
    static let shared = LocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    
    override init(){
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization() // requestion location  permissions
        locationManager.startUpdatingLocation()
        
    }
    
}


// MARK: - Extension
extension LocationManager : CLLocationManagerDelegate{
    
    // did Update Locations
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.userLocation = location.coordinate
        locationManager.stopUpdatingLocation()
    }
    
}
