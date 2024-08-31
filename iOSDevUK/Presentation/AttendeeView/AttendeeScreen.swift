//
//  AttendeeView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct AttendeeScreen: View {
    @EnvironmentObject var viewModel: BaseViewModel
    @EnvironmentObject var router: NavigationRouter
    
    @ViewBuilder
    private func main() -> some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 15) {
                ForEach(viewModel.infoItems) { item in
                    if let url = item.url {
                        Link(destination: url) {
                            AttendeeRowView(
                                subtitle: item.imageName == "ticket" ? "LINK" : "PDF",
                                title: item.name,
                                description: item.subtitle,
                                image: Image(item.imageName ?? "")
                            )
                        }
                    } else {
                        AttendeeRowView(
                            title: item.name,
                            description: item.subtitle,
                            image: Image(item.imageName ?? "")
                        )
                    }
                }
            }
            .padding([.horizontal, .top], 16)
        }
    }
    
    var body: some View {
        NavigationStack(path: $router.attendeePath) {
            main()
                .navigationTitle("Attendee Information")
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                        case .session(let session):
                            SessionDetailView(session: session)
                        case .sessions(let sessions):
                            AllSessionsView(sessions: sessions)
                        case .speaker(let speaker):
                            SpeakerDetailScreen(speaker: speaker)
                        case .speakers(let speakers):
                            AllSpeakersView(speakers: speakers)
                        case .sponsor(let sponsor):
                            SponsorsScreen(sponsor: sponsor)
                        case .locations(let locations):
                            MapScreen(allLocations: locations)
                    }
                }
        }
    }
}

struct AttendeeView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeScreen()
    }
}
