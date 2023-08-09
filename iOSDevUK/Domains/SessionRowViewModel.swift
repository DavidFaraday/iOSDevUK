//
//  SessionRowViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 07/10/2022.
//

import SwiftUI
import Factory

final class SessionRowViewModel: ObservableObject {
    @Injected(\.firebaseRepository) private var firebaseRepository
    @Published private(set) var fetchError: Error?
    @Published private(set) var location: Location?
    @Published private(set) var speakers: [Speaker]?
    
    @MainActor
    @Sendable func fetchSpeakers(with speakerIds: [String]) async {
        guard speakers == nil else { return }

        var tempSpeakers: [Speaker] = []
                
        for id in speakerIds {
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
    func fetchLocation(with id: String?) async {
        guard let id = id else { return }
        if location == nil {
            do {
                self.location = try await firebaseRepository.getDocument(from: .Location, with: id)
            } catch (let error) {
                fetchError = error
            }
        }
    }
    
    func speakerNames() -> String {

        guard let speakers = speakers else { return "" }
        
        let sortedNames = speakers.sorted()
        
        var joinedNames = ""
        joinedNames.append(sortedNames.map{ "\($0.name)" }.joined(separator: ", "))
       
        return joinedNames
    }
}
