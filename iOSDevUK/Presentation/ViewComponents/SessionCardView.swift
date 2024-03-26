//
//  SessionCardView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/09/2022.
//

import SwiftUI

struct SessionCardView: View {       
    @StateObject private var viewModel = SessionRowViewModel()

    let session: Session
    let speakers: [Speaker]?
    let location: Location?
        
    @ViewBuilder
    private func speakerImageView() -> some View {
        VStack(spacing: 5) {
            ForEach(speakers?.prefix(3) ?? []) { speaker in
                if speaker.name != "You" {
                    RemoteImageView(url: speaker.imageUrl)
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                }
            }
        }
        .padding(.trailing, 10)
    }
    
    @ViewBuilder
    private func cardContent() -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(session.title)
                    .font(.title2)
                    .padding(.bottom, 10)

                if let names = viewModel.speakerNames {
                    Text(names)
                        .font(.subheadline)
                        .lineLimit(2)
                        .minimumScaleFactor(0.8)
                }

                Spacer()
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(location?.name ?? "")
                    Text(session.duration)
                }
                .font(.subheadline)
                .padding(.bottom, 10)
            }
            .foregroundColor(.white)
            .multilineTextAlignment(.leading)
            .minimumScaleFactor(0.6)
            .lineLimit(2)
            .bold()

            Spacer()
            speakerImageView()
        }
        .padding([.top, .leading])
    }
    
    @ViewBuilder
    private func main() -> some View {
        VStack {
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(Color(.primary).gradient)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                cardContent()
            }
        }
    }
    
    var body: some View {
        main()
            .onAppear {
                viewModel.setSpeakers(speakers: speakers ?? [])
            }
            .frame(height: 150)
    }
}
