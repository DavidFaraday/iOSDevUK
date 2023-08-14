//
//  SessionCardViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 07/10/2022.
//

import Factory
import SwiftUI

final class SessionCardViewModel: ObservableObject {
    @Injected(\.firebaseRepository) private var firebaseRepository
    @Published private(set) var fetchError: Error?

    @Published private(set) var session: Session
    @Published private(set) var speakers: [Speaker]?
    @Published private(set) var location: Location?
    
    init(session: Session) {
        self.session = session
    }
    
    @MainActor
    @Sendable func fetchSpeakers() async {
        guard speakers == nil else { return }

        var tempSpeakers: [Speaker] = []
                
        for id in session.speakerIds {
            do {
                let speaker: Speaker? = try await firebaseRepository.getDocument(from: .Speaker, with: id)
                guard let speaker = speaker else { return }
                tempSpeakers.append(speaker)
            } catch (let error) {
                fetchError = error
            }
        }
        
        self.speakers = tempSpeakers
    }

    @MainActor
    @Sendable func fetchLocation() async {
        guard location == nil else { return }
        
        if let locationId = session.locationId {
            do {
                self.location = try await firebaseRepository.getDocument(from: .Location, with: locationId)
            } catch (let error) {
                fetchError = error
            }
        }
    }
    
    func speakerNames(from speakers: [Speaker]) -> String {

        let sortedNames = speakers.sorted()
        
        var joinedNames = ""
        joinedNames.append(sortedNames.map { "\($0.name)" }.joined(separator: ", "))
       
        return joinedNames
    }

}
