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
}
