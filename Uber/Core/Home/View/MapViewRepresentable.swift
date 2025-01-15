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
    private let locationManager = LocationManager()
    @EnvironmentObject var viewModel: LocationSearchViewModel

    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let selectedLocation = viewModel.selectedLocation{
            print("Selected location from search is \(selectedLocation)")
        }
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(parent: self)
    }
    
}

//MARK: MAP COORDINATOR
extension MapViewRepresentable {
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate{
        
        let parent: MapViewRepresentable
        
        init(parent: MapViewRepresentable) {
            self.parent = parent
            super.init()
        }

        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,
                                                                           longitude: userLocation.coordinate.longitude),
                                            span: MKCoordinateSpan(latitudeDelta: 0.05,
                                                                   longitudeDelta: 0.05))
            parent.mapView.setRegion(region, animated: true)
        }
        
    }
    
}

#Preview{
    MapViewRepresentable()
        .ignoresSafeArea()
        .environmentObject(LocationSearchViewModel())
}
