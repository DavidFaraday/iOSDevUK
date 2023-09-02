//
//  SessionRowViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 07/10/2022.
//

import SwiftUI
import Combine

final class SessionRowViewModel: ObservableObject {
    @Published private(set) var speakers: [Speaker]?
    @Published private(set) var speakerNames: String?
    
    init() {
        observerData()
    }
    
    private func observerData() {
        $speakers
            .compactMap { $0 }
            .filter { !$0.isEmpty }
            .map { $0.sorted() }
            .map { sortedSpeakers in
                sortedSpeakers.map { $0.name }.joined(separator: ", ")
            }
            .assign(to: &$speakerNames)
    }
    
    func setSpeakers(speakers: [Speaker]) {
        self.speakers = speakers
    }
}
