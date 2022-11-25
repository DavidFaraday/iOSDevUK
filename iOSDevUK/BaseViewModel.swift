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
    
    @Published private(set) var eventInformation: EventInformation?
    @Published private(set) var sessions: [Session] = []
    @Published private(set) var speakers: [Speaker] = []
    @Published private(set) var sponsors: [Sponsor] = []
    @Published private(set) var locations: [Location] = []
    @Published private(set) var infoItems: [InformationItem] = []
    
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
        if self.sessions.isEmpty {
            do {
                try await FirebaseRepository<Session>().listen(from: .Session)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            return
                        case .failure(let error):
                            print("Error: \(error.localizedDescription)")
                        }
                    }, receiveValue: { [weak self] allSessions in
                        self?.sessions = allSessions
                        print("Have sessios ", self?.sessions.count)
                    })
                    .store(in: &cancellables)
            } catch {
                print(error)
            }
        }
    }
    
    @MainActor
    @Sendable func listenForSpeakers() async {
        if self.speakers.isEmpty {
            do {
                try await FirebaseRepository<Speaker>().listen(from: .Speaker)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            return
                        case .failure(let error):
                            print("Error: \(error.localizedDescription)")
                        }
                    }, receiveValue: { [weak self] allSpeakers in
                        self?.speakers = allSpeakers
                        print("Have speakers ", self?.speakers.count)
                    })
                    .store(in: &cancellables)
            } catch {
                print(error)
            }
        }
    }
    
    @MainActor
    @Sendable func listenForEventNotification() async {
        if eventInformation == nil {
            do {
                try await FirebaseRepository<EventInformation>().listen(from: .Home)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            return
                        case .failure(let error):
                            print("Error: \(error.localizedDescription)")
                        }
                    }, receiveValue: { [weak self] eventInformations in
                        self?.eventInformation = eventInformations.first
                        print("Have notification ", self?.speakers.count)
                    })
                    .store(in: &cancellables)
            } catch {
                print(error)
            }
        }
    }
    
    
    @MainActor
    @Sendable func listenForSponsors() async {
        if self.sponsors.isEmpty {
            do {
                try await FirebaseRepository<Sponsor>().listen(from: .Sponsor)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            return
                        case .failure(let error):
                            print("Error: \(error.localizedDescription)")
                        }
                    }, receiveValue: { [weak self] allSponsors in
                        self?.sponsors = allSponsors.sorted { $0.sponsorCategory < $1.sponsorCategory }
                        print("Have sponsors \(self?.sponsors.count)")
                    })
                    .store(in: &cancellables)
            } catch {
                print(error)
            }
        }
    }
    
    @MainActor
    @Sendable func listenForLocations() async {
        if self.locations.isEmpty {
            do {
                try await FirebaseRepository<Location>().listen(from: .Location)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            return
                        case .failure(let error):
                            print("Error: \(error.localizedDescription)")
                        }
                    }, receiveValue: { [weak self] allLocations in
                        self?.locations = allLocations
                        print("Have locations ", self?.sessions.count)
                    })
                    .store(in: &cancellables)
            } catch {
                print(error)
            }
        }
    }
    
    @MainActor
    @Sendable func listenForInfoItems() async {
        if self.infoItems.isEmpty {
            do {
                try await FirebaseRepository<InformationItem>().listen(from: .InformationItem)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            return
                        case .failure(let error):
                            print("Error: \(error.localizedDescription)")
                        }
                    }, receiveValue: { [weak self] infoItems in
                        self?.infoItems = infoItems
                        print("Have sessios ", self?.sessions.count)
                    })
                    .store(in: &cancellables)
            } catch {
                print(error)
            }
        }
    }
    
    
    //    func saveSessions() {
    //        for session in DummyData.sessionsToSave {
    //            FirebaseSessionListener.shared.saveSession(session)
    //        }
    //    }
}
