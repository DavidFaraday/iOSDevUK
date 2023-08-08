//
//  NavigationRouter.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/11/2022.
//

import Foundation

final class NavigationRouter: ObservableObject {
    @Published var homePath: [Destination] = []
    @Published var schedulePath: [Destination] = []
    @Published var attendeePath: [Destination] = []
    @Published var infoPath: [InfoDestination] = []

    static let shared = NavigationRouter()
}


enum Destination: Hashable {
    case speaker(Speaker)
    case speakers([Speaker])
    case session(Session)
    case sessions([Session])
    case sponsor
    case locations(locations: [Location])
    case savedSession(SavedSession)
}

enum InfoDestination: Hashable {
    case inclusivity
    case sponsors
    case aboutApp
    case appInformation
    case locationList
    case locations(locations: [Location])
    case admin
    case adminSpeakers
    case adminAddSpeaker(Speaker?)
    case adminSessions
    case adminAddSession(Session?)
    case adminLocations
    case adminAddLocation(Location?)
    case adminSponsors
    case adminAddSponsor(Sponsor?)
}
