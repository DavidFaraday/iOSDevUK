//
//  SpeakersHorizontalRow.swift
//  iOSDevUK
//
//  Created by David Kababyan on 15/03/2024.
//

import SwiftUI

struct SpeakersHorizontalRowView: View {
    let speakers: [Speaker]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(AppStrings.speakers).font(.title2).bold()
                Spacer()
                NavigationLink(AppStrings.allSpeakers, value: Destination.speakers(speakers.sorted()))
                    .foregroundStyle(Color(ColorNames.textGrey))
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 8) {
                    ForEach(speakers) { speaker in
                        NavigationLink(value: Destination.speaker(speaker)) {
                            SpeakerCardView(speaker: speaker)
                                .frame(width: 110)
                        }
                    }
                }
                .padding(.leading)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    SpeakersHorizontalRowView(speakers: DummyData.speakers)
}
