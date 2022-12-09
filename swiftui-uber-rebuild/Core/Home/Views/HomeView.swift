//
//  HomeView.swift
//  swiftui-uber-rebuild
//
//  Created by Thuta sann on 12/6/22.
//

import SwiftUI

struct HomeView: View {
    
    @State private var mapState = MapViewState.noInput
    
    var body: some View {
        
        ZStack (alignment: .bottom) {
            
            // MARK: - HOME SCREEN VIEW
            ZStack (alignment: .top) {
                UberMapViewRepresentable(mapState: $mapState)
                    .ignoresSafeArea()
                
                // Search bar
                if mapState == .searchingForLocation {
                    LocationSearchView(mapState: $mapState) // Location List Screen
                }
                else if mapState == .noInput{
                    LocationSearchActivationView() //Home Screen Search Bar
                        .padding(.top, 72)
                        .onTapGesture {
                            withAnimation(.spring()){
                                mapState = .searchingForLocation
                            }
                        }
                }
                
                // Floating Button
                MapViewActionButton(mapState: $mapState)
                    .padding(.leading)
                    .padding(.top, 4)
            }
            
            // MARK: - RIDE REQUEST VIEW
            if mapState == .locationSelected{
                RideRequestView()
                    .transition(.move(edge: .bottom))
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
