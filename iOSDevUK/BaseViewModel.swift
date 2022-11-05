//
//  HomeViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI
import Combine

class BaseViewModel: ObservableObject {
    @Environment(\.openURL) var openURL

    @Published private(set) var aboutString = ""
    @Published private(set) var eventNotification = ""
    @Published private(set) var sessions: [Session] = []
    @Published private(set) var speakers: [Speaker] = []
    @Published private(set) var sponsors: [Sponsor] = []
    
    private var cancellables: Set<AnyCancellable> = []

    func showTwitterAccount(_ twitterId: String) {
        guard let url = URL(string: "https://twitter.com/\(twitterId)") else { return }
        self.openURL(url)
    }

    func goTo(link: String) {
        guard let url = URL(string: "\(link)") else { return }
        self.openURL(url)
    }
    
    @MainActor
    @Sendable func listenForSessions() async {
        FirebaseSessionListener.shared.listenForSessions()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    return
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] allSessions in
                self?.sessions = allSessions.sorted { $0.startDate < $1.startDate }
            })
            .store(in: &cancellables)
    }

    @MainActor
    @Sendable func listenForSpeakers() async {
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
    
    @MainActor
    @Sendable func listenForEventNotification() async {
        FirebaseHomeListener.shared.listenForNotification()
            .sink { completion in
                switch completion {
                case .finished:
                    return
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] notificationString in
                self?.eventNotification = notificationString
            }
            .store(in: &cancellables)
    }

    @MainActor
    @Sendable func listenForAboutString() async {
        FirebaseHomeListener.shared.listenForAboutString()
            .sink { completion in
                switch completion {
                case .finished:
                    return
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] about in
                self?.aboutString = about
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    @Sendable func listenForSponsors() async {
        FirebaseSponsorListener.shared.listenForSponsors()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    return
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] allSponsors in
                self?.sponsors = allSponsors.sorted { $0.sponsorCategory < $1.sponsorCategory }
            })
            .store(in: &cancellables)
    }
    
    func saveSessions() {
        for session in DummyData.sessionsToSave {
            FirebaseSessionListener.shared.saveSession(session)
        }
    }
}
