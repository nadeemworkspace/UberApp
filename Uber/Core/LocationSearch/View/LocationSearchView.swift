//
//  LocationSearchView.swift
//  Uber
//
//  Created by Muhammed Nadeem M A on 14/01/25.
//

import SwiftUI

struct LocationSearchView: View {
    
    @State private var currentLocationTextFieldText: String = ""
    @EnvironmentObject private var viewModel: LocationSearchViewModel
    @Binding var mapState: MapViewState
    
    var body: some View {
        VStack{
            
            //HEADER
            HStack{
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    
                    Rectangle()
                        .fill(.primary)
                        .frame(width: 6, height: 6)
                }
                
                VStack{
                    TextField("Current location", text: $currentLocationTextFieldText)
                        .padding(.leading, 10)
                        .frame(height: 32)
                        .background(Color(.systemGroupedBackground))
                        .tint(.black)
                    
                    TextField("Where to?", text: $viewModel.searchQuery)
                        .padding(.leading, 10)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .tint(.black)
                }
                .padding(.leading, 10)
            }
            .padding(.horizontal)
            .padding(.top, 72)
            
            Divider()
                .padding(.vertical)
            
            ScrollView(.vertical){
                ForEach(viewModel.results, id: \.self) { result in
                    LocationSearchResultCell(title: result.title, subtitle: result.subtitle)
                        .onTapGesture {
                            withAnimation{
                                viewModel.updateLocations(result)
                                mapState = .locationSelected
                            }
                        }
                }
            }
            .scrollIndicators(.hidden)
        }
        .background(Color(.systemBackground))
    }
}

struct LocationSearchView_Preview: PreviewProvider{
    static var previews: some View{
        LocationSearchView(mapState: .constant(.searchingForLocation))
            .previewLayout(.sizeThatFits)
            .padding()
            .environmentObject(LocationSearchViewModel())
    }
}
