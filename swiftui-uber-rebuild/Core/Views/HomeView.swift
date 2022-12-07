//
//  HomeView.swift
//  swiftui-uber-rebuild
//
//  Created by Thuta sann on 12/6/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        UberMapViewRepresentable()
            .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
