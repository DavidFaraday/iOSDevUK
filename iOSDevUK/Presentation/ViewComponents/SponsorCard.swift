//
//  SponsorCard.swift
//  iOSDevUK
//
//  Created by David Kababyan on 07/08/2023.
//

import SwiftUI

struct SponsorCard: View {
    @Environment(\.colorScheme) var colorScheme
    let height: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 160 : 100

    let sponsor: Sponsor
    
    var body: some View {
        VStack {
            RemoteImageView(url: colorScheme == .dark ? sponsor.imageUrlDark : sponsor.imageUrlLight)
                .aspectRatio(contentMode: .fit)
                .frame(height: height)
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 10)
        }
        .roundBackgroundView(color: Color(.speakerCardBackground))
    }
}

struct SponsorCard_Previews: PreviewProvider {
    static var previews: some View {
        SponsorCard(sponsor: DummyData.sponsors[0])
    }
}
