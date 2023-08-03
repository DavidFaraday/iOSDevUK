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
        Button(AppStrings.logOut) {
            Task {
                await viewModel.logOutUser()
                router.infoPath.removeLast()
            }
        }
    }

    var body: some View {
        Form {
            NavigationLink(AppStrings.speakers, value: InfoDestination.adminSpeakers)
            NavigationLink(AppStrings.sessions, value: InfoDestination.adminSessions)
            NavigationLink(AppStrings.locations, value: InfoDestination.adminLocations)
            NavigationLink(AppStrings.sponsors, value: InfoDestination.adminSponsors)
        }
        .task(viewModel.uploadNewData)
        .navigationTitle(AppStrings.adminArea)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
        }
        .alert(isPresented: $viewModel.showError, content: {
            Alert(title: Text(AppStrings.error), message: Text(viewModel.logoutError?.localizedDescription ?? ""), dismissButton: .default(Text(AppStrings.ok)))
        })
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
