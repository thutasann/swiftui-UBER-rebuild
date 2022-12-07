//
//  UberMapViewRepresentable.swift
//  swiftui-uber-rebuild
//
//  Created by Thuta sann on 12/6/22.
//

// UIViewRepresentable -> From UIKIT

import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable {
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    @EnvironmentObject var locationViewModel : LocationSearchViewModel
    
    // MARK: - makeUIView
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator // Map coordinators
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    // MARK: - update map UI View
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let coordinate = locationViewModel.selectedLocationCoordinate{
            print("DEBUG: Selected Coordinate in Map View is \(coordinate)")
        }
    }
      
    // MARK: - makeCoordinator
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}


// MARK: - Extension
extension UberMapViewRepresentable {
    
    // MapCoordinator
    class MapCoordinator: NSObject, MKMapViewDelegate{
        
        let parent: UberMapViewRepresentable
        
        init(parent: UberMapViewRepresentable){
            self.parent = parent
            super.init()
        }
        
        // Did Update
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,
                                               longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            parent.mapView.setRegion(region, animated: true)
        }
        
    }
    
}
