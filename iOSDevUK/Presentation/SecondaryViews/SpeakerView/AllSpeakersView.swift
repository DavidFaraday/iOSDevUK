//
//  AllSpeakersView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct AllSpeakersView: View {
    
    let speakers: [Speaker]
    
    let columns = UIDevice.current.userInterfaceIdiom == .pad ? [
        GridItem(.adaptive(minimum: 120)),
        GridItem(.adaptive(minimum: 120)),
        GridItem(.adaptive(minimum: 120)),
        GridItem(.adaptive(minimum: 120)),
        GridItem(.adaptive(minimum: 120))
    ] : [
        GridItem(.adaptive(minimum: 120)),
        GridItem(.adaptive(minimum: 120)),
        GridItem(.adaptive(minimum: 120))
    ]
    
    let scaleSize: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 6 : 4
    
    var body: some View {
        List(speakers) { speaker in
            NavigationLink(value: Destination.speaker(speaker)) {
                SpeakerRowView(speaker: speaker)
            }
        }
        .padding(.horizontal)

//        ScrollView {
//            LazyVGrid(columns: columns, spacing: 20) {
//                ForEach(speakers) { speaker in
//                    NavigationLink(value: Destination.speaker(speaker)) {
//                        SpeakerCardView(speaker: speaker)
//                    }
//                }
//            }
//            .padding(.horizontal)
//        }
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
