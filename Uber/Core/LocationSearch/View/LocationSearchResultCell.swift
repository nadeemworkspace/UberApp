//
//  LocationSearchResultCell.swift
//  Uber
//
//  Created by Muhammed Nadeem M A on 15/01/25.
//

import SwiftUI

struct LocationSearchResultCell: View {
    
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack{
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundStyle(.blue)
                .tint(.white)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 4){
                
                Text(title)
                    .font(.body)
                    .lineLimit(1)
                
                Text(subtitle)
                    .font(.system(size: 15))
                    .foregroundStyle(.gray)
                    .lineLimit(2)
                
                Divider()
            }
            .padding(.leading, 8)
            .padding(.vertical, 8)
            
        }
        .padding(.leading)
    }
}

struct LocationSearchResultCell_Preview: PreviewProvider{
    static var previews: some View{
        LocationSearchResultCell(title: "Lulu Exchange", subtitle: "Lulu Mall")
            .previewLayout(.sizeThatFits)
    }
}
