//
//  SessionDetailViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 03/10/2022.
//

import Factory
import SwiftUI
import CoreData
import Combine

final class SessionDetailViewModel: ObservableObject {
    @Injected(\.firebaseRepository) private var firebaseRepository
    @Published private(set) var fetchError: Error?

    @Published private(set) var session: Session?
    @Published private(set) var speakers: [Speaker]?
    @Published private(set) var location: Location?
    
    @Published var showError = false
    private var cancellables: Set<AnyCancellable> = []

    private let sessionId: String

    init(sessionId: String, session: Session? = nil) {
        self.sessionId = sessionId
        self.session = session
        
        $fetchError
            .dropFirst()
            .sink { [weak self] _ in
                self?.showError = true
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func fetchSession() async {
        guard session == nil else { return }

        do {
            session = try await firebaseRepository.getDocument(from: .Session, with: sessionId)
        } catch (let error) {
            fetchError = error
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
        } catch (let error) {
            fetchError = error
        }
    }


    @MainActor
    func fetchLocation() async {

        guard let session = session else { return }
        guard location == nil else { return }

        if let locationId = session.locationId {
            do {
                self.location = try await firebaseRepository.getDocument(from: .Location, with: locationId)
            } catch (let error) {
                fetchError = error
            }
        }
    }
    
    @MainActor
    func resetError() {
        self.fetchError = nil
    }
    
    
    /// Add the current session to the CoreData store for the `My Sessions` list.
    /// The code checks that there isn't already an entry with the same identifier in the data store. If there is no match,
    /// a new record is added to the data store, which is then propagated to other connected devices using
    /// Core Data and CloudKit synchronisation.
    ///
    /// - Parameter context: The Core Data context that will manage the data.
    func addToMySession(context: NSManagedObjectContext) {
        guard let session = session else { return }

        let exists = DataController.entityExists(forId: sessionId, inContext: context)
        if !exists.description.isEmpty {
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
    }
    
    func removeFromMySessions(savedSession: SavedSession, context: NSManagedObjectContext) {
        context.delete(savedSession)
        DataController.save(context: context)
    }
}
