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
    
    @State private var selectedType: ScheduleType = .mySchedule
    
    //    @ViewBuilder
    //    private func navigationBarTrailingItem() -> some View {
    //        if !baseViewModel.favoriteSessionIds.isEmpty {
    //            Button(AppStrings.sessions) {
    //                router.schedulePath.append(Destination.sessions(baseViewModel.sessions))
    //            }
    //        }
    //    }
    
    @ViewBuilder
    private func headerView() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("TODAY")
                .appFont(size: 12)
                .foregroundStyle(Color(.textGrey))
                .padding(.top, 45)
            
            Text(Date().formatted(date: .complete, time: .omitted))
                .appFont(size: 24)
                .foregroundStyle(Color(.mainText))

            
            Picker("", selection: $selectedType) {
                ForEach(ScheduleType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(.segmented)
            .padding(.vertical, 10)
        }
        .frame(minHeight: 130)
        .roundBackgroundView(color: Color(.speakerCardBackground))
    }
    
    
    @ViewBuilder
    private func sessionsListView() -> some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.groupedSessions.keys.sorted(), id: \.self) { key in
                    
                    Section {
                        ForEach(viewModel.groupedSessions[key] ?? []) { session in
                            NavigationLink(value: Destination.session(
                                SessionDetailModel(session: session,
                                                   speakers: baseViewModel.getSpeakers(with: session.speakerIds),
                                                   location: baseViewModel.getLocation(with: session.locationId))
                            )) {
                                NewSessionCard(session: session, showSpeakers: true)
                            }
                        }
                    } header: {
                        if !(viewModel.groupedSessions[key]?.isEmpty ?? true) {
                            SectionHeaderView(title: key.uppercased())
                                .semiboldAppFont(size: 16)
                                .padding(.top, 20)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    
    @ViewBuilder
    private func main() -> some View {
        
        if baseViewModel.favoriteSessionIds.isEmpty {
            EmptyContentView(image: Image(.emptySchedule), title: "No sessions yet!", description: "Please bookmark sessions to see them here", buttonTitle: "Explore sessions") {
                router.schedulePath.append(Destination.sessions(baseViewModel.sessions))
            }
        } else {
            VStack(alignment: .leading) {
                headerView()
                
                sessionsListView()
            }
            .ignoresSafeArea(edges: .top)
        }
    }
    
    var body: some View {
        NavigationStack(path: $router.schedulePath) {
            main()
                .task(viewModel.listenForSessions)
                .onAppear {
                    baseViewModel.loadFavSessions()
                    viewModel.setFavSessions(favSessionIds: baseViewModel.favoriteSessionIds)
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
                            SponsorsScreen()
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



enum ScheduleType: String, CaseIterable {
    case mySchedule = "My Schedule"
    case allSessions = "All Sessions"
}
