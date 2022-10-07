//
//  SpeakerDetailView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct SpeakerDetailView: View {
    @StateObject private var viewModel: SpeakerDetailViewModel
    
    init(speaker: Speaker) {
        self.init(viewModel: SpeakerDetailViewModel(speaker: speaker))
    }
    
    private init(viewModel: SpeakerDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    
    @ViewBuilder
    private func headerView() -> some View {
        
        HStack {
            RemoteImage(urlString: viewModel.speaker.imageLink)
                .cornerRadius(15)
                .frame(width: 100, height: 170)
                .aspectRatio(contentMode: .fit)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(viewModel.speaker.name)
                    .font(.title)
                    .minimumScaleFactor(0.7)
                
                Button("Twitter \(viewModel.speaker.twitterId)") {
                    viewModel.showTwitterAccount()
                }
                
                Button("LinkedIn") {
                    viewModel.showLinkedInAccount()
                }
            }
            .padding(.bottom, 20)
        }
    }
    
    @ViewBuilder
    private func descriptionView() -> some View {
        Text("Biography")
            .font(.title3)
            .bold()
            .foregroundColor(.gray)
            .padding(.vertical)
        
        Text(viewModel.speaker.biography)
            .multilineTextAlignment(.leading)
            .padding(.bottom, 10)
    }
    
    @ViewBuilder
    private func sessionsView() -> some View {
        
        Text("Session(s)")
            .font(.title3)
            .foregroundColor(.gray)
            .bold()
            .padding(.vertical, 10)
        
        ForEach(viewModel.sessions) { session in
            NavigationLink(destination: {
                SessionDetailView(session: session)
            }, label: {
                Text("\(session.title) - \(session.startDate.weekDayTime())")
                    .font(.title3)
                    .bold()
                    .padding(.bottom, 10)
            })
        }
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
            .task(viewModel.getSpeakerSessions)
    }
}

struct SpeakerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SpeakerDetailView(speaker: DummyData.speaker)
        }
    }
}
