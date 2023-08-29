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
    private func socialMediaRow(imageName: String, label: String) -> some View {
        HStack(spacing: 5) {
            Image(imageName)
                .resizable()
                .frame(width: 30, height: 30)
            Text(label)
                .minimumScaleFactor(0.7)
                .multilineTextAlignment(.leading)
        }
    }
    
    
    @ViewBuilder
    private func headerView() -> some View {
        HStack {
            RemoteImageView(url: viewModel.speaker.imageUrl)
                .cornerRadius(16)
                .scaledToFill()
                .frame(width: 130, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(
                    RoundedRectangle(cornerRadius: 16).stroke(Color(ColorNames.primary), lineWidth: 4)
                )
            
            VStack(alignment: .leading, spacing: 10) {
                Text(viewModel.speaker.name)
                    .font(.title)
                    .minimumScaleFactor(0.7)

                if let twitterId = viewModel.speaker.twitterId, let twitterUrl = URL(string: "\(BaseUrl.twitter)\(twitterId)") {
                    Link(destination: twitterUrl) {
                        socialMediaRow(imageName: ImageNames.twitter, label: twitterId)
                    }
                }

                if let linkedIn = viewModel.speaker.linkedIn, let linkedInUrl = URL(string: "\(BaseUrl.linkedIn)\(linkedIn)") {
                    
                    Link(destination: linkedInUrl) {
                        socialMediaRow(imageName: ImageNames.linkedIn, label: linkedIn)
                    }
                }
                
                Spacer()
            }
            .padding(.bottom, 20)
        }
    }
    
    @ViewBuilder
    private func descriptionView() -> some View {
        Text(AppStrings.biography)
            .font(.title2)
            .bold()
            .foregroundColor(Color(ColorNames.secondary))
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
            
            Text(AppStrings.session)
                .font(.title3)
                .foregroundColor(Color(ColorNames.secondary))
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
    private func webLinksView() -> some View {
        if !viewModel.webLinks.isEmpty {
            Divider()
                        
            Text(AppStrings.webLinks)
                .font(.title3)
                .foregroundColor(Color(ColorNames.secondary))
                .padding(.top)
                .padding(.bottom, 3)

            ForEach(viewModel.webLinks, id: \.self) { link in
                if let url = link.webUrl {
                    Link(destination: url) {
                        Text(link.name)
                            .padding(.bottom, 5)
                    }
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
                webLinksView()
                sessionsView()
            }
            .padding()
        }
        .scrollIndicators(.hidden)
        .alert(isPresented: $viewModel.showError, content: {
            Alert(title: Text(AppStrings.error), message: Text(viewModel.fetchError?.localizedDescription ?? ""), dismissButton: .default(Text(AppStrings.ok)))
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
