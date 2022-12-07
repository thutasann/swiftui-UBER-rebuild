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
            context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
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
        
        // Initializaton
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
        
        // MARK: - Helpers
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D){
            parent.mapView.removeAnnotations(parent.mapView.annotations) // remove annotation if new
            
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
            
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
    }
    
}
