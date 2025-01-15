//
//  HomeView.swift
//  Uber
//
//  Created by Muhammed Nadeem M A on 10/01/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showSearchView: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            
            //MAP
            MapViewRepresentable()
                .ignoresSafeArea()
            
            //LOCATION SEARCH
            if showSearchView{
                LocationSearchView(showSeachView: $showSearchView)
            }else{
                locationSeachView
            }
            
            MapviewActionButtonView(showSearchView: $showSearchView)
                .padding(.leading, 20)
            
        }
    }
}

extension HomeView{
    
    private var locationSeachView: some View{
        LocationSearchActivationView()
            .padding(.top, 72)
            .onTapGesture {
                withAnimation {
                    showSearchView.toggle()
                }
            }
    }
    
}

#Preview {
    HomeView()
}
