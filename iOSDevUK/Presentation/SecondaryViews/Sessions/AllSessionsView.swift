//
//  AllSessionsView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/09/2022.
//

import SwiftUI

struct AllSessionsView: View {
    
    @StateObject private var viewModel = AllSessionsViewModel()
    @EnvironmentObject var baseViewModel: BaseViewModel
    
    let sessions: [Session]
    private var groupedSessions: [String : [Session]] {
        .init(
            grouping: baseViewModel.sessions,
            by: {$0.startingDay }
        )
    }
        
    var body: some View {
        Form {
            ForEach(groupedSessions[viewModel.selectedDate]?.sorted() ?? [], id: \.id) { session in
                
                NavigationLink(value: Destination.session(
                    SessionDetailModel(session: session,
                                  speakers: baseViewModel.getSpeakers(with: session.speakerIds),
                                  location: baseViewModel.getLocation(with: session.locationId))
                )) {
                    SessionRowView(session: session,
                                   isFavorite: baseViewModel.isFavorite(session.id),
                                   location: baseViewModel.getLocation(with: session.locationId),
                                   speakers: baseViewModel.getSpeakers(with: session.speakerIds))
                    .id(session)
                }
                .swipeActions {
                    Button {
                        baseViewModel.updateFavoriteSession(sessionId: session.id)
                    } label: {
                        Image(systemName: ImageNames.bookmark)
                    }
                    .tint(Color(ColorNames.primary))
                }
            }
        }
        .navigationTitle(AppStrings.sessions)
        .navigationBarTitleDisplayMode(.inline)
        .task(viewModel.listenForEventNotification)
        .task { baseViewModel.loadFavSessions() }
        .task { viewModel.setCurrentDate() }
        .onAppear { viewModel.setSessions(sessions: sessions) }
        .safeAreaInset(edge: .top) {
            Picker("", selection: $viewModel.selectedDate.animation()) {
                ForEach(groupedSessions.keys.sorted(), id: \String.self) { weekDay in
                    Text(weekDay.removeDigits)
                }
            }
            .pickerStyle(.segmented)
            .padding(10)
            .background(Color(ColorNames.backgroundColor))
        }
    }
}

struct SessionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AllSessionsView(sessions: DummyData.sessions)
        }
    }
}
