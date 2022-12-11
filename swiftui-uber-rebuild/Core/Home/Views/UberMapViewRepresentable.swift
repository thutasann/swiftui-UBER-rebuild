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
    let locationManager = LocationManager.shared
    @Binding var mapState: MapViewState
    @EnvironmentObject var locationViewModel : LocationSearchViewModel
    
    // MARK: - makeUIView
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator // Map coordinators
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    // MARK: - UPDATE MAP UI VIEW
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("DEBUG: Map State is \(mapState)")
        
        switch mapState {
            case .noInput:
                context.coordinator.clearMapViewAndRecenterOnUserLocation()
                break
            case .searchingForLocation:
                break
            case .locationSelected:
                if let coordinate = locationViewModel.selectedUberLocaton?.coordinate{
                    print("DEBUG: Coordinate is \(coordinate)")
                    context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                    context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
                }
        }
    
    }
      
    // MARK: - makeCoordinator
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}


// MARK: - Extension
extension UberMapViewRepresentable {

    class MapCoordinator: NSObject, MKMapViewDelegate{
        
        // MARK: - Properties
        let parent: UberMapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion? // To re-center the Map
        
        init(parent: UberMapViewRepresentable){
            self.parent = parent
            super.init()
        }
        
        // MARK: - MKMapViewDelegate
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,
                                               longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            self.currentRegion = region
            parent.mapView.setRegion(region, animated: true)
        }
        
        // MARK: - Render For Delegate
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
        }
        
        // MARK: - Add And Select Annotation (Helper Func)
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D){
            parent.mapView.removeAnnotations(parent.mapView.annotations) // remove annotation if new
            
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
            
            // parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        // MARK: - Configure PolyLine (Helper Func)
        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D){
            
            guard let userLocationCoordinate = self.userLocationCoordinate else { return }
            
            getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                
                // adjust the size with RideRequest View
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
        
        // MARK: - Get Destination Route (Helper Func)
        func getDestinationRoute(from userLocation: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void){
            
            // placemarks
            let userPlacemark = MKPlacemark(coordinate: userLocation)
            let destPlacemark = MKPlacemark(coordinate: destination)
            
            // source/destination requests
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlacemark)
            request.destination = MKMapItem(placemark: destPlacemark)
            
            // direction calculation
            let direction = MKDirections(request: request)
            direction.calculate { response, error in
                if let error = error {
                    print("DEBUG: Failed to get directoins with error \(error.localizedDescription)")
                    return
                }
                guard let route = response?.routes.first else { return }
                completion(route)
            }
        }
        
        // MARK: - Clear Map View and Recenter on User Location (Helper Func)
        func clearMapViewAndRecenterOnUserLocation(){
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            
            if let currentRegion = currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true)
            }
        }
         
    }
    
}
