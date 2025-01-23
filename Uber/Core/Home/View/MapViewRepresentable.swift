//
//  MapViewRepresentable.swift
//  Uber
//
//  Created by Muhammed Nadeem M A on 10/01/25.
//

import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewRepresentable{
    
    let mapView = MKMapView()
    private let locationManager = LocationManager.shared
    @EnvironmentObject var viewModel: LocationSearchViewModel
    @Binding var mapState: MapViewState

    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        print("Current Mapstate: ", mapState)
        switch mapState {
        case .noInput:
            context.coordinator.clearAndResetMapView()
            break
        case .searchingForLocation:
            break
        case .locationSelected:
            if let destinationCoordinate = viewModel.selectedLocationCoordinate{
                context.coordinator.addAndSelectAnnotations(withCoordinate: destinationCoordinate)
                context.coordinator.configurePolyLine(destinationCoordinate: destinationCoordinate)
            }
            break
        }
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(parent: self)
    }
    
}

//MARK: - MAP COORDINATOR
extension MapViewRepresentable {
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate{
        
        private let parent: MapViewRepresentable
        private var userLocationCoordinate: CLLocationCoordinate2D?
        private var userRegion: MKCoordinateRegion?
        
        init(parent: MapViewRepresentable) {
            self.parent = parent
            super.init()
        }

        //MARK: - MAPVIEW DELEGATE
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,
                                                                           longitude: userLocation.coordinate.longitude),
                                            span: MKCoordinateSpan(latitudeDelta: 0.05,
                                                                   longitudeDelta: 0.05))
            
            self.userRegion = region
            parent.mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
        }
        
        //MARK: - HELPER
        //Map destination annotation 📍
        func addAndSelectAnnotations(withCoordinate coordinate: CLLocationCoordinate2D){
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            parent.mapView.addAnnotation(annotation)
            parent.mapView.selectAnnotation(annotation, animated: true)
        }
        
        //Polyline 📍---------📍
        func configurePolyLine(destinationCoordinate: CLLocationCoordinate2D){
            guard let userLocationCoordinate else { return }
            self.getDestinationRoute(userLocation: userLocationCoordinate, destination: destinationCoordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                //Pan mapview when showing RideRequestView()
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 64, left: 32, bottom: 520, right: 32))
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
        
        //Get destination route
        func getDestinationRoute(userLocation: CLLocationCoordinate2D, destination: CLLocationCoordinate2D, completion: @escaping (MKRoute) -> Void){
            let userLocation = MKPlacemark(coordinate: userLocation)
            let destination = MKPlacemark(coordinate: destination)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userLocation)
            request.destination = MKMapItem(placemark: destination)
            let directions = MKDirections(request: request)
            directions.calculate { response, error in
                if let error{
                    print("DEBUG: \(error.localizedDescription)")
                    return
                }
                guard let route = response?.routes.first else { return }
                completion(route)
            }
        }
        
        func clearAndResetMapView(recenter: Bool = true) {
            DispatchQueue.main.async {
                self.parent.mapView.removeAnnotations(self.parent.mapView.annotations)
                self.parent.mapView.removeOverlays(self.parent.mapView.overlays)
                if let region = self.userRegion, recenter {
                    self.parent.mapView.setRegion(region, animated: true)
                }
            }
        }
        
    }
    
}

#Preview{
    MapViewRepresentable(mapState: .constant(.noInput))
        .ignoresSafeArea()
        .environmentObject(LocationSearchViewModel())
}
