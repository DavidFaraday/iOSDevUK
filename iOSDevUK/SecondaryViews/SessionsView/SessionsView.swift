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
        ScrollView(showsIndicators: false) {
            ForEach(viewModel.sessions) { session in
                NavigationLink {
                    SessionDetailView(session: session)
                } label: {
                    SessionCardView(session: session, speakers: [DummyData.speaker, DummyData.speaker], location: DummyData.location)
                        .frame(minHeight: 170)
                }
            }
            .listRowSeparator(.hidden)
        }
        .padding([.leading, .trailing])
        .navigationTitle("Sessions")
        .task {
            await viewModel.getSessions()
        }
    }
}

struct SessionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SessionsView()
        }
    }
}
