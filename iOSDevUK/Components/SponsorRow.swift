//
//  SponsorRow.swift
//  iOSDevUK
//
//  Created by David Kababyan on 27/10/2022.
//

import SwiftUI

struct SponsorRow: View {
    private let sponsor: Sponsor
    
    init(sponsor: Sponsor) {
        self.sponsor = sponsor
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            RemoteImage(urlString: sponsor.imageLink ?? "")
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .aspectRatio(contentMode: .fill)
            
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 50)
                    .foregroundColor(sponsor.sponsorCategory.color)
                
                Text("\(sponsor.name)")
                    .font(.title2)
            }
            Text(sponsor.tagline)
                .multilineTextAlignment(.leading)
            
            if let urlText = sponsor.urlText {
                Text(urlText)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct SponsorRow_Previews: PreviewProvider {
    static var previews: some View {
        SponsorRow(sponsor: DummyData.sponsors[0])
    }
}
