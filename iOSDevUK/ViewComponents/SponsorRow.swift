//
//  SponsorRow.swift
//  iOSDevUK
//
//  Created by David Kababyan on 27/10/2022.
//

import SwiftUI

struct SponsorRow: View {
    @Environment(\.colorScheme) var colorScheme
    
    private let sponsor: Sponsor
    
    init(sponsor: Sponsor) {
        self.sponsor = sponsor
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            RemoteImageView(url: colorScheme == .dark ? sponsor.imageUrlDark : sponsor.imageUrlLight)
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
                .frame(maxWidth: .infinity)
            
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 50)
                    .foregroundColor(sponsor.sponsorCategory.color.opacity(30))
                    .background(RoundedRectangle(cornerRadius: 10).stroke(sponsor.sponsorCategory.color.gradient))

                Text(sponsor.name)
                    .font(.title2)
                    .foregroundColor(.black)
            }
            
            Text(sponsor.tagline)
                .multilineTextAlignment(.leading)
            
            Text(sponsor.urlText)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct SponsorRow_Previews: PreviewProvider {
    static var previews: some View {
        SponsorRow(sponsor: DummyData.sponsors[0])
    }
}
