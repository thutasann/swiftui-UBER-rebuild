//
//  swiftui_uber_rebuildApp.swift
//  swiftui-uber-rebuild
//
//  Created by Thuta sann on 12/6/22.
//

import SwiftUI

@main
struct swiftui_uber_rebuildApp: App {
    
    @StateObject var locationViewModel = LocationSearchViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(locationViewModel)
        }
    }
}
