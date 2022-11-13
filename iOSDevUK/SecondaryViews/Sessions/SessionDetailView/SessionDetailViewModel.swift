//
//  SessionDetailViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 03/10/2022.
//

import Foundation
import CoreData

final class SessionDetailViewModel: ObservableObject {
    
    @Published private(set) var session: Session?
    @Published private(set) var speakers: [Speaker]?
    @Published private(set) var location: Location?
    private let sessionId: String
    
    init(sessionId: String) {
        self.sessionId = sessionId
    }

    @MainActor
    func fetchSession() async {
        if session == nil {
            session = await FirebaseSessionListener.shared.getSession(with: sessionId)
        }
    }

    
    @MainActor
    func fetchSpeakers() async {
        guard let session = session else { return }

        if speakers == nil {
            print("fetching speaker \(sessionId)")
            //TODO: Make group task here
            var tempSpeakers: [Speaker] = []
            
            for id in session.speakerIds {
                let speaker = await FirebaseSpeakerListener.shared.getSpeaker(with: id)
                guard let speaker = speaker else { return }
                tempSpeakers.append(speaker)
            }
            self.speakers = tempSpeakers
        }
    }

    @MainActor
    func fetchLocation() async {
        guard let session = session else { return }

        if location == nil {
            self.location = await FirebaseLocationListener.shared.getLocation(with: session.locationId)
        }
    }
    
    func addToMySession(moc: NSManagedObjectContext) {
        guard let session = session else { return }

        let cdSession = SavedSession(context: moc)
        cdSession.title = session.title
        cdSession.id = session.id
        cdSession.startDate = session.startDate
        cdSession.endDate = session.endDate
        cdSession.content = session.content
        cdSession.startDateName = session.startingDay
        cdSession.locationName = location?.name
        cdSession.locationId = location?.id
        
        
        do {
            try moc.save()
        } catch {
            print("Error saving session to CD")
        }
    }
}
