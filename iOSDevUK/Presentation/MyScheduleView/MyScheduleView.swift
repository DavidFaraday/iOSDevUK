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
    
    @State private var selectedType: Int = 0
    
    init(selectedType: Int = 0) {
        self._selectedType = State(initialValue: selectedType)
    }
    
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

            AppSegmentedControl<ScheduleType>(selection: $selectedType)
                .padding(.top, 15)
        }
        .padding(.horizontal, 16)
        .frame(minHeight: 130)
        .roundBackgroundView(color: Color(.cardBackground))
    }
    
    
    @ViewBuilder
    private func sessionsListView() -> some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.groupedSessions.keys.sorted(), id: \.self) { key in
                    
                    Section {
                        ForEach(viewModel.groupedSessions[key] ?? []) { session in
                            NavigationLink(value: Destination.session(session)) {
                                SessionRowView(session: session, showSpeakers: true)
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
        VStack(alignment: .leading) {
            headerView()

            if selectedType == 0 {
                if baseViewModel.favoriteSessionIds.isEmpty {
                    EmptyContentView(
                        image: Image(.emptySchedule),
                        title: "No sessions yet!",
                        description: "Please bookmark sessions to see them here",
                        buttonTitle: "Explore sessions"
                    ) {
                        router.schedulePath.append(Destination.sessions(baseViewModel.sessions))
                    }
                } else {
                    
                    Spacer()
                    sessionsListView()
                }

            } else {
                AllSessionsView(sessions: baseViewModel.sessions)
            }

        }
        .ignoresSafeArea(edges: .top)

    }
    
    var body: some View {
        NavigationStack(path: $router.schedulePath) {
            main()
                .task {
                    await viewModel.listenForSessions()
                }
                .animation(.smooth, value: selectedType)
                .task(id: selectedType) {
                    baseViewModel.loadFavSessions()
                    viewModel.setFavSessions(favSessionIds: baseViewModel.favoriteSessionIds)
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
                        case .sponsor:
                            SponsorsScreen()
                        case .locations(let locations):
                            MapScreen(allLocations: locations)
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
