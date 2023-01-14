//
//  AdminView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/10/2022.
//

import SwiftUI

struct AdminView: View {
    @EnvironmentObject var router: NavigationRouter

    @StateObject private var viewModel = AdminViewModel()
    
    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        Button("Log Out") {
            Task {
                await viewModel.logOutUser()
                router.infoPath.removeLast()
            }
        }
    }

    var body: some View {
        Form {
            NavigationLink("Speakers", value: InfoDestination.adminSpeakers)
            NavigationLink("Sessions", value: InfoDestination.adminSessions)
            NavigationLink("Locations", value: InfoDestination.adminLocations)
            NavigationLink("Sponsors", value: InfoDestination.adminSponsors)
        }
        .navigationTitle("Admin Area")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
        }
        .alert(isPresented: $viewModel.showError, content: {
            Alert(title: Text("Error!"), message: Text(viewModel.logoutError?.localizedDescription ?? ""), dismissButton: .default(Text("OK")))
        })
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
