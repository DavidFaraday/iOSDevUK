//
//  SessionsView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/09/2022.
//

import SwiftUI

struct SessionsView: View {
    @StateObject private var viewModel: SessionsViewModel
    
    init(viewModel: SessionsViewModel = SessionsViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Form {
            ForEach(viewModel.sessions) { session in
                NavigationLink { SessionDetailView(session: session) }
            label: {
                SessionRowView(session: session)
                }
            }
        }
        .navigationTitle("Sessions")
        .task(viewModel.fetchSessions)
    }
}

struct SessionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SessionsView()
        }
    }
}
