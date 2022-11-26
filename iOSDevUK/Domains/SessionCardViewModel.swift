//
//  SessionCardViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 07/10/2022.
//

import Factory
import SwiftUI

final class SessionCardViewModel: ObservableObject {
    @Injected(Container.firebaseRepository) private var firebaseRepository

    @Published private(set) var session: Session
    @Published private(set) var speakers: [Speaker]?
    @Published private(set) var location: Location?
    
    init(session: Session) {
        self.session = session
    }
    
    @MainActor
    @Sendable func fetchSpeakers() async {
        if speakers == nil {

            var tempSpeakers: [Speaker] = []
                    
            for id in session.speakerIds {
                do {
                    let speaker: Speaker? = try await firebaseRepository.getDocument(from: .Speaker, with: id)
                    guard let speaker = speaker else { return }
                    tempSpeakers.append(speaker)
                } catch {
                    print("error speaker for session")
                }
            }
            
            self.speakers = tempSpeakers
        }
    }

    @MainActor
    @Sendable func fetchLocation() async {
        if location == nil {
            do {
                self.location = try await firebaseRepository.getDocument(from: .Location, with: session.locationId)
            } catch {
                print("error speaker for session")
            }
        }
    }
    
    func speakerNames(from speakers: [Speaker]) -> String {

        let sortedNames = speakers.sorted()
        
        var joinedNames = ""
        joinedNames.append(sortedNames.map{ "\($0.name)" }.joined(separator: ", "))
       
        return joinedNames
    }

}
