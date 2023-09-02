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
    let location: Location?
    let speakers: [Speaker]
    
    init(session: Session,
         isFavorite: Bool = false,
         location: Location?,
         speakers: [Speaker]) {
        
        self.session = session
        self.isFavorite = isFavorite
        self.location = location
        self.speakers = speakers
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
            
            if !self.speakers.isEmpty {
                Text(viewModel.speakerNames ?? " ")
                    .multilineTextAlignment(.leading)
                    .padding(.trailing)
                    .foregroundColor(.accentColor)
                    .fixedSize()
            }
            
            Text(location?.name ?? "")
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
        .onAppear {
            viewModel.setSpeakers(speakers: self.speakers)
        }
    }
}
