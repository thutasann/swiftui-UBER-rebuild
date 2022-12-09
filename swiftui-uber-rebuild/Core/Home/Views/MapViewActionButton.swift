//
//  MapViewActionButton.swift
//  swiftui-uber-rebuild
//
//  Created by Thuta sann on 12/7/22.
//

import SwiftUI
import MapKit

struct MapViewActionButton: View {
    
    @Binding var mapState : MapViewState
    
    // MARK: - Button Body
    var body: some View {
        Button{
            withAnimation(.spring()){
                actionForState(mapState)
            }
        } label: {
            Image(systemName: imageNameForState(mapState))
                .font(.title2)
                .foregroundColor(Color.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - Action For state
    func actionForState(_ state: MapViewState){
        switch state {
            case .noInput:
                print("DEBUG: No Input")
            case .searchingForLocation :
                mapState = .noInput
            case .locationSelected:
            mapState = .noInput
        }
    }
    
    // MARK: - Button Icon For state
    func imageNameForState(_ state: MapViewState) -> String{
        switch state {
            case .noInput:
                return "line.3.horizontal"
            case .searchingForLocation, .locationSelected:
                return "arrow.left"
        }
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(mapState: .constant(.noInput ))
    }
}
