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

    @ViewBuilder
    private func headerView() -> some View {
        VStack {
            Text(viewModel.eventInformation?.notification ?? "Loading...")
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
                Text("Sessions").font(.title2).bold()
                Spacer()
                NavigationLink("All Sessions", value: Destination.sessions(viewModel.sessions))
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
                Text("Speakers") .font(.title2).bold()
                Spacer()
                NavigationLink("All Speakers", value: Destination.speakers(viewModel.speakers))
            }
            .padding(.horizontal)

            ScrollView(.horizontal) {
                LazyHStack(spacing: 10) {
                    ForEach(viewModel.speakers) { speaker in
                        NavigationLink(value: Destination.speaker(speaker)) {
                            SpeakerCardView(speaker: speaker)
                                .frame(width: 130)
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
                Text(viewModel.eventInformation?.about ?? "Loading...")
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .padding(10)
            }

            if let twitterUrl = URL(string: TwitterAccounts.iOSDevUK) {
                Link("@iOSDevUK on Twitter", destination: twitterUrl)
            }
            if let twitterUrl = URL(string: TwitterAccounts.aberCompSci) {
                Link("@AberCompSci on Twitter", destination: twitterUrl)
            }

        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
    }

    
    
    @ViewBuilder
    private func main() -> some View {
        ScrollView {
            VStack(spacing: 20) {
                if viewModel.eventInformation != nil {
                    headerView()
                }
                sessionView()
                speakerView()
                footerView()
            }
        }
        .scrollIndicators(.hidden)
    }

    var body: some View {
        NavigationStack(path: $router.homePath) {
            main()
                .navigationTitle("iOSDev UK")
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
                    case .savedSession(let savedSession):
                        SessionDetailView(sessionId: savedSession.id ?? "")
                    }
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
