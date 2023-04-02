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
    @StateObject var dataController = DataController()
    
    init() {
        FirebaseApp.configure()
    }
    
    let weather = WeatherViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(NavigationRouter())
                .environmentObject(BaseViewModel())
                .environmentObject(LocationService.shared)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
