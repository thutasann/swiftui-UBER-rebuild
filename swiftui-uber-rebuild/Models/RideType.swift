//
//  RideType.swift
//  swiftui-uber-rebuild
//
//  Created by Thuta sann on 12/9/22.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable{
    case uberX
    case black
    case uberXL
    
    // ID
    var id: Int { return rawValue }
    
    // Description
    var description: String{
        switch self{
            case .uberX: return "UberX"
            case .black: return "UberBlack"
            case .uberXL: return "UberXL"
        }
    }
    
    // imageName
    var imageName: String{
        switch self{
            case .uberX: return "uber-x"
            case .black: return "uber-black"
            case .uberXL: return "uber-x"
        }
    }
    
    // Base Fare
    var baseFare: Double{
        switch self{
        case .uberX: return 5
        case .black: return 20
        case .uberXL: return 10
        }
    }
    
    // Compute Price
    func computePrice(for distanceMeters: Double) -> Double{
        let distanceMiles = distanceMeters / 1600
        
        switch self{
        case .uberX: return distanceMiles * 1.5 + baseFare
        case .black: return distanceMiles * 2.0 + baseFare
        case .uberXL: return distanceMiles * 1.75 + baseFare
        }
    }
    
    
}
