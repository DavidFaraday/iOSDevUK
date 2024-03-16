//
//  NewSessionCard.swift
//  iOSDevUK
//
//  Created by David Kababyan on 16/03/2024.
//

import SwiftUI

struct NewSessionCard: View {
    @EnvironmentObject var baseViewModel: BaseViewModel

    let session: Session
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            
            HStack {
                Text("\(session.duration)")
                    .appFont(size: 14)
                    .foregroundStyle(Color(.mainText))
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: ImageNames.bookmark)
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
        }
        .roundBackgroundView(color: Color(.speakerCardBackground))
        .padding(.bottom, 10)
    }
}

#Preview {
    NewSessionCard(session: DummyData.sessions.first!)
}
