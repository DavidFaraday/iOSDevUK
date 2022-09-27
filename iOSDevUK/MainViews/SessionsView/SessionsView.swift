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
        List {
            ForEach(viewModel.sessions) { session in
                Text(session.title)
            }
        }
        .listStyle(.grouped)
        .navigationTitle("Sessions")
        .task {
            await viewModel.getSessions()
        }
    }
}

struct SessionsView_Previews: PreviewProvider {
    static var previews: some View {
        SessionsView()
    }
}
