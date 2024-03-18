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
    @Injected(\.firebaseRepository) private var firebaseRepository
    @Injected(\.localStorage) private var localStorage
    
    @Published private(set) var fetchError: Error?
    
    @Published private(set) var eventInformation: EventInformation?
    @Published private(set) var sessions: [Session] = []
    @Published private(set) var homeViewSessions: [Session] = []
    @Published private(set) var speakers: [Speaker] = []
    @Published private(set) var sponsors: [Sponsor] = []
    @Published private(set) var locations: [Location] = []
    @Published private(set) var infoItems: [InformationItem] = []
    @Published private(set) var currentWeather: WeatherData?
    @Published private(set) var hourlyWeather: [WeatherData] = []
    @Published var favoriteSessionIds: [String] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        observerData()
    }
    
    var eventDate: String {
        guard let startDate = eventInformation?.startDate,
              let endDate = eventInformation?.endDate else { return "" }
        
        return "\(startDate.dayOfTheMonth)-\(endDate.dayAndMonth) \(endDate.year)"
    }
    
    private func observerData() {
        $sessions
            .map { sessions in
                sessions
                    .filter { $0.type != .lunch }
                    .filter { $0.type != .coffeeBiscuits }
                    .filter { $0.type != .dinner }
            }
            .assign(to: &$homeViewSessions)
    }
    
    @MainActor
    func listenForSessions() async {
        guard self.sessions.isEmpty else { return }

        do {
            try await firebaseRepository.listen(from: .Session)
                .sink(receiveCompletion: { completion in
                    switch completion {
                        case .finished:
                            return
                        case .failure(let error):
                            print("Error: \(error.localizedDescription)")
                    }
                }, receiveValue: { [weak self] allSessions in
                    self?.sessions = allSessions.sorted()
                })
                .store(in: &cancellables)
        } catch (let error) {
            fetchError = error
        }
    }
    
    @MainActor
    func listenForSpeakers() async {
        guard self.speakers.isEmpty else { return }

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
                    self?.speakers.shuffle()
                })
                .store(in: &cancellables)
        } catch (let error) {
            fetchError = error
        }
    }
    
    @MainActor
    private func listenForEventNotification() async {
        guard eventInformation == nil else { return }

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
        } catch (let error) {
            fetchError = error
        }
    }
    
    
    @MainActor
    private func listenForSponsors() async {
        guard self.sponsors.isEmpty else { return }

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
        } catch (let error) {
            fetchError = error
        }
    }
    
    @MainActor
    private func listenForLocations() async {
        guard self.locations.isEmpty else { return }

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
        } catch (let error) {
            fetchError = error
        }
    }
    
    @MainActor
    private func listenForInfoItems() async {
        guard self.infoItems.isEmpty else { return }

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
        } catch (let error) {
            fetchError = error
        }
    }
    
    @MainActor
    func updateFavoriteSession(sessionId: String) {
        if let index = favoriteSessionIds.firstIndex(of: sessionId) {
            favoriteSessionIds.remove(at: index)
        } else {
            favoriteSessionIds.append(sessionId)
        }
        
        localStorage.save(items: favoriteSessionIds, for: AppConstants.sessionKey)
        loadFavSessions()
    }
    
    func listenForData() async {
        await listenForEventNotification()
        await listenForSessions()
        await listenForSpeakers()
        await listenForSponsors()
        await listenForLocations()
        await listenForInfoItems()
    }
    
    func loadFavSessions() {
        self.favoriteSessionIds = localStorage.loadArray(with: AppConstants.sessionKey)
    }
    
    func shuffleSpeakers() {
        self.speakers.shuffle()
    }
    
    func getLocation(with id: String?) -> Location? {
        guard id != nil else { return nil }
        
        return self.locations.first(where: { $0.id == id })
    }
    
    func getSpeakers(with ids: [String]) ->  [Speaker] {
        self.speakers.filter( { ids.contains($0.id) } )
    }
    
    func isFavorite(_ sessionId: String) -> Bool {
        favoriteSessionIds.contains(sessionId)
    }
}
