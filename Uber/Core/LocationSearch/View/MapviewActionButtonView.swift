//
//  MapviewActionButtonView.swift
//  Uber
//
//  Created by Muhammed Nadeem M A on 14/01/25.
//

import SwiftUI

struct MapviewActionButtonView: View {
    
    @Binding var mapState: MapViewState
    
    var body: some View {
        Button {
            withAnimation {
                setMapState(mapState)
            }
        } label: {
            Image(systemName: getActionButtonImage(mapState))
                .font(.title2)
                .scaledToFit()
                .frame(width: 18, height: 18)
                .foregroundStyle(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.3), radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)

    }
}

extension MapviewActionButtonView {
    
    func setMapState(_ state: MapViewState){
        switch state{
        case .noInput:
            print("No input")
        case .searchingForLocation:
            mapState = .noInput
        case .locationSelected:
            mapState = .noInput
        }
    }
    
    func getActionButtonImage(_ mapstate: MapViewState) -> String{
        switch mapstate{
        case .noInput:
            return "line.3.horizontal"
        case .locationSelected, .searchingForLocation:
            return "arrow.left"
        }
    }
    
}

#Preview {
    MapviewActionButtonView(mapState: .constant(.noInput))
}
