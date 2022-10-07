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
        VStack(spacing: 0) {
            ForEach(viewModel.speakers ?? []) { speaker in
                RemoteImage(urlString: speaker.imageLink)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
                    .clipShape(Circle())
            }
        }
        .padding(.trailing, 10)
    }
    
    @ViewBuilder
    private func speakerNameView() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            ForEach(viewModel.speakers ?? []) { speaker in
                Text(speaker.name)
                    .font(.subheadline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
        }
    }
    
    @ViewBuilder
    private func cardContent() -> some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 10) {
                Text(viewModel.session.title)
                    .font(.title2)
                    .lineLimit(2)
                    .minimumScaleFactor(0.6)

                speakerNameView()

                Spacer()
                
                Text("\(viewModel.location != nil ? viewModel.location!.name : "") - \(viewModel.session.startDate.weekDayTime())")
                    .font(.subheadline)
                    .lineLimit(2)
                    .minimumScaleFactor(0.6)
                    .padding(.bottom, 10)
            }
            .foregroundColor(.white)
            .multilineTextAlignment(.leading)
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
                    .foregroundColor(.blue.opacity(0.7))
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
    }
}

struct SessionCardView_Previews: PreviewProvider {
    static var previews: some View {
        SessionCardView(session: DummyData.session)
    }
}
