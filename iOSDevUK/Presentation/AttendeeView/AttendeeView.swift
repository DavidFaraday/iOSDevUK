//
//  AttendeeView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct AttendeeView: View {
    @EnvironmentObject var viewModel: BaseViewModel
    @EnvironmentObject var router: NavigationRouter
    
    @ViewBuilder
    private func main() -> some View {
        Form {
            ForEach(viewModel.infoItems) { item in
                if let url = item.url {
                    Link(destination: url) {
                        Text(item.name)
                            .fontWeight(.semibold)
                    }
                } else {
                    Text(item.name)
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack(path: $router.attendeePath) {
            main()
                .navigationTitle("Attendee Info")
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                        case .session(let session):
                            SessionDetailView(sessionId: session.id)
                        case .sessions(let sessions):
                            AllSessionsView(sessions: sessions)
                        case .speaker(let speaker):
                            SpeakerDetailView(speaker: speaker)
                        case .speakers(let speakers):
                            AllSpeakersView(speakers: speakers)
                        case .sponsor:
                            SponsorsView()
                        case .locations(let locations, let singleItemMap):
                            MapView(allLocations: locations, singleItemMap: singleItemMap)
                        case .savedSession(let savedSession):
                            SessionDetailView(sessionId: savedSession.id ?? "")
                    }
                }
        }
    }
}

struct AttendeeView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeView()
    }
}
