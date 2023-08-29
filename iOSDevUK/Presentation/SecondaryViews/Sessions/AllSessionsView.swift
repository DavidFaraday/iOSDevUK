//
//  AllSessionsView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/09/2022.
//

import SwiftUI

struct AllSessionsView: View {
    
    @StateObject private var viewModel: AllSessionsViewModel
    @EnvironmentObject var baseViewModel: BaseViewModel

    private var groupedSessions: [String : [Session]] {
        .init(
            grouping: viewModel.sessions,
            by: {$0.startingDay }
        )
    }
    
    init(sessions: [Session]) {
        _viewModel = StateObject(wrappedValue: AllSessionsViewModel(sessions: sessions))
    }
    
    
    var body: some View {
        Form {
            ForEach(groupedSessions[viewModel.selectedDate]?.sorted() ?? [], id: \.id) { session in
                
                NavigationLink(value: Destination.session(session)) {
                    SessionRowView(session: session, isFavorite: baseViewModel.favoriteSessionIds.contains(session.id))
                }
            }
        }
        .navigationTitle(AppStrings.sessions)
        .task(viewModel.listenForEventNotification)
        .task { viewModel.setCurrentDate() }
        .task { baseViewModel.loadFavSessions() }
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
