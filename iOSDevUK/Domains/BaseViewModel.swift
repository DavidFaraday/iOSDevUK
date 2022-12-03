//
//  HomeViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import Factory
import Combine
import SwiftUI

class BaseViewModel: ObservableObject {
    @Environment(\.openURL) var openURL
    @Injected(Container.firebaseRepository) private var firebaseRepository

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
    
//    @MainActor
//    func testing() async {
//        do {
//            self.sessions  = try await firebaseRepository.getDocuments(from: .Session) ?? []
//            print(sessions.count)
//        } catch {
//            print(error)
//        }
//    }
    
    @MainActor
    @Sendable func listenForSessions() async {
        if self.sessions.isEmpty {
            do {
                try await firebaseRepository.listen(from: .Session)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            print("finished sessions")
                            return
                        case .failure(let error):
                            print("Error: \(error.localizedDescription)")
                        }
                    }, receiveValue: { [weak self] allSessions in
                        self?.sessions = allSessions.sorted()
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
                try await firebaseRepository.listen(from: .Speaker)
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
            } catch {
                print(error)
            }
        }
    }
    
    @MainActor
    @Sendable func listenForEventNotification() async {
        if eventInformation == nil {
            do {
                try await firebaseRepository.listen(from: .AppInformation)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            return
                        case .failure(let error):
                            print("Error: \(error.localizedDescription)")
                        }
                    }, receiveValue: { [weak self] eventInformations in
                        self?.eventInformation = eventInformations.first
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
                try await firebaseRepository.listen(from: .Sponsor)
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
            } catch {
                print(error)
            }
        }
    }
    
    @MainActor
    @Sendable func listenForLocations() async {
        if self.locations.isEmpty {
            do {
                
                try await firebaseRepository.listen(from: .Location)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            return
                        case .failure(let error):
                            print("Error: \(error.localizedDescription)")
                        }
                    }, receiveValue: { [weak self] allLocations in
                        self?.locations = allLocations
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
                try await firebaseRepository.listen(from: .InformationItem)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            return
                        case .failure(let error):
                            print("Error: \(error.localizedDescription)")
                        }
                    }, receiveValue: { [weak self] infoItems in
                        self?.infoItems = infoItems
                    })
                    .store(in: &cancellables)
            } catch {
                print(error)
            }
        }
    }
    
//    @Sendable func getAllLocations() async {
//        do {
//            var locations: [NewLocation] = try await firebaseRepository.getDocuments(from: .Locations) ?? []
//
//            
//            for location in locations {
//                firebaseRepository.saveData(location, to: .Location)
//            }
//
//
//
//            print(locations.count)
//        } catch {
//            print("Error getting sessions")
//        }
//
//    }
}
