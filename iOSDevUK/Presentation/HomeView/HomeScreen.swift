//
//  HomeView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI
import Factory

struct HomeScreen: View {
    @EnvironmentObject var viewModel: BaseViewModel
    @EnvironmentObject var router: NavigationRouter
    
    let columns = UIDevice.current.userInterfaceIdiom == .pad ? [
        GridItem(.adaptive(minimum: 120)),
        GridItem(.adaptive(minimum: 120)),
        GridItem(.adaptive(minimum: 120)),
        GridItem(.adaptive(minimum: 120))
    ] : [
        GridItem(.adaptive(minimum: 120)),
        GridItem(.adaptive(minimum: 120))
    ]
    
    
    @ViewBuilder
    private func sessionView() -> some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text(AppStrings.sessions).font(.title2).bold()
                Spacer()
                NavigationLink(AppStrings.viewAll, value: Destination.sessions(viewModel.sessions))
                    .foregroundStyle(Color(ColorNames.textGrey))
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 10) {
                    ForEach(viewModel.homeViewSessions) { session in
                        
                        NavigationLink(value: Destination.session(session)) {
                            SessionCardView(session: session,
                                            speakers: viewModel.getSpeakers(with: session.speakerIds),
                                            location: viewModel.getLocation(with: session.locationId))
                            .id(session)
                            .frame(width: 300, height: 150)
                        }
                    }
                }
                .padding(.leading)
            }
            .scrollIndicators(.hidden)
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
        VStack(alignment: .leading, spacing: 20) {
            Text(AppStrings.sponsors)
                .foregroundStyle(Color(.mainText))
                .boldAppFont(size: 20)

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.sponsors) { sponsor in
                    NavigationLink(value: Destination.sponsor) {
                        SponsorCard(sponsor: sponsor)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func main() -> some View {
        ScrollView {
            VStack(spacing: 30) {
                
                WeatherView()
                
                SpeakersHorizontalRowView(speakers: viewModel.speakers)
                sessionView()

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
                            SpeakerDetailView(speaker: speaker)
                        case .speakers(let speakers):
                            AllSpeakersView(speakers: speakers)
                        case .sponsor:
                            SponsorsScreen()
                        case .locations(let locations):
                            MapView(allLocations: locations)
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
