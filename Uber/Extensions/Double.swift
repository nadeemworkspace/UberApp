//
//  Double.swift
//  Uber
//
//  Created by Muhammed Nadeem M A on 23/01/25.
//

import Foundation

extension Double {
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func convertToCurrency() -> String{
        return currencyFormatter.string(for: self) ?? "0.0"
    }
    
}
