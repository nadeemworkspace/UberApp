//
//  LocationSearchActivationView.swift
//  Uber
//
//  Created by Muhammed Nadeem M A on 14/01/25.
//

import SwiftUI

struct LocationSearchActivationView: View {
    
    var body: some View {
        HStack{
            Rectangle()
                .fill(.black)
                .frame(width: 6, height: 6)
                .padding(.horizontal)
            
            Text("Where to?")
                .font(.callout)
                .foregroundStyle(Color(.darkGray))
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 50, height: 50)
        .background(
            Rectangle()
                .fill(.white)
                .shadow(color: .black.opacity(0.3), radius: 6)
        )
        
    }
}

struct LocationSearchActivationView_Preview: PreviewProvider{
    static var previews: some View{
        LocationSearchActivationView()
            .padding()
            .previewLayout(.sizeThatFits)
            
    }
}
