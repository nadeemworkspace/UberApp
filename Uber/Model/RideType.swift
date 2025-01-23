//
//  RideType.swift
//  Uber
//
//  Created by Muhammed Nadeem M A on 23/01/25.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable{
    case uberX
    case uberBlack
    case uberXL
    
    var id: Int{
        return rawValue
    }
    
    var description: String{
        switch self {
        case .uberX:
            return "Uber X"
        case .uberXL:
            return "Uber XL"
        case .uberBlack:
            return "Uber Black"
        }
    }
    
    var image: String{
        switch self {
        case .uberX, .uberXL:
            return "uber-x"
        case .uberBlack:
            return "uber-black"
        }
    }
    
    var baseFair: Double{
        switch self {
        case .uberX:
            return 5
        case .uberBlack:
            return 20
        case .uberXL:
            return 10
        }
    }
    
    func computePrice(distance: Double) -> Double{
        let distanceInMiles = distance / 1600
        switch self {
        case .uberX:
            return distanceInMiles * 1.5 + baseFair
        case .uberBlack:
            return distanceInMiles * 2.0 + baseFair
        case .uberXL:
            return distanceInMiles * 1.75 + baseFair
        }
    }
    
}
