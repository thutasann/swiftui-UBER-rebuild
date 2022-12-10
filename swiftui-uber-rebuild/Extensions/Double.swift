//
//  Double.swift
//  swiftui-uber-rebuild
//
//  Created by Thuta sann on 12/10/22.
//

import Foundation

extension Double{
    
    // MARK: - Currency Formatter
    private var currencyFormatter: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    // MARK: - To Currency
    func toCurrency() -> String{
        return currencyFormatter.string(for: self) ?? ""
    }
    
}
