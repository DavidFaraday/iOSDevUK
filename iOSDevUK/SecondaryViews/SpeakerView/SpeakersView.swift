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
        ScrollView {
            LazyVGrid(columns: viewModel.columns, spacing: 20) {
                ForEach(DummyData.speakers) { speaker in
                    NavigationLink { SpeakerDetailView(speaker: speaker) }
                    label: {
                        SpeakerCardView(speaker: speaker)
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Speakers")
        .task(viewModel.getSpeakers)
    }
}

struct SpeakersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SpeakersView()
        }
    }
}
