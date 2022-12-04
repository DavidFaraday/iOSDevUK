//
//  SessionDetailViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 03/10/2022.
//

import Factory
import SwiftUI
import CoreData

final class SessionDetailViewModel: ObservableObject {
    @Injected(Container.firebaseRepository) private var firebaseRepository

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
                session = try await firebaseRepository.getDocument(from: .Session, with: sessionId)
            } catch {
                print("Session fetching error")
            }
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
            let speaker: Speaker? = try await firebaseRepository.getDocument(from: .Speaker, with: id)

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
                self.location = try await firebaseRepository.getDocument(from: .Location, with: session.locationId)
            } catch {
                print("error speaker for session")
            }
        }
    }
    
    func addToMySession(context: NSManagedObjectContext) {
        guard let session = session else { return }

        let cdSession = SavedSession(context: context)
        cdSession.title = session.title
        cdSession.id = session.id
        cdSession.startDate = session.startDate
        cdSession.endDate = session.endDate
        cdSession.content = session.content
        cdSession.startDateName = session.startingDay
        cdSession.locationName = location?.name
        cdSession.locationId = location?.id
        
        DataController.save(context: context)
    }
    
    func removeFromMySessions(savedSession: SavedSession, context: NSManagedObjectContext) {
        
        context.delete(savedSession)
        
        do {
          try context.save()
        } catch {
            print("error saving after delete")
        }
    }
}
