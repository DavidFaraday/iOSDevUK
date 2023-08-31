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
    let isFavorite: Bool
    
    init(session: Session, isFavorite: Bool = false) {
        self.session = session
        self.isFavorite = isFavorite
    }
    
    @ViewBuilder
    private func timeView() -> some View {
        VStack {
            Text(session.startDate.time)
                .foregroundColor(.accentColor)
            Text(session.endDate.time)
        }
        .font(.caption)
        .foregroundColor(.gray)
        .fixedSize()
    }
    
    private func nameView() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(session.title)
                .font(.headline)
                .minimumScaleFactor(0.6)
                .lineLimit(3)
            
            if let names = viewModel.speakerNames {
                Text(names)
                    .multilineTextAlignment(.leading)
                    .padding(.trailing)
                    .foregroundColor(.accentColor)
                    .fixedSize()
            }
            
            Text(viewModel.location?.name ?? "")
                .font(.caption)
                .foregroundColor(.gray)
                .fixedSize()
        }
        .minimumScaleFactor(0.8)
        .lineLimit(2)
    }
    
    
    var body: some View {
        HStack {
            timeView()
            
            nameView()
            Spacer()
            
            if isFavorite {
                Image(systemName: ImageNames.bookmarkFill)
                    .foregroundStyle(Color(ColorNames.primary))
            }
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
