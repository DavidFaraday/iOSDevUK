//
//  InfoView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI
import Factory

struct InfoView: View {
    @Injected(\.firebaseAuthRepository) private var firebaseAuth

    @EnvironmentObject var router: NavigationRouter

    @State var showLoginView = false
    @State var clickCount = 0
    
    
    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        if firebaseAuth.hasCurrentUser() {
            NavigationLink(AppStrings.admin, value: InfoDestination.admin)
        } else {
            Button("") {
                clickCount += 1
                if clickCount == 3 {
                    showLoginView = true
                    clickCount = 0
                }
            }
            .frame(width: 44)
            .sheet(isPresented: $showLoginView, onDismiss: {
                if firebaseAuth.hasCurrentUser() {
                    router.infoPath.append(InfoDestination.admin)
                }
            }, content: {
                LoginView()
            })
        }
    }
    
    var body: some View {
        NavigationStack(path: $router.infoPath) {
            Form {
                Section {
                    NavigationLink(AppStrings.locations, value: InfoDestination.locationList)
                    NavigationLink(AppStrings.inclusivity, value: InfoDestination.inclusivity)
                    NavigationLink(AppStrings.sponsors, value: InfoDestination.sponsors)
                    NavigationLink(AppStrings.aboutIOsDev, value: InfoDestination.aboutApp)
                    NavigationLink(AppStrings.appInfo, value: InfoDestination.appInformation)
                } footer: {
                    Text("Version: \(Bundle.main.appVersionLong) (\(Bundle.main.appBuild))")
                }
            }
            .navigationTitle(AppStrings.info)
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
                case .adminSpeakers:
                    AdminSpeakers()
                case .adminAddSpeaker(let speaker):
                    AddSpeakerView(viewModel: AdminSpeakerViewModel(speaker: speaker))
                case .adminSessions:
                    AdminSessions()
                case .adminAddSession(let session):
                    AddSession(viewModel: AdminSessionViewModel(session: session))
                case .adminLocations:
                    AdminLocations()
                case .adminAddLocation(let location):
                    AddLocation(viewModel: AdminLocationViewModel(location: location))
                case .adminSponsors:
                    AdminSponsors()
                case .adminAddSponsor(let sponsor):
                    AddSponsorView(viewModel: AdminSponsorViewModel(sponsor: sponsor))
                case .locationList:
                    LocationsListView()
                case .locations(let locations):
                    MapView(allLocations: locations)
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
