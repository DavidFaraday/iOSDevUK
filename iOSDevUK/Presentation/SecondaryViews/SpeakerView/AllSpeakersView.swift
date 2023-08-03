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
        GridItem(.adaptive(minimum: 120)),
        GridItem(.adaptive(minimum: 120)),
        GridItem(.adaptive(minimum: 120))
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(speakers) { speaker in
                        
                        NavigationLink(value: Destination.speaker(speaker)) {
                            SpeakerCardView(speaker: speaker,
                                            height: geometry.size.height > geometry.size.width ? geometry.size.height / 4 : geometry.size.width / 4)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle(AppStrings.speakers)
        }
    }
}

struct SpeakersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AllSpeakersView(speakers: DummyData.speakers)
        }
    }
}
