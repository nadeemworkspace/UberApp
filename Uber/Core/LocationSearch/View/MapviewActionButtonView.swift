//
//  MapviewActionButtonView.swift
//  Uber
//
//  Created by Muhammed Nadeem M A on 14/01/25.
//

import SwiftUI

struct MapviewActionButtonView: View {
    
    @Binding var showSearchView: Bool
    
    var body: some View {
        Button {
            withAnimation {
                showSearchView.toggle()
            }
        } label: {
            Image(systemName: showSearchView ? "arrow.left" : "line.3.horizontal")
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

#Preview {
    MapviewActionButtonView(showSearchView: .constant(false))
}
