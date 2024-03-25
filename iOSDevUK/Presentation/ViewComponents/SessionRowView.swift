//
//  NewSessionCard.swift
//  iOSDevUK
//
//  Created by David Kababyan on 16/03/2024.
//

import SwiftUI

struct SessionRowView: View {
    @EnvironmentObject var baseViewModel: BaseViewModel
    
    let session: Session
    let showSpeakers: Bool
    var action: (() -> Void)?

    init(
        session: Session,
        showSpeakers: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.session = session
        self.showSpeakers = showSpeakers
        self.action = action
    }
    
    @ViewBuilder
    private func speakerRowView(speaker: Speaker) -> some View {
        HStack(spacing: 8) {
            RemoteImageView(url: speaker.imageUrl)
                .scaledToFit()
                .frame(width: 24, height: 24)
                .clipShape(Circle())
            
            Text(speaker.name)
                .foregroundStyle(Color(.mainText))
                .minimumScaleFactor(0.8)
                .lineLimit(2)
                .appFont(size: 14)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            
            HStack {
                Text("\(session.duration)")
                    .appFont(size: 14)
                    .foregroundStyle(Color(.mainText))
                
                Spacer()
                
                if let action = action {
                    Button(action: action) {
                        Image(systemName: baseViewModel.isFavorite(session.id) ? ImageNames.bookmarkFill : ImageNames.bookmark)
                    }
                }
            }
            
            Text("\(session.title)")
                .boldAppFont(size: 18)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color(.mainText))
            
            if let location = baseViewModel.getLocation(with: session.locationId) {
                Label("\(location.name)", image: ImageNames.location)
                    .tint(Color(.purple300))
                    .capsuleBackgroundView(height: 30)
            }
            
            if showSpeakers && !baseViewModel.getSpeakers(with: session.speakerIds).isEmpty {
                HStack(spacing: 10) {
                    ForEach(baseViewModel.getSpeakers(with: session.speakerIds)) { speaker in
                        speakerRowView(speaker: speaker)
                    }
                }
            }
        }
        .roundBackgroundView(color: Color(.cardBackground))
        .padding(.bottom, 10)
    }
}

#Preview {
    SessionRowView(session: DummyData.sessions.first!)
}
