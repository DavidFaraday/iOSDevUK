//
//  SessionDetailView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 03/10/2022.
//

import SwiftUI

struct SessionDetailView: View {
    @EnvironmentObject var baseViewModel: BaseViewModel
    
    let sessionDetail: SessionDetailModel
    
    @ViewBuilder
    private func main() -> some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                
                Text(sessionDetail.session.title)
                    .boldAppFont(size: 24)
                    .foregroundStyle(Color(.mainText))
                    .padding(.top, 10)

                Text(sessionDetail.session.content)
                    .foregroundStyle(Color(.textBody))
                    .appFont(size: 16)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 10)


                InfoRowView(text: sessionDetail.session.duration, imageName: ImageNames.calendar)
                
                
                if let location = sessionDetail.location {
                    NavigationLink(value: Destination.locations(locations: [location])) {
                        InfoRowView(text: location.name, imageName: ImageNames.location)
                    }
                }

                if !sessionDetail.speakers.isEmpty {
                    ForEach(sessionDetail.speakers) { speaker in
                        NavigationLink(value: Destination.speaker(speaker)) {
                            SpeakerRowView(speaker: speaker)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .scrollIndicators(.hidden)
        .safeAreaInset(edge: .bottom) {
            Button {
                baseViewModel.updateFavoriteSession(sessionId: sessionDetail.session.id)
            } label: {
                Text(baseViewModel.isFavorite(sessionDetail.session.id) ? "Remove from schedule" : "Add to schedule")
            }
            .buttonStyle(.appPrimary)
            .padding([.bottom, .horizontal], 16)
        }
    }
    
    var body: some View {
        main()
            .navigationTitle("Event Info")
            .navigationBarTitleDisplayMode(.inline)
    }
}
