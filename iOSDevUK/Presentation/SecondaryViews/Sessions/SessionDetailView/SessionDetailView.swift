//
//  SessionDetailView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 03/10/2022.
//

import SwiftUI

struct SessionDetailView: View {
    @EnvironmentObject var baseViewModel: BaseViewModel
    
    let sessionDetail: SessionDetail
    
    @ViewBuilder
    private func headerView() -> some View {
        ZStack(alignment: .bottomLeading) {
            Image(ImageNames.sessionImage)
                .resizable()
                .frame(height: 250)
                .aspectRatio(contentMode: .fit)
            
            HStack(alignment: .center) {
                Text(sessionDetail.session.title)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                
                Spacer()
            }
            .background(.ultraThinMaterial.opacity(0.6))
        }
    }
    
    @ViewBuilder
    private func timeView() -> some View {
        VStack(alignment: .leading) {
            Text(AppStrings.time)
                .font(.title2)
                .foregroundColor(Color(ColorNames.secondary))
                .bold()
                .padding(.top)
                .padding(.bottom, 5)
            
            Text(sessionDetail.session.duration)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func descriptionView() -> some View {
        VStack(alignment: .leading) {
            Text(AppStrings.description)
                .font(.title2)
                .foregroundColor(Color(ColorNames.secondary))
                .bold()
                .padding(.top)
                .padding(.bottom, 5)
            
            Text(sessionDetail.session.content)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 10)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func speakersView() -> some View {
        
        VStack(alignment: .leading) {
            Text(AppStrings.speaker)
                .font(.title3)
                .foregroundColor(Color(ColorNames.secondary))
                .bold()
                .padding(.top)
                .padding(.bottom, 5)
            
            ForEach(sessionDetail.speakers) { speaker in
                
                NavigationLink(value: Destination.speaker(speaker)) {
                    HStack(spacing: 5) {
                        RemoteImageView(url: speaker.imageUrl)
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        
                        Text(speaker.name)
                            .font(.title3)
                            .padding(.bottom, 5)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private func locationView(_ location: Location) -> some View {
        
        VStack(alignment: .leading) {
            Text(AppStrings.location)
                .font(.title3)
                .foregroundColor(Color(ColorNames.secondary))
                .bold()
                .padding(.top)
                .padding(.bottom, 5)
            
            NavigationLink(value: Destination.locations(locations: [location])) {
                Text(location.name)
                    .font(.subheadline)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        Button {
            baseViewModel.updateFavoritSession(sessionId: sessionDetail.session.id)
        } label: {
            Image(systemName: baseViewModel.isFavorite(sessionDetail.session.id) ? ImageNames.bookmarkFill : ImageNames.bookmark)
        }
    }
    
    
    @ViewBuilder
    private func main() -> some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                headerView()
                timeView()
                descriptionView()
                if !sessionDetail.speakers.isEmpty {
                    speakersView()
                }
                if let location = sessionDetail.location {
                    locationView(location)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
    var body: some View {
        main()
            .edgesIgnoringSafeArea(.top)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
            }
        
    }
}
