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
    @Published var selectedLocation: String?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var searchQuery: String = ""{
        didSet{
            searchCompleter.queryFragment = searchQuery
        }
    }
    
    override init() {
        super.init()
        self.searchCompleter.delegate = self
        self.searchCompleter.queryFragment = searchQuery
    }
    
}

extension LocationSearchViewModel{
    
    public func updateLocations(_ location: String){
        self.selectedLocation = location
    }
    
}

//MARK: MKLocalSearchCompleterDelegate
extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        results = completer.results
    }
    
}
