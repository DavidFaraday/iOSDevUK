//
//  SessionDetailView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 03/10/2022.
//

import SwiftUI

struct SessionDetailView: View {
    @StateObject private var viewModel: SessionDetailViewModel
    
    init(session: Session) {
        self.init(viewModel: SessionDetailViewModel(session: session))
    }
    
    private init(viewModel: SessionDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @ViewBuilder
    private func headerView() -> some View {
        ZStack(alignment: .leading) {
            Image("img1")
                .resizable()
                .frame(height: 250)
                .aspectRatio(contentMode: .fit)
            
            Text(viewModel.session.title)
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding([.horizontal, .top])
        }
    }
    
    @ViewBuilder
    private func descriptionView() -> some View {
        VStack(alignment: .leading) {
            Text("Description")
                .font(.title3)
                .foregroundColor(.gray)
                .bold()
                .padding(.vertical)
            
            Text(viewModel.session.content)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 10)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func speakersView() -> some View {
        
        VStack(alignment: .leading) {
            Text("Speaker(s)")
                .font(.title3)
                .foregroundColor(.gray)
                .bold()
                .padding(.bottom)
            
            ForEach(viewModel.speakers ?? []) { speaker in
                NavigationLink {
                    SpeakerDetailView(speaker: speaker)
                } label: {
                    Text(speaker.name)
                        .font(.title3)
                        .padding(.bottom, 5)
                }
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func locationView() -> some View {
        
        VStack(alignment: .leading) {
            Text("Location")
                .font(.title3)
                .foregroundColor(.gray)
                .bold()
                .padding(.bottom)

            Button {
                print("go to location view")
            } label: {
                LocationRowView(location: viewModel.location)
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        Button("Add to list") {
            print("Added to my list")
        }
    }

    
    @ViewBuilder
    private func main() -> some View {

        ScrollView {
            VStack(alignment: .leading) {
                headerView()
                descriptionView()
                speakersView()
                locationView()
            }
        }
        .scrollIndicators(.hidden)
    }
    
    var body: some View {
        main()
            .edgesIgnoringSafeArea(.top)
            .task(viewModel.fetchSpeakers)
            .task(viewModel.fetchLocation)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
            }
    }
}

struct SessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SessionDetailView(session: DummyData.session)
        }
    }
}
