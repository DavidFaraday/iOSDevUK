//
//  SessionRowView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 07/10/2022.
//

import SwiftUI

struct SessionRowView: View {
    @StateObject private var viewModel = SessionRowViewModel()
    
    let session: Session
    
    var body: some View {
        HStack {
            VStack {
                Text(session.startDate.time)
                    .foregroundColor(.accentColor)
                Text(session.endDate.time)
            }
            .font(.caption)
            .foregroundColor(.gray)

            VStack(alignment: .leading, spacing: 10) {
                Text(session.title)
                    .font(.title3)
                
                if let names = viewModel.speakerNames {
                    Text(names)
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.8)
                        .padding(.trailing)
                        .foregroundColor(.accentColor)
                }
                
                Text(viewModel.location?.name ?? "")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .minimumScaleFactor(0.8)
            .lineLimit(2)
        }
        .task {
            await viewModel.fetchSpeakers(with: session.speakerIds)
            await viewModel.fetchLocation(with: session.locationId)
        }
    }
}

struct SessionRowView_Previews: PreviewProvider {
    static var previews: some View {
        SessionRowView(session: DummyData.sessions[0])
    }
}
