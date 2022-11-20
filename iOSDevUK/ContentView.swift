//
//  ContentView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var router = NavigationRouter()

    var body: some View {
        TabBarView()
            .environmentObject(router)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
