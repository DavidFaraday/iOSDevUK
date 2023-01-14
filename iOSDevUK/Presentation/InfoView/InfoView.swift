//
//  InfoView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct InfoView: View {
    @EnvironmentObject var router: NavigationRouter
    let firebaseAuth = FirebaseAuthentication.shared
    
    let loggedIn = true
    
    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        NavigationLink("Admin", value: firebaseAuth.hasCurrentUser ? InfoDestination.admin : InfoDestination.loginView)
    }
    
    
    var body: some View {
        NavigationStack(path: $router.infoPath) {
            Form {
                NavigationLink("Inclusivity", value: InfoDestination.inclusivity)
                NavigationLink("Sponsors", value: InfoDestination.sponsors)
                NavigationLink("About iOSDevUK", value: InfoDestination.aboutApp)
                NavigationLink("App Information", value: InfoDestination.appInformation)
            }
            .navigationTitle("Info")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
            }
            .navigationDestination(for: InfoDestination.self) { destination in
                switch destination {
                case .inclusivity:
                    InclusivityView()
                case .sponsors:
                    SponsorsView()
                case .aboutApp:
                    AboutView()
                case .appInformation:
                    AppInformationView()
                case .admin:
                    AdminView()
                case .loginView:
                    LoginView()
                case .adminSpeakers:
                    AdminSpeakers()
                case .adminAddSpeaker(let speaker):
                    AddSpeakerView(speaker: speaker)
                case .adminSessions:
                    AdminSessions()
                case .adminAddSession(let session):
                    AddSession()
                case .adminLocations:
                    AdminLocations()
                case .adminAddLocation(let location):
                    AddLocation()
                case .adminSponsors:
                    AdminSponsors()
                case .adminAddSponsor(let sponsor):
                    AddSponsore()
                }
            }
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
