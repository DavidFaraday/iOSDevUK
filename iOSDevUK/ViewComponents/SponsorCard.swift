//
//  SponsorCard.swift
//  iOSDevUK
//
//  Created by David Kababyan on 07/08/2023.
//

import SwiftUI

struct SponsorCard: View {
    @Environment(\.colorScheme) var colorScheme
    
    let sponsor: Sponsor
    
    var body: some View {
        VStack(alignment: .leading) {
            RemoteImageView(url: colorScheme == .dark ? sponsor.imageUrlDark : sponsor.imageUrlLight)
                .aspectRatio(contentMode: .fit)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(sponsor.sponsorCategory.color).shadow(radius: 20))
    }
}

struct SponsorCard_Previews: PreviewProvider {
    static var previews: some View {
        SponsorCard(sponsor: DummyData.sponsors[0])
    }
}
