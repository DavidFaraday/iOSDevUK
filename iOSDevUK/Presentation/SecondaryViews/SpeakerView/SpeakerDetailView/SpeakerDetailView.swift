//
//  SpeakerDetailView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct SpeakerDetailView: View {
    @StateObject private var viewModel: SpeakerDetailViewModel
    @EnvironmentObject var baseViewModel: BaseViewModel
    
    init(speaker: Speaker) {
        self.init(viewModel: SpeakerDetailViewModel(speaker: speaker))
    }
    
    private init(viewModel: SpeakerDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @ViewBuilder
    private func headerView() -> some View {
        HStack {
            RemoteImageView(url: viewModel.speaker.imageUrl)
                .cornerRadius(16)
                .scaledToFit()
                .frame(width: 160, height: 160)
                .overlay(
                    RoundedRectangle(cornerRadius: 16).stroke(Color("primary"), lineWidth: 6)
                )
            
            VStack(alignment: .leading, spacing: 10) {
                Text(viewModel.speaker.name)
                    .font(.title)
                    .minimumScaleFactor(0.7)

                if !viewModel.speaker.twitterId.isEmpty {
                    if let twitterUrl = URL(string: "\(BaseUrl.twitter)\(viewModel.speaker.twitterId)") {
                        Link("Twitter: @\(viewModel.speaker.twitterId)", destination: twitterUrl)
                    }
                }
                
                if !viewModel.speaker.linkedIn.isEmpty {
                    if let linkedInUrl = URL(string: "\(BaseUrl.linkedIn)\(viewModel.speaker.linkedIn)") {
                        Link("LinkedIn: \(viewModel.speaker.linkedIn)", destination: linkedInUrl)
                    }
                }
                
                Spacer()
            }
            .padding(.bottom, 20)
        }
    }
    
    @ViewBuilder
    private func descriptionView() -> some View {
        Text("Biography")
            .font(.title2)
            .bold()
            .foregroundColor(Color("secondary"))
            .padding(.top)
            .padding(.bottom, 5)
        
        Text(viewModel.speaker.biography)
            .multilineTextAlignment(.leading)
            .padding(.bottom, 10)
    }
    
    @ViewBuilder
    private func sessionsRaw(session: Session) -> some View {
        VStack(alignment: .leading) {
            Text("\(session.title)")
                .font(.subheadline)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                
            Text("\(session.duration)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.bottom, 10)
    }

    
    @ViewBuilder
    private func sessionsView() -> some View {
        if !viewModel.sessions.isEmpty {
            Divider()
            
            Text("Session(s)")
                .font(.title3)
                .foregroundColor(.gray)
                .bold()
                .padding(.top)
                .padding(.bottom, 5)
            
            ForEach(viewModel.sessions) { session in
                NavigationLink(value: Destination.session(session)) {
                    sessionsRaw(session: session)
                }
            }
        }
    }
    
    @ViewBuilder
    private func main() -> some View {
        ScrollView {
            VStack(alignment: .leading) {
                headerView()
                Divider()
                descriptionView()
                sessionsView()
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .alert(isPresented: $viewModel.showError, content: {
            Alert(title: Text("Error!"), message: Text(viewModel.fetchError?.localizedDescription ?? ""), dismissButton: .default(Text("OK")))
        })
    }
    
    var body: some View {
        main()
            .navigationBarTitleDisplayMode(.inline)
            .task(viewModel.getSpeakerSessions)
    }
}

struct SpeakerDetailView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            SpeakerDetailView(speaker: DummyData.speakers[0])
        }
    }
}
