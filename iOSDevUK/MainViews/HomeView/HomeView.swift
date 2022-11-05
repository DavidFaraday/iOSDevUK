//
//  HomeView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: BaseViewModel
    
    @ViewBuilder
    private func headerView() -> some View {
        VStack {
            Text(viewModel.eventNotification)
                .font(.headline)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    @ViewBuilder
    private func footerView() -> some View {
        
        VStack(alignment: .center, spacing: 10) {
            Text(viewModel.aboutString)
                .multilineTextAlignment(.center)
                .font(.body)
                .padding(10)

            Button("@iOSDevUK on Twitter") { viewModel.showTwitterAccount("iOSDevUK") }
            Button("@AberCompSci on Twitter") { viewModel.showTwitterAccount("AberCompSci") }
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    @ViewBuilder
    private func sessionView() -> some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text("Sessions").font(.title2).bold()
                Spacer()
                NavigationLink("All Sessions") { AllSessionsView(sessions: viewModel.sessions) }
            }
            
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(viewModel.sessions) { session in
                        NavigationLink { SessionDetailView(session: session) }
                        label: {
                            SessionCardView(session: session).frame(width: 300, height: 150)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(.bottom)
    }

    @ViewBuilder
    private func speakerView() -> some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text("Speakers") .font(.title2).bold()
                Spacer()
                NavigationLink("All Speakers") { AllSpeakersView(speakers: viewModel.speakers) }
            }
            
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(viewModel.speakers) { speaker in
                        NavigationLink { SpeakerDetailView(speaker: speaker) }
                        label: {
                            SpeakerCardView(speaker: speaker)
                                .frame(width: 130, height: 200)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(.bottom)
    }
    
    
    @ViewBuilder
    private func main() -> some View {
        ScrollView {
            headerView()
            sessionView()
            speakerView()
            footerView()
        }
        .scrollIndicators(.hidden)
        .padding()
    }

    var body: some View {
        main()
            .navigationTitle("iOSDev UK")
            .task(viewModel.listenForAboutString)
            .task(viewModel.listenForEventNotification)
            .task(viewModel.listenForSessions)
            .task(viewModel.listenForSpeakers)
            .task(viewModel.listenForSponsors)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
