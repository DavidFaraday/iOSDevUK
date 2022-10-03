//
//  SessionDetailView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 03/10/2022.
//

import SwiftUI

struct SessionDetailView: View {
    @StateObject private var viewModel: SessionDetailViewModel
    
    var session: Session!
    
    init(session: Session, viewModel: SessionDetailViewModel = SessionDetailViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.session = session
    }
    
    
    @ViewBuilder
    private func headerView() -> some View {
        
        ZStack(alignment: .leading) {
            RemoteImage(urlString: "https://picsum.photos/1500/1000")
            //                .frame(maxHeight: 500)
                .aspectRatio(contentMode: .fit)
            
            Text(session.title)
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.leading)
        }
    }
    
    @ViewBuilder
    private func descriptionView() -> some View {
        VStack(alignment: .leading) {
            Text("Description")
                .font(.title3)
                .foregroundColor(.gray)
                .bold()
                .padding([.top, .bottom])
            
            Text(session.content)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 10)
        }
        .padding([.leading, .trailing])
    }
    
    @ViewBuilder
    private func speakersView() -> some View {
        
        VStack(alignment: .leading) {
            Text("Speaker(s)")
                .font(.title3)
                .foregroundColor(.gray)
                .bold()
                .padding(.bottom)
            
            ForEach(viewModel.speakers) { speaker in
                //TODO: Should be button
                Text(speaker.name)
                    .font(.title3)
            }
        }
        .padding([.leading, .trailing])
    }
    
    @ViewBuilder
    private func locationView() -> some View {
        
        VStack(alignment: .leading) {
            Text("Location")
                .font(.title3)
                .foregroundColor(.gray)
                .bold()
                .padding(.bottom)

            //TODO: Should be button
            Text(viewModel.location?.name ?? "")
        }
        .padding()
    }
    
    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {

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
            .ignoresSafeArea(SafeAreaRegions.all)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
            }

            .task {
                await viewModel.loadData(for: session)
            }
    }
}

struct SessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SessionDetailView(session: Session.dummySession)
    }
}
