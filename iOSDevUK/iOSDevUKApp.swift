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
        
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(NavigationRouter())
                .environmentObject(BaseViewModel())
                .environmentObject(LocationService.shared)
        }
    }
}
