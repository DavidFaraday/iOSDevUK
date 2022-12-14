//
//  SessionRowForLocalSession.swift
//  iOSDevUK
//
//  Created by David Kababyan on 05/11/2022.
//

import SwiftUI

struct SessionRowForLocalSession: View {
    @StateObject private var viewModel = SessionRowViewModel()
    let session: SavedSession
    
    var body: some View {
        HStack {
            VStack {
                Text("\(session.startDate?.time ?? "Loading...")")
                Text("\(session.endDate?.time ?? "Loading...")")
            }
            .font(.caption)
            .foregroundColor(.gray)

            VStack(alignment: .leading, spacing: 10) {
                Text(session.title ?? "Loading...")
                    .font(.title3)
                
                if let name = viewModel.location?.name {
                    Text(name)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .minimumScaleFactor(0.8)
            .lineLimit(2)
        }
        .task {
            await viewModel.fetchLocation(with: session.locationId)
        }
    }
}
