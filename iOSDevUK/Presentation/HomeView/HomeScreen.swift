//
//  HomeView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var viewModel: BaseViewModel
    @EnvironmentObject var router: NavigationRouter
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    func columns() -> [GridItem] {
        
        if horizontalSizeClass == .compact {
            return [
                GridItem(.flexible(minimum: 120)),
                GridItem(.flexible(minimum: 120))
            ]
        }
        else {
            return [
                GridItem(.flexible(minimum: 120)),
                GridItem(.flexible(minimum: 120)),
                GridItem(.flexible(minimum: 120))
            ]
        }
    }
    
    @ViewBuilder
    private func usefulLinks() -> some View {
        VStack(alignment: .center, spacing: 10) {
            
            if let slackUrl = URL(string: Slack.channelLink) {
                Link(destination: slackUrl) {
                    ContactButtonView(imageName: "slack", title: AppStrings.iOSDevUK)
                }
            }
            
            if let twitterUrl = URL(string: ContactAccounts.iOSDevUK) {
                Link(destination: twitterUrl) {
                    ContactButtonView(imageName: "twitter", title: AppStrings.iOSDevUK)
                }
            }
            
            if let twitterUrl = URL(string: ContactAccounts.aberCompSci) {
                Link(destination: twitterUrl) {
                    ContactButtonView(imageName: "twitter", title: AppStrings.aberCompTwitter)
                }
            }
        }
        .padding([.bottom, .horizontal], 16)
    }
    
    
    @ViewBuilder
    private func sponsorView() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(AppStrings.sponsors)
                    .foregroundStyle(Color(.mainText))
                    .boldAppFont(size: 20)

                Spacer()
                
                NavigationLink(AppStrings.viewAll, value: Destination.sponsor(nil))
                    .foregroundStyle(Color(.textGrey))
            }
            
            LazyVGrid(columns: columns(), spacing: 10) {
                ForEach(viewModel.sponsors) { sponsor in
                    NavigationLink(value: Destination.sponsor(sponsor)) {
                        SponsorCard(sponsor: sponsor)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func main() -> some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 30) {
                    
                    WeatherView()
                    
                    SpeakersHorizontalScrollView(speakers: viewModel.speakers)
                    SessionsHorizontalScrollView(sessions: viewModel.homeViewSessions, geometry: geometry)
                    
                    sponsorView()
                    
                    if viewModel.eventInformation != nil {
                        EventInfoView(
                            eventDate: viewModel.eventDate,
                            notificationBody: viewModel.eventInformation?.about
                        )
                        .padding(.horizontal, 16)
                    }
                    
                    usefulLinks()
                }
            }
            .scrollIndicators(.hidden)
        }
    }
    
    var body: some View {
        NavigationStack(path: $router.homePath) {
            main()
                .navigationTitle(AppStrings.iOSDevUK)
                .navigationBarTitleDisplayMode(.inline)
                .task {
                    await viewModel.listenForData()
                    viewModel.loadFavSessions()
                }
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                        case .session(let session):
                            SessionDetailView(session: session)
                        case .sessions(let sessions):
                            AllSessionsView(sessions: sessions)
                        case .speaker(let speaker):
                            SpeakerDetailScreen(speaker: speaker)
                        case .speakers(let speakers):
                            AllSpeakersView(speakers: speakers)
                        case .sponsor(let sponsor):
                            SponsorsScreen(sponsor: sponsor)
                        case .locations(let locations):
                            MapScreen(allLocations: locations)
                    }
                }
        }
        .onAppear() {
            viewModel.shuffleSpeakers()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        HomeScreen()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 pro"))
            .previewDisplayName("iPhone 14")
        
        HomeScreen()
            .previewDevice(PreviewDevice(rawValue: "iPad mini (6th generation)"))
            .previewDisplayName("iPad mini")
        
        HomeScreen()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (6th generation)"))
            .previewDisplayName("iPad pro 11")
    }
}


extension View {
    func stacked(at position: Int, in total: Int = 3) -> some View {
        let offset = Double(total - position)
        
        return self.offset(y: offset * 10)
    }
}
