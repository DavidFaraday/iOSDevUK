//
//  InfoView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct InfoView: View {
    private var firebaseAuth: FirebaseAuthenticationServiceProtocol

    @EnvironmentObject var router: NavigationRouter

    @State var showLoginView = false
    @State var clickCount = 0
    
    init(firebaseAuth: FirebaseAuthenticationServiceProtocol = FirebaseAuthenticationService.shared) {
        self.firebaseAuth = firebaseAuth
    }
    
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
            VStack(alignment: .leading, spacing: 10) {
                Text("Find out about us and our values.")
                    .semiboldAppFont(size: 16)
                    .foregroundStyle(Color(.textGrey))
                    .padding(.bottom, 15)

                NavigationLink(value: InfoDestination.locationList) {
                    NavigationRowView(imageName: ImageNames.location, title: AppStrings.locations)
                }
                
                NavigationLink(value: InfoDestination.inclusivity) {
                    NavigationRowView(imageName: ImageNames.inclusivity, title: AppStrings.inclusivity)
                }

                NavigationLink(value: InfoDestination.sponsors) {
                    NavigationRowView(imageName: ImageNames.sponsors, title: AppStrings.sponsors)
                }
                
                NavigationLink(value: InfoDestination.aboutApp) {
                    NavigationRowView(imageName: ImageNames.about, title: AppStrings.aboutIOsDev)
                }

                NavigationLink(value: InfoDestination.appInformation) {
                    NavigationRowView(imageName: ImageNames.phone, title: AppStrings.appInfo)
                }
                
                Text("Version: \(Bundle.main.appVersionLong) (\(Bundle.main.appBuild))")
                    .appFont(size: 12)
                    .foregroundStyle(Color(.textGrey))
                Spacer()
            }
            .padding([.top, .horizontal], 16)
            .navigationTitle("Information")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
            }
            .navigationDestination(for: InfoDestination.self) { destination in
                switch destination {
                case .inclusivity:
                    InclusivityView()
                case .sponsors:
                    SponsorsScreen()
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
                    MapScreen(allLocations: locations)
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
