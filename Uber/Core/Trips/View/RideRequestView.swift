//
//  RideRequestView.swift
//  Uber
//
//  Created by Muhammed Nadeem M A on 22/01/25.
//

import SwiftUI

struct RideRequestView: View {
    
    @State private var selectedRide: RideType = .uberX
    @EnvironmentObject private var viewModel: LocationSearchViewModel
    
    var body: some View {
        VStack{
            
            capsule
            
            //Location description
            rideFromAndToLocationView
            
            Divider()
            
            //Suggested Rides
            suggestRidesView
            
            //Ride Options
            rideOptionsView
            
            Divider()
                .padding(.vertical, 8)
            
            //Payment option
            paymentOptionView
            
            //Request ride button
            rideRequestButton
            
        }
        .padding(.bottom, 30)
        .background(.white)
        .clipShape(.rect(cornerRadius: 20))
    }
}

extension RideRequestView {
    
    private var capsule: some View{
        return             Capsule()
            .foregroundStyle(Color(.systemGray5))
            .frame(width: 48, height: 6)
            .padding(.top, 8)
    }
    
    private var rideFromAndToLocationView: some View{
        return HStack{
            
            VStack{
                Circle()
                    .fill(Color(.systemGray3))
                    .frame(width: 8, height: 8)
                
                Rectangle()
                    .fill(Color(.systemGray3))
                    .frame(width: 1, height: 32)
                
                Rectangle()
                    .fill(.primary)
                    .frame(width: 8, height: 8)
            }
            
            VStack(alignment: .leading, spacing: 24){
                //Current Location
                HStack{
                    Text("Current Location")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.gray)
                    
                    Spacer()
                    
                    Text("12:23 PM")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.gray)
                }
                .padding(.bottom, 12)
                
                //Destination
                HStack{
                    Text("Phillz Coffee")
                        .font(.system(size: 16, weight: .semibold))
                    
                    Spacer()
                    
                    Text("12:45 PM")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.gray)
                }
            }
            .padding(.leading, 8)
            
        }
        .padding()
    }
    
    private var suggestRidesView: some View{
        return Text("SUGGESTED RIDES")
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding()
            .foregroundStyle(.gray)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var rideOptionsView: some View{
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12){
                ForEach(RideType.allCases) { ride in
                    VStack(alignment: .leading){
                        Image(ride.image)
                            .resizable()
                            .scaledToFit()
                        
                        VStack(alignment: .leading, spacing: 4){
                            Text(ride.description)
                                .font(.system(size: 14, weight: .semibold))
                            
                            Text("$\(viewModel.computeRidePrice(for: ride).convertToCurrency())")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .padding()
                        
                    }
                    .frame(width: 112, height: 140)
                    .background(Color(selectedRide == ride ? .systemBlue : .systemGroupedBackground))
                    .foregroundStyle(selectedRide == ride ? .white : .black)
                    .scaleEffect(selectedRide == ride ? 1.15 : 1.0)
                    .clipShape(.rect(cornerRadius: 10))
                    .onTapGesture {
                        withAnimation(.spring){
                            selectedRide = ride
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    private var paymentOptionView: some View{
        return             HStack(spacing: 12){
            
            Text("Visa")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(6)
                .background(.blue)
                .clipShape(.rect(cornerRadius: 4))
                .foregroundStyle(.white)
                .padding(.leading)
            
            Text("**** 1234")
                .fontWeight(.semibold)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .imageScale(.medium)
                .padding()
            
        }
        .frame(height: 55)
        .background(Color(.systemGroupedBackground))
        .clipShape(.rect(cornerRadius: 10))
        .padding(.horizontal)
    }
    
    private var rideRequestButton: some View{
        return             Button {
            print("Confirming your ride")
        } label: {
            Text("Confirm Ride".uppercased())
                .fontWeight(.bold)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 10))
                .padding(.horizontal)
                .padding(.top, 5)
        }
    }
    
}

struct RideRequestView_Preview: PreviewProvider{
    static var previews: some View{
        RideRequestView()
            .environmentObject(LocationSearchViewModel())
            .previewLayout(.sizeThatFits)
//            .preferredColorScheme(.dark)
    }
}
