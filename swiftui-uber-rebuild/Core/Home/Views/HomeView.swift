//
//  HomeView.swift
//  swiftui-uber-rebuild
//
//  Created by Thuta sann on 12/6/22.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showLocationSearchView : Bool = false
    
    var body: some View {
        ZStack (alignment: .top) {
            UberMapViewRepresentable()
                .ignoresSafeArea()
            
            // Search bar
            if showLocationSearchView {
                LocationSearchView()
            } else{
                LocationSearchActivationView()
                    .padding(.top, 72)
                    .onTapGesture {
                        withAnimation(.spring()){
                            showLocationSearchView.toggle()
                        }
                    }
            }
            
            // Floating Button
            MapViewActionButton(showLocationSearchView: $showLocationSearchView)
                .padding(.leading)
                .padding(.top, 4)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
