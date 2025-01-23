//
//  HomeView.swift
//  Uber
//
//  Created by Muhammed Nadeem M A on 10/01/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var mapState: MapViewState = .noInput
    @EnvironmentObject private var viewModel: LocationSearchViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                
                //MAP
                MapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                
                //LOCATION SEARCH
                if mapState == .searchingForLocation{
                    LocationSearchView(mapState: $mapState)
                }else if mapState == .noInput{
                    locationSeachView
                }
                
                MapviewActionButtonView(mapState: $mapState)
                    .padding(.leading, 20)
                
            }
            
            if mapState == .locationSelected {
                RideRequestView()
                    .transition(.move(edge: .bottom))
            }
            
        }
        .ignoresSafeArea(edges: .bottom)
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location = location{
                viewModel.userLocation = location
            }
        }
    }
}

extension HomeView{
    
    private var locationSeachView: some View{
        LocationSearchActivationView()
            .padding(.top, 72)
            .onTapGesture {
                withAnimation {
                    mapState = .searchingForLocation
                }
            }
    }
    
}

#Preview {
    HomeView()
        .environmentObject(LocationSearchViewModel())
}
