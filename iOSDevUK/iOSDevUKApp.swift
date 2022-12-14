//
//  iOSDevUKApp.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI
import Firebase
import FirebaseDatabase

@main
struct iOSDevUKApp: App {
    @StateObject var dataController = DataController()
    @StateObject var baseViewModel = BaseViewModel()
    @StateObject var router = NavigationRouter()

    init() {
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
    }
    
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(router)
                .environmentObject(baseViewModel)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
