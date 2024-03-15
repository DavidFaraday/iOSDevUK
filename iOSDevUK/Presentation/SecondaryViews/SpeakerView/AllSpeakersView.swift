//
//  AllSpeakersView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct AllSpeakersView: View {
    
    let speakers: [Speaker]
        
    var body: some View {
        
        ScrollView {
            LazyVStack {
                ForEach(speakers) { speaker in
                    NavigationLink(value: Destination.speaker(speaker)) {
                        SpeakerRowView(speaker: speaker)
                            .padding(.bottom, 5)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle(AppStrings.speakers)
    }
}

struct SpeakersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AllSpeakersView(speakers: DummyData.speakers)
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 14 pro"))
        .previewDisplayName("iPhone 14")
        
        AllSpeakersView(speakers: DummyData.speakers)
            .previewDevice(PreviewDevice(rawValue: "iPad mini (6th generation)"))
            .previewDisplayName("iPad mini")
        
        AllSpeakersView(speakers: DummyData.speakers)
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch) (6th generation)"))
            .previewDisplayName("iPad pro 11")
        
    }
}
