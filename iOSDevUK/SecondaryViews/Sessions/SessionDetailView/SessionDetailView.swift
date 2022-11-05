//
//  SessionDetailView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 03/10/2022.
//

import SwiftUI
import CoreData

struct SessionDetailView: View {
    @Environment(\.managedObjectContext) var moc
    
    @StateObject private var viewModel: SessionDetailViewModel
    @State private var showMapView = false
    
    init(session: Session) {
        self.init(viewModel: SessionDetailViewModel(session: session))
    }
    
    private init(viewModel: SessionDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @ViewBuilder
    private func headerView() -> some View {
        ZStack(alignment: .leading) {
            Image(ImageNames.img1)
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
                guard viewModel.location != nil else { return }
                showMapView = true
            } label: {
                Text(viewModel.location?.name ?? "Unknown location")
                    .font(.subheadline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        Button("Add to list", action: addToMySession)
    }

    
    @ViewBuilder
    private func main() -> some View {

        ScrollView {
            VStack(alignment: .leading) {
                headerView()
                descriptionView()
                if let speakers = viewModel.speakers, !speakers.isEmpty {
                    speakersView()
                }
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
            .sheet(isPresented: $showMapView) {
                MapView(allLocations: [viewModel.location!])
            }
    }
    
    private func addToMySession() {
        let mySession = viewModel.session
        
        let session = SavedSession(context: moc)
        session.title = mySession.title
        session.id = mySession.id
        session.startDate = mySession.startDate
        session.endDate = mySession.endDate
        session.content = mySession.content
        session.startDateName = mySession.startingDay
        session.locationName = viewModel.location?.name
        
        do {
            try moc.save()
        } catch {
            print("Error saving session to CD")
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
