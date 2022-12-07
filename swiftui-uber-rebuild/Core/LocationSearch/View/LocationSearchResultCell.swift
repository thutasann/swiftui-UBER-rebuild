//
//  LocationSearchResultCell.swift
//  swiftui-uber-rebuild
//
//  Created by Thuta sann on 12/7/22.
//

import SwiftUI

struct LocationSearchResultCell: View {
    var body: some View {
        HStack{
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .accentColor(.white)
                .frame(width: 40, height: 40)
            
            VStack (alignment: .leading, spacing: 4){
                Text("Starbucks Coffee")
                    .font(.body)
                Text("122 Main St. NewYork, USA")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                Divider()
            }
            .padding(.leading, 8)
            .padding(.vertical, 8)
        }
        .padding(.leading)
    }
}

struct LocationSearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchResultCell()
    }
}