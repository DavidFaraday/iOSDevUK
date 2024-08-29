//
//  SponsorRow.swift
//  iOSDevUK
//
//  Created by David Kababyan on 27/10/2022.
//

import SwiftUI

struct SponsorRow: View {
    @Environment(\.colorScheme) var colorScheme
    
    let sponsor: Sponsor
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            RemoteImageView(url: colorScheme == .dark ? sponsor.imageUrlDark : sponsor.imageUrlLight)
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
            
            Divider()
                .frame(height: 2)
                .overlay(Color(.linkButton))
                .padding(.vertical, 10)

            Text(sponsor.tagline)
                .multilineTextAlignment(.leading)
                .appFont(size: 18)
            
            Text("\(sponsor.sponsorCategory) sponsor. \(sponsor.sponsorshipNote ?? "")")
            
            if let url = sponsor.webUrl {
                Link(destination: url) {
                    Text(sponsor.urlText)
                }
                .buttonStyle(.appPrimary)
                .padding(.vertical, 10)
            }
        }
        .roundBackgroundView(color: Color(.cardBackground))
    }
}

struct SponsorRow_Previews: PreviewProvider {
    static var previews: some View {
        SponsorRow(sponsor: DummyData.sponsors[0])
    }
}
