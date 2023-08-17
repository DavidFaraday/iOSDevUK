//
//  HomeView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI
import Factory

struct HomeView: View {
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
    private func headerView() -> some View {

        VStack {
            ZStack {
                Image(ImageNames.infoBackground)
                    .resizable(resizingMode: .tile)
                    .frame(height: 200.0)
                    .cornerRadius(16)

                Image(ImageNames.infoDevices)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200.0)
                    .padding([.horizontal, .top])
            }
            .padding(.bottom)

            Text(viewModel.eventInformation?.notification ?? AppStrings.loading)
                .font(.headline)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
    }

    
    @ViewBuilder
    private func sessionView() -> some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text(AppStrings.sessions).font(.title2).bold()
                Spacer()
                NavigationLink(AppStrings.allSessions, value: Destination.sessions(viewModel.sessions))
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 10) {
                    ForEach(viewModel.sessions) { session in
                        
                        NavigationLink(value: Destination.session(session)) {
                            SessionCardView(session: session).frame(width: 300, height: 150)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.leading)

        }
    }

    @ViewBuilder
    private func speakerView() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(AppStrings.speakers).font(.title2).bold()
                Spacer()
                NavigationLink(AppStrings.allSpeakers, value: Destination.speakers(viewModel.speakers))
            }
            .padding(.horizontal)

            ScrollView(.horizontal) {
                LazyHStack(spacing: 10) {
                    ForEach(viewModel.shuffledSpeakers) { speaker in
                        NavigationLink(value: Destination.speaker(speaker)) {
                            SpeakerCardView(speaker: speaker)
                                .frame(width: 120)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.leading)
        }
    }
    
    @ViewBuilder
    private func footerView() -> some View {
        VStack(alignment: .center, spacing: 10) {
            if viewModel.eventInformation != nil {
                Text(viewModel.eventInformation?.about ?? AppStrings.loading)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .padding(10)
            }
            
            if let slackUrl = URL(string: Slack.channelLink) {
                Link(AppStrings.slackChannel, destination: slackUrl)
            }
            if let twitterUrl = URL(string: TwitterAccounts.iOSDevUK) {
                Link(AppStrings.iOSDevTwitter, destination: twitterUrl)
            }
            if let twitterUrl = URL(string: TwitterAccounts.aberCompSci) {
                Link(AppStrings.aberCompTwitter, destination: twitterUrl)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
    }

    
    @ViewBuilder
    private func sponsorView() -> some View {
        VStack {
            HStack {
                Text(AppStrings.sponsors).font(.title2).bold()
                Spacer()
            }
            
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
            VStack(spacing: 20) {
                WeatherView()

                sessionView()
                speakerView()
                sponsorView()
                
                if viewModel.eventInformation != nil {
                    headerView()
                }

                footerView()
            }
        }
        .scrollIndicators(.hidden)
    }

    var body: some View {
        NavigationStack(path: $router.homePath) {
            main()
                .navigationTitle(AppStrings.iOSDevUK)
                .navigationBarTitleDisplayMode(.inline)
                .task(viewModel.listenForEventNotification)
                .task(viewModel.listenForSessions)
                .task(viewModel.listenForSpeakers)
                .task(viewModel.listenForSponsors)
                .task(viewModel.listenForLocations)
                .task(viewModel.listenForInfoItems)
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                    case .session(let session):
                        SessionDetailView(sessionId: session.id)
                    case .sessions(let sessions):
                        AllSessionsView(sessions: sessions)
                    case .speaker(let speaker):
                        SpeakerDetailView(speaker: speaker)
                    case .speakers(let speakers):
                        AllSpeakersView(speakers: speakers)
                    case .sponsor:
                        SponsorsView()
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
        
        HomeView()
        .previewDevice(PreviewDevice(rawValue: "iPhone 14 pro"))
        .previewDisplayName("iPhone 14")

        HomeView()
        .previewDevice(PreviewDevice(rawValue: "iPad mini (6th generation)"))
        .previewDisplayName("iPad mini")

        HomeView()
        .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (6th generation)"))
        .previewDisplayName("iPad pro 11")
    }
}
