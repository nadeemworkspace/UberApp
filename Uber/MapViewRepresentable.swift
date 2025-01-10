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

    func makeUIView(context: Context) -> some UIView {
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
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

    }
    
}

