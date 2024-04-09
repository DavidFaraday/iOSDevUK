//
//  SessionCardView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/09/2022.
//

import SwiftUI

struct SessionCardView: View {
    @EnvironmentObject var baseViewModel: BaseViewModel

    @State private var offset = CGSize.zero
    let widthScale = UIDevice.current.userInterfaceIdiom == .pad ? 0.6 : 0.9

    let session: Session
    let geometry: GeometryProxy
    
    @ViewBuilder
    func saveButton() -> some View {
        Button(baseViewModel.isFavorite(session.id) ? "Remove" : "Save") {
            withAnimation {
                baseViewModel.updateFavoriteSession(sessionId: session.id)
            }
        }
        .capsuleBackgroundView(color: .white)
        .foregroundStyle(.black)
    }
    
    @ViewBuilder
    func timeView() -> some View {
        HStack(spacing: 10) {
            Text(session.startDate.formatted(date: .abbreviated, time: .omitted))
                .capsuleBackgroundView(color: .white.opacity(0.1))
            
            Text(session.startDate.formatted(date: .omitted, time: .shortened))
                .capsuleBackgroundView(color: .white.opacity(0.1))

            Spacer()
        }
        .semiboldAppFont(size: 14)

    }
    
    @ViewBuilder
    func speakerRow(speaker: Speaker) -> some View {
        if speaker.name != "You" {
            HStack {
                RemoteImageView(url: speaker.imageUrl)
                    .scaledToFill()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                
                Text(speaker.name)
                    .font(.subheadline)
            }
            .padding(.bottom, 4)
        } else {
            Spacer()
                .frame(height: 34)
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                
                timeView()
                
                Spacer()
                
                Text(session.title)
                    .semiboldAppFont(size: 22)
                    .padding(.bottom, 10)
                    .multilineTextAlignment(.leading)
                
                if let name = baseViewModel.getLocation(with: session.locationId)?.name {
                    Label(name, image: ImageNames.location)
                        .semiboldAppFont(size: 14)
                }

                ForEach(baseViewModel.getSpeakers(with: session.speakerIds)) { speaker in
                    speakerRow(speaker: speaker)
                }
            }
            .overlay(alignment: .bottomTrailing) {
                saveButton()
            }
            .padding(16)
        }
        .foregroundStyle(.white)
        .frame(width: geometry.size.width * widthScale, height: 250)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    .linearGradient(
                        colors: [Color(.cardBottom), Color(.cardTop)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
        )
    }
}
