//
//  MapViewActionButton.swift
//  swiftui-uber-rebuild
//
//  Created by Thuta sann on 12/7/22.
//

import SwiftUI

struct MapViewActionButton: View {
    
    @Binding var showLocationSearchView : Bool
    
    
    var body: some View {
        Button{
            withAnimation(.spring()){
                showLocationSearchView.toggle()
            }
        } label: {
            Image(systemName: showLocationSearchView ? "arrow.left": "line.3.horizontal")
                .font(.title2)
                .foregroundColor(Color.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(showLocationSearchView: .constant(true))
    }
}
