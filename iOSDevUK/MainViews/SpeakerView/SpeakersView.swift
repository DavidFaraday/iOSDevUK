//
//  SpeakersView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct SpeakersView: View {
    @StateObject private var viewModel: SpeakersViewModel

    init(viewModel: SpeakersViewModel = SpeakersViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        List {
            ForEach(viewModel.speakers) { speaker in
                SpeakerCellView(speaker: speaker)
            }
        }
        .listStyle(.grouped)
        .navigationTitle("Speakers")
        .task {
            await viewModel.getSpeakers()
        }
    }
}

struct SpeakersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SpeakersView()
        }
    }
}
