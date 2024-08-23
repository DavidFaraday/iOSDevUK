//
//  SpeakersHorizontalScrollView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 15/03/2024.
//

import SwiftUI

struct SpeakersHorizontalScrollView: View {
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
            
            
            if #available(iOS 17.0, *) {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 5) {
                        ForEach(speakers) { speaker in
                            NavigationLink(value: Destination.speaker(speaker)) {
                                SpeakerCardView(speaker: speaker)
                                    .frame(width: 110)
                            }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .safeAreaPadding(.horizontal, 10)
                .scrollIndicators(.hidden)
            } else {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 10) {
                        ForEach(speakers) { speaker in
                            NavigationLink(value: Destination.speaker(speaker)) {
                                SpeakerCardView(speaker: speaker)
                                    .frame(width: 110)
                            }
                        }
                    }
                    .padding(.leading, 16)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    SpeakersHorizontalScrollView(speakers: DummyData.speakers)
}
