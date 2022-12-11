//
//  RideRequestView.swift
//  swiftui-uber-rebuild
//
//  Created by Thuta sann on 12/9/22.
//

import SwiftUI

struct RideRequestView: View {
    
    @State private var selectedRideType: RideType = .uberX
    @EnvironmentObject var locationViewModel : LocationSearchViewModel
    
    var body: some View {
        VStack{
            
            // MARK: - Drag Icon
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            
            // MARK: - Trip Info View
            HStack{
                
                // Circle Icons
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 8, height: 8)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width: 8, height: 8)
                }
                
                // Locations Texts
                VStack (alignment: .leading, spacing: 17){
                    HStack{
                        Text("Current Location")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Text(locationViewModel.pickupTime ?? "")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 10)
                    HStack{
                        
                        if let location = locationViewModel.selectedUberLocaton{
                            Text(location.title)
                                .font(.system(size: 16, weight: .semibold))
                        }
                        
                        Spacer()
                        
                        Text(locationViewModel.dropOffTime ?? "")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                }
                .padding(.leading, 8)
            }
            .padding()
            
            Divider()
            
            // MARK: - Ride Type Selection View
            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal){
                HStack(spacing: 12){
                    ForEach(RideType.allCases) { type in // `RideType` model
                        VStack(alignment: .leading){
                            Image(type.imageName)
                                .resizable()
                                .scaledToFit()
                            
                            VStack(alignment: .leading, spacing: 4){
                                Text(type.description)
                                    .font(.system(size: 14, weight: .semibold))
                                
                                Text(locationViewModel.computeRidePrice(forType: type).toCurrency())
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .padding()
                        }
                        .frame(width: 112, height: 140)
                        .foregroundColor(type == selectedRideType ? .white : .Color.theme.primaryTextColor)
                        .background(Color(type == selectedRideType ? .systemBlue : .systemGroupedBackground))
                        .background(type == selectedRideType ? .blue : Color.theme.secondaryBackgroundColor)
                        .scaleEffect(type == selectedRideType ? 1.2 : 1.0)
                        .cornerRadius(10)
                        .onTapGesture {
                            withAnimation(.spring()){
                                selectedRideType = type
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            Divider()
                .padding(.vertical, 8)
        
            
            // MARK: - Payment Option View
            HStack(spacing: 12){
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(.blue)
                    .cornerRadius(4)
                    .foregroundColor(.white)
                    .padding(.leading)
                
                Text("**** 1234")
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .frame(height: 50)
            .background(Color.theme.secondaryBackgroundColor)
            .cornerRadius(10)
            .padding(.horizontal)
            
            
            // MARK: - Request Ride Button
            Button{
                
            }label: {
                Text("CONFIRM RIDE")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            }
        }
        .padding(.bottom, 24)
        .background(Color.theme.backgroundColor)
        .cornerRadius(24)
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
