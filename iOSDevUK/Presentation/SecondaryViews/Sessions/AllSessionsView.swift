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
            by: { $0.startingDay }
        )
    }
        
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(groupedSessions[viewModel.selectedDate]?.sorted() ?? [], id: \.id) { session in
                    
                    NavigationLink(value: Destination.session(session)) {
                        NewSessionCard(session: session, showSpeakers: true, showBookmark: true)
                            .id(session)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .task { await viewModel.fetchEventNotification() }
        .task { baseViewModel.loadFavSessions() }
        .task { viewModel.setCurrentDate() }
        .onAppear { viewModel.setSessions(sessions: sessions) }
        .safeAreaInset(edge: .top) {
            DayPickerView(days: groupedSessions.keys.sorted(), selection: $viewModel.selectedDate.animation())
                .padding(.vertical, 16)
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
