//
//  SpeakersViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI
import Combine

final class SpeakersViewModel: ObservableObject {
    
    @Published private(set) var speakers: [Speaker] = []
    private var cancellables: Set<AnyCancellable> = []
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    func getSpeakers() {
        FirebaseSpeakerListener.shared.getSpeakers()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    return
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] allSpeakers in
                self?.speakers = allSpeakers
            })
            .store(in: &cancellables)
    }
}
