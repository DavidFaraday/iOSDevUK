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
            do {
                session = try await FirebaseRepository<Session>().getDocument(from: .Session, with: sessionId)
            } catch {
                print("Session fetching error")
            }
//            session = await FirebaseSessionListener.shared.getSession(with: sessionId)
        }
    }

    
    @MainActor
    func fetchSpeakers() async {
        guard let session = session else { return }

        if speakers == nil {
            speakers = []
            
            await withTaskGroup(of: Void.self) { taskGroup in
                
                for id in session.speakerIds {
                    taskGroup.addTask {
                        await self.fetchSpeaker(with: id)
                    }
                }
            }
        }
    }
    
    @MainActor
    private func fetchSpeaker(with id: String) async {
        
        do {
            let speaker = try await FirebaseRepository<Speaker>().getDocument(from: .Speaker, with: id)
            guard let speaker = speaker else { return }
            self.speakers?.append(speaker)
        } catch {
            print("error speaker for session")
        }
        
    }

    

    @MainActor
    func fetchLocation() async {
        guard let session = session else { return }

        if location == nil {
            do {
                self.location = try await FirebaseRepository<Location>().getDocument(from: .Location, with: session.locationId)
            } catch {
                print("error speaker for session")
            }

//            self.location = await FirebaseLocationListener.shared.getLocation(with: session.locationId)
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
