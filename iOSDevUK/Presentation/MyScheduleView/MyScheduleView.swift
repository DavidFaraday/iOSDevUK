//
//  MyScheduleView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct MyScheduleView: View {
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var router: NavigationRouter
    @EnvironmentObject var baseViewModel: BaseViewModel

    @StateObject private var viewModel = MyScheduleViewModel()
    
    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        if !baseViewModel.favoriteSessionIds.isEmpty {
            Button(AppStrings.sessions) {
                router.schedulePath.append(Destination.sessions(baseViewModel.sessions))
            }
        }
    }


    @ViewBuilder
    private func main() -> some View {
        
        ZStack {
            List {
                ForEach(viewModel.groupedSessions.keys.sorted(), id: \.self) { key in
                    
                    Section {
                        ForEach(viewModel.groupedSessions[key] ?? []) { session in
                            NavigationLink(value: Destination.session(
                                SessionDetailModel(session: session,
                                              speakers: baseViewModel.getSpeakers(with: session.speakerIds),
                                              location: baseViewModel.getLocation(with: session.locationId))
                            )) {
                                SessionRowView(session: session,
                                               location: baseViewModel.getLocation(with: session.locationId),
                                               speakers: baseViewModel.getSpeakers(with: session.speakerIds) )
                            }
                        }
                        .onDelete { indexSet in
                            withAnimation {
                                viewModel.delete(
                                    for: indexSet,
                                    key: key)
                                baseViewModel.loadFavSessions()
                            }
                        }
                    } header: {
                        if !(viewModel.groupedSessions[key]?.isEmpty ?? true) {
                            SectionHeaderView(title: key)
                                .font(.headline)
                        }
                    }
                }
            }

            
            if baseViewModel.favoriteSessionIds.isEmpty {
                EmptySessionView(message: AppStrings.emptySessionMessage, buttonTitle: AppStrings.takeMeThere) {
                    router.schedulePath.append(Destination.sessions(baseViewModel.sessions))
                }
            }
        }
    }

    var body: some View {
        NavigationStack(path: $router.schedulePath) {
            main()
                .navigationTitle(AppStrings.mySessions)
                .task(viewModel.listenForSessions)
                .onAppear {
                    baseViewModel.loadFavSessions()
                    viewModel.setFavSessions(favSessionIds: baseViewModel.favoriteSessionIds)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
                }
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                    case .session(let sessionDetail):
                        SessionDetailView(sessionDetail: sessionDetail)
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
    }
}

struct MyScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        MyScheduleView()
    }
}
