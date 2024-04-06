//
//  SpeakerDetailView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct SpeakerDetailScreen: View {
    @StateObject private var viewModel: SpeakerDetailViewModel
    @EnvironmentObject var baseViewModel: BaseViewModel
    
    init(speaker: Speaker) {
        self.init(viewModel: SpeakerDetailViewModel(speaker: speaker))
    }
    
    private init(viewModel: SpeakerDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    
    @ViewBuilder
    private func socialMediaView() -> some View {
        HStack {
            if let twitterId = viewModel.speaker.twitterId,
                let twitterUrl = URL(string: "\(BaseUrl.twitter)\(twitterId)") {
                Link(destination: twitterUrl) {
                    Label(twitterId, image: ImageNames.twitter)
                        .tint(Color(.purple300))
                }
                .capsuleBackgroundView()
            }
            
            if let linkedIn = viewModel.speaker.linkedIn,
                let linkedInUrl = URL(string: "\(BaseUrl.linkedIn)\(linkedIn)") {
                
                Link(destination: linkedInUrl) {
                    Label("LinkedIn", image: ImageNames.linkedIn)
                        .tint(Color(.purple300))
                }
                .capsuleBackgroundView()
            }
        }
        .padding(.bottom, 20)
    }
    
    
    @ViewBuilder
    private func headerView() -> some View {
        VStack(spacing: 15) {
            Spacer()
            
            RemoteImageView(url: viewModel.speaker.imageUrl)
                .scaledToFill()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .padding(.top, 20)
            
            Text(viewModel.speaker.name)
                .boldAppFont(size: 24)
            
            if let position = viewModel.speaker.currentPosition {
                Text(position)
                    .foregroundStyle(Color(.textGrey))
                    .minimumScaleFactor(0.8)
                    .semiboldAppFont(size: 16)
            }

            socialMediaView()
        }
        .frame(minHeight: 340)
        .frame(maxWidth: .infinity)
        .roundBackgroundView(color: Color(.cardBackground))
    }
    
    @ViewBuilder
    private func descriptionView() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text(AppStrings.biography)
                .semiboldAppFont(size: 18)
                .foregroundColor(Color(.textBody))
                .padding(.top, 20)
            
            Text(viewModel.speaker.biography)
                .appFont(size: 16)
                .foregroundColor(Color(.textGrey))
        }
        .padding(.horizontal, 16)
    }

    
    @ViewBuilder
    private func sessionsView() -> some View {
        if !viewModel.sessions.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                Divider()
                    .frame(height: 2)
                    .overlay(Color(.linkButton))
                    .padding(.vertical, 10)

                Text(AppStrings.session)
                    .boldAppFont(size: 18)
                    .foregroundColor(Color(.textGrey))
                
                ForEach(viewModel.sessions) { session in
                    NavigationLink(value: Destination.session(session)) {
                        SessionRowView(
                            session: session,
                            showSpeakers: true
                        ) {
                            baseViewModel.updateFavoriteSession(sessionId: session.id)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }

    @ViewBuilder
    private func webLinksView() -> some View {
        if !viewModel.webLinks.isEmpty {
            VStack(alignment: .leading, spacing: 10) {
                Divider()
                    .frame(height: 2)
                    .overlay(Color(.linkButton))
                    .padding(.vertical, 10)
                
                Text(AppStrings.webLinks)
                    .boldAppFont(size: 18)
                    .foregroundColor(Color(.textGrey))
                
                ForEach(viewModel.webLinks, id: \.self) { link in
                    if let url = link.webUrl {
                        Link(destination: url) {
                            InfoRowView(text: link.name, imageName: ImageNames.link)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    
    @ViewBuilder
    private func main() -> some View {
        ScrollView {
            headerView()
            descriptionView()
            
            webLinksView()
            sessionsView()
        }
        .ignoresSafeArea(edges: .top)
        .scrollIndicators(.hidden)
        .alert(isPresented: $viewModel.showError, content: {
            Alert(title: Text(AppStrings.error), message: Text(viewModel.fetchError?.localizedDescription ?? ""), dismissButton: .default(Text(AppStrings.ok)))
        })
    }
    
    var body: some View {
        main()
            .task {
                await viewModel.getSpeakerSessions()
            }
    }
}

struct SpeakerDetailView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            SpeakerDetailScreen(speaker: DummyData.speakers[0])
        }
    }
}
