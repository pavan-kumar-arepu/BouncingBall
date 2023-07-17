//
//  ContentView.swift
//  Taj
//
//  Created by Pavankumar Arepu on 17/07/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("Taj")
                .resizable()
                .aspectRatio(contentMode: .fill)
            BouncingBallsView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
