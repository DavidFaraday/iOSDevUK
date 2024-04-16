//
//  SessionDetailView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 03/10/2022.
//

import SwiftUI

struct SessionDetailView: View {
    @EnvironmentObject var baseViewModel: BaseViewModel
    @Environment(\.presentationMode) var presentationMode

    let session: Session

    @ViewBuilder
    private func navigationBarLeadingItem() -> some View {
        Button { presentationMode.wrappedValue.dismiss() }
        label: { Image(.back) }
            .tint(Color(.mainText))
    }

    @ViewBuilder
    private func main() -> some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                
                Text(session.title)
                    .boldAppFont(size: 24)
                    .foregroundStyle(Color(.mainText))
                    .padding(.top, 10)

                Text(session.content)
                    .foregroundStyle(Color(.textBody))
                    .appFont(size: 16)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 10)


                InfoRowView(text: session.duration, imageName: ImageNames.calendar)
                
                
                if let location = baseViewModel.getLocation(with: session.locationId) {
                    NavigationLink(value: Destination.locations(locations: [location])) {
                        InfoRowView(text: location.name, imageName: ImageNames.location)
                    }
                }

                if !baseViewModel.getSpeakers(with: session.speakerIds).isEmpty {
                    ForEach(baseViewModel.getSpeakers(with: session.speakerIds)) { speaker in
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
                baseViewModel.updateFavoriteSession(sessionId: session.id)
            } label: {
                Text(baseViewModel.isFavorite(session.id) ? "Remove from schedule" : "Add to schedule")
            }
            .buttonStyle(.appPrimary)
            .padding([.bottom, .horizontal], 16)
        }
    }
    
    var body: some View {
        main()
            .navigationTitle("Event Info")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading, content: navigationBarLeadingItem)
            }

    }
}
