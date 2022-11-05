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
    let dataController = DataController()
    let baseViewModel = BaseViewModel()

    init() {
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true

    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(baseViewModel)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
