//
//  AdminView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/10/2022.
//

import SwiftUI

struct AdminView: View {
    @EnvironmentObject var router: NavigationRouter
    let firebaseAuth = FirebaseAuthentication.shared

    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        Button("Log Out") {
            firebaseAuth.logOutUser { error in
                if error == nil {
                    router.infoPath.removeLast()
                }
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

    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
