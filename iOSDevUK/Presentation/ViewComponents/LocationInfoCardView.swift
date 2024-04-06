//
//  LocationInfoCardView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 06/04/2024.
//

import SwiftUI

struct LocationInfoCardView: View {
    let location: Location
    let action: () -> Void
    
    init(location: Location, action: @escaping () -> Void) {
        self.location = location
        self.action = action
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(location.name)
                .semiboldAppFont(size: 18)
                .foregroundStyle(Color(.mainText))

            if let note = location.note {
                Text(note)
                    .appFont(size: 15)
                    .foregroundStyle(Color(.textGrey))
            }
            
            if let url = location.webLink?.webUrl {
                Link("Website", destination: url)
                    .tint(Color(.purple300))
                    .appFont(size: 14)
            }
            
            Button("Navigate", action: action)
                .buttonStyle(.appPrimary)
                .padding(.vertical, 5)
        }
        .roundBackgroundView(color: Color(.cardBackground))
    }
}

#Preview {
    LocationInfoCardView(location: DummyData.location) { }
}
