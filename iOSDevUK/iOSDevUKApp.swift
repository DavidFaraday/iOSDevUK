//
//  iOSDevUKApp.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI
import Firebase

@main
struct iOSDevUKApp: App {
    
    init() {
        FirebaseApp.configure()
    }
        
    @State private var router = NavigationRouter()
    @State private var baseViewModel = BaseViewModel()

    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(router)
                .environmentObject(baseViewModel)
                .environmentObject(LocationService.shared)
        }
    }
}
