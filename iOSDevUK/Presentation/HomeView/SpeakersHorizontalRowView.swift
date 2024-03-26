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
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text(AppStrings.speakers)
                    .foregroundStyle(Color(.mainText))
                    .boldAppFont(size: 20)

                Spacer()
                
                NavigationLink(AppStrings.viewAll, value: Destination.speakers(speakers.sorted()))
                    .foregroundStyle(Color(.textGrey))
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
