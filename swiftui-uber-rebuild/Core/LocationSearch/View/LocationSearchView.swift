//
//  LocationSearchView.swift
//  swiftui-uber-rebuild
//
//  Created by Thuta sann on 12/7/22.
//

import SwiftUI

struct LocationSearchView: View {
    
    @State private var startLocationText = ""
    @Binding var mapState: MapViewState
    @EnvironmentObject var viewModel : LocationSearchViewModel
    
    var body: some View {
        VStack{
            // Header View
            HStack{
                
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    Rectangle()
                        .fill(.black)
                        .frame(width: 6, height: 6)
                }
                
                VStack{
                  
                    TextField("Current Location", text: $startLocationText)
                        .frame(height: 32)
                        .background(Color(.systemGroupedBackground))
                        .padding(.trailing)
                        .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                    
                    TextField("Where to", text: $viewModel.queryFragment)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                        .autocapitalization(.none)
                        .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))

                }
            }
            .padding(.horizontal)
            .padding(.top, 64)
            
            Divider()
                .padding(.vertical)

            // List View
            ScrollView{
                VStack(alignment: .leading){
                    ForEach(viewModel.results, id: \.self) { result in
                        LocationSearchResultCell(title: result.title, subtitle: result.subtitle)
                            .onTapGesture {
                                withAnimation(.spring()){
                                    viewModel.selectLocatiaon(result)
                                    mapState = .locationSelected
                                }
                            }
                    }
                }
            }
        }
        .background(Color.theme.backgroundColor)
        .background(.white)
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(mapState: .constant(.searchingForLocation))
    }
}
