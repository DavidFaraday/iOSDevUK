//
//  SessionCardView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/09/2022.
//

import SwiftUI

struct SessionCardView: View {       
    @StateObject private var viewModel: SessionCardViewModel

    init(session: Session) {
        self.init(viewModel: SessionCardViewModel(session: session))
    }
    
    private init(viewModel: SessionCardViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    
    @ViewBuilder
    private func speakerImageView() -> some View {
        VStack(spacing: 5) {
            ForEach(viewModel.speakers?.prefix(3) ?? []) { speaker in
                RemoteImageView(url: speaker.imageUrl)
                    .frame(width: 40, height: 40)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            }
        }
        .padding(.trailing, 10)
    }
    
    @ViewBuilder
    private func cardContent() -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(viewModel.session.title)
                    .font(.title2)
                    .padding(.bottom, 10)

                if let speakers = viewModel.speakers {
                    Text(viewModel.speakerNames(from: speakers))
                        .font(.subheadline)
                        .lineLimit(2)
                        .minimumScaleFactor(0.8)
                }

                Spacer()
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(viewModel.location?.name ?? "")
                    Text(viewModel.session.duration)
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
                    .fill(Color("primary").gradient)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                cardContent()
            }
        }
    }
    
    var body: some View {
        main()
            .task(viewModel.fetchSpeakers)
            .task(viewModel.fetchLocation)
            .frame(height: 150)
    }
}

struct SessionCardView_Previews: PreviewProvider {
    static var previews: some View {
        SessionCardView(session: DummyData.session)
    }
}
