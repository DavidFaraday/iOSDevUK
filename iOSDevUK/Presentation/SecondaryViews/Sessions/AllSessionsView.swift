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
    
    @Environment(\.presentationMode) var presentationMode
    var showBackButton: Bool = true
    let sessions: [Session]
    private var groupedSessions: [String : [Session]] {
        .init(
            grouping: baseViewModel.sessions,
            by: { $0.startingDay }
        )
    }
        
    
    @ViewBuilder
    private func navigationBarLeadingItem() -> some View {
        Button { presentationMode.wrappedValue.dismiss() }
        label: { Image(.back) }
            .tint(Color(.mainText))
    }

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(groupedSessions[viewModel.selectedDate]?.sorted() ?? [], id: \.id) { session in
                    
                    NavigationLink(value: Destination.session(session)) {
                        SessionRowView(
                            session: session,
                            showSpeakers: true
                        ) {
                            baseViewModel.updateFavoriteSession(sessionId: session.id)
                        }
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
            Picker("", selection: $viewModel.selectedDate.animation()) {
                ForEach(groupedSessions.keys.sorted(), id: \String.self) { weekDay in
                    Text(weekDay.removeDigits)
                }
            }
            .pickerStyle(.segmented)
            .padding(10)
            .background(Color(.background))
        }
        .navigationTitle(showBackButton ? "All Sessions" : "")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            if showBackButton {
                ToolbarItem(placement: .topBarLeading, content: navigationBarLeadingItem)
            }
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
