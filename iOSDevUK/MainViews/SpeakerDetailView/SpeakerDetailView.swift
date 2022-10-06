//
//  SpeakerDetailView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct SpeakerDetailView: View {
    @StateObject private var viewModel: SpeakerDetailViewModel

    var speaker: Speaker!
    
    init(speaker: Speaker, viewModel: SpeakerDetailViewModel = SpeakerDetailViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.speaker = speaker
    }
    
    
    @ViewBuilder
    private func headerView() -> some View {
        
        HStack {
            RemoteImage(urlString: speaker.imageLink)
                .cornerRadius(15)
                .frame(width: 100, height: 170)
                .aspectRatio(contentMode: .fit)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(speaker.name)
                    .font(.title)
                    .minimumScaleFactor(0.7)
                
                Button("Twitter \(speaker.twitterId)") {
                    viewModel.showTwitterAccount(speaker.twitterId)
                }
                
                Button("LinkedIn") {
                    viewModel.showLinkedInAccount(speaker.linkedIn)
                }
            }
            .padding(.bottom, 20)
        }
    }
    
    @ViewBuilder
    private func descriptionView() -> some View {
        Text("Biography")
            .font(.title3)
            .foregroundColor(.gray)
            .bold()
            .padding([.top, .bottom])

        Text(speaker.biography)
            .multilineTextAlignment(.leading)
            .padding(.bottom, 10)
    }
    
    @ViewBuilder
    private func sessionsView() -> some View {
        
        Text("Session(s)")
            .font(.title3)
            .foregroundColor(.gray)
            .bold()
            .padding([.top, .bottom])
    }
    
    @ViewBuilder
    private func main() -> some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                headerView()
                Divider()
                descriptionView()
                Divider()
                sessionsView()
            }
        }
        .scrollIndicators(.hidden)
        .padding()
    }

    var body: some View {
        main()
            .navigationTitle(speaker.name)
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await viewModel.getSessionsFor(speaker.id)
            }
    }
}

struct SpeakerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SpeakerDetailView(speaker: DummyData.speaker)
    }
}
