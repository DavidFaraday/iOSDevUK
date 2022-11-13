//
//  AllSpeakersView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct AllSpeakersView: View {
    
    let speakers: [Speaker]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(speakers) { speaker in
                    NavigationLink {
                        SpeakerDetailView(speaker: speaker)
                    } label: {
                        SpeakerCardView(speaker: speaker)
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Speakers")
    }
}

struct SpeakersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AllSpeakersView(speakers: DummyData.speakers)
        }
    }
}
