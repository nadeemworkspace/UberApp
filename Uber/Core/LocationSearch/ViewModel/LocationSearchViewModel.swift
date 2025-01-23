//
//  LocationSearchViewModel.swift
//  Uber
//
//  Created by Muhammed Nadeem M A on 15/01/25.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    
    @Published var results: [MKLocalSearchCompletion] = []
    @Published var selectedLocationCoordinate: CLLocationCoordinate2D? //Destination
    
    private let searchCompleter = MKLocalSearchCompleter()
    var searchQuery: String = ""{
        didSet{
            searchCompleter.queryFragment = searchQuery
        }
    }
    var userLocation: CLLocationCoordinate2D? //User coordinate
    
    override init() {
        super.init()
        self.searchCompleter.delegate = self
        self.searchCompleter.queryFragment = searchQuery
    }
    
}

//MARK: HELPER
extension LocationSearchViewModel{
    
    public func updateLocations(_ localSearch: MKLocalSearchCompletion){
        self.locationSearch(localSearch) { [weak self] response, error in
            guard let self = self else { return }
            
            if let error = error{
                print(error.localizedDescription)
                return
            }
            
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            print("DEBUG: Coordinate \(coordinate)")
            self.selectedLocationCoordinate = coordinate
        }
    }
    
    private func locationSearch(_ localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler){
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
    }
    
    func computeRidePrice(for type: RideType) -> Double{
        guard let destinationCoordinate = selectedLocationCoordinate else { return 0.0 }
        guard let currentCoordinate = userLocation else { return 0.0 }
        let userLocation = CLLocation(latitude: currentCoordinate.latitude, longitude: currentCoordinate.longitude)
        let destination = CLLocation(latitude: destinationCoordinate.latitude, longitude: destinationCoordinate.longitude)
        let tripDistanceInMeters = userLocation.distance(from: destination)
        return type.computePrice(distance: tripDistanceInMeters)
    }
    
}

//MARK: MKLocalSearchCompleterDelegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        results = completer.results
    }
    
}
