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
    @StateObject var baseViewModel = BaseViewModel()
    @StateObject var router = NavigationRouter()

    init() {
        FirebaseApp.configure()
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
