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
    @EnvironmentObject var viewModel: BaseViewModel
    @EnvironmentObject var router: NavigationRouter

    @Environment(\.colorScheme) var colorScheme
    
    @State var showLoginView = false
    @State var clickCount = 0
    
    @ViewBuilder
    private func sponsorSection(forCategory category: SponsorCategory) -> some View {
        
        let sponsors = viewModel.sponsors.filter({ $0.sponsorCategory == category })
        
        Section {
            HStack {
                ForEach(sponsors, id: \.id) { sponsor in
                    RemoteImageView(url: colorScheme == .dark ? sponsor.imageUrlDark : sponsor.imageUrlLight)
                        .frame(maxWidth: 200, maxHeight: 50)
                        .padding(.leading)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        } header: {
            Text("Thank you to our \(category.rawValue) sponsor\(sponsors.count > 1 ? "s" : "")")
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .listRowSeparator(.hidden)
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
            Form {
                sponsorSection(forCategory: .Platinum)
                sponsorSection(forCategory: .Gold)
                
                Section {
                    NavigationLink(value: InfoDestination.locationList) {
                        NavigationRowView(systemImageName: ImageNames.mapPinEmpty, title: AppStrings.locations)
                    }
                    NavigationLink(value: InfoDestination.inclusivity) {
                        NavigationRowView(systemImageName: ImageNames.persons3, title: AppStrings.inclusivity)
                    }

                    NavigationLink(value: InfoDestination.sponsors) {
                        NavigationRowView(systemImageName: ImageNames.heart, title: AppStrings.sponsors)
                    }
                    
                    NavigationLink(value: InfoDestination.aboutApp) {
                        NavigationRowView(systemImageName: ImageNames.infoCircle, title: AppStrings.aboutIOsDev)
                    }

                    NavigationLink(value: InfoDestination.appInformation) {
                        NavigationRowView(systemImageName: ImageNames.iphone, title: AppStrings.appInfo)
                    }

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
