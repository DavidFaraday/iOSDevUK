//
//  AllSessionsView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/09/2022.
//

import SwiftUI

struct AllSessionsView: View {
    
    @StateObject private var viewModel: AllSessionsViewModel
       
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
        VStack {
            
            Picker("", selection: $viewModel.selectedDate.animation()) {
                ForEach(groupedSessions.keys.sorted(), id: \String.self) { weekDay in
                    Text(weekDay.removeDigits)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            
            Form {
                ForEach(groupedSessions[viewModel.selectedDate]?.sorted(by: {$0.startDate < $1.startDate }) ?? [], id: \.id) { session in
                    
                    NavigationLink {
                        SessionDetailView(session: session)
                    } label: {
                        SessionRowView(session: session)
                    }
                }
            }
        }
        .navigationTitle("Sessions")
        .task{ viewModel.setCurrentDate() }
    }
}

struct SessionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AllSessionsView(sessions: DummyData.sessions)
        }
    }
}
