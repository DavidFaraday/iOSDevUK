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
    @Published private(set) var fetchError: Error?

    @Published private(set) var eventInformation: EventInformation?
    @Published private(set) var sessions: [Session]
    @Published private(set) var speakers: [Speaker]
    @Published private(set) var sponsors: [Sponsor]
    @Published private(set) var locations: [Location]
    @Published private(set) var infoItems: [InformationItem]
    @Published private(set) var currentWeather: WeatherData?
    @Published private(set) var hourlyWeather: [WeatherData]
    
    private var cancellables: Set<AnyCancellable> = []

    init(eventInformation: EventInformation? = nil,
         sessions: [Session] = [],
         speakers: [Speaker] = [],
         sponsors: [Sponsor] = [],
         locations: [Location] = [],
         infoItems: [InformationItem] = [],
         currentWeather: WeatherData? = nil,
         hourlyWeather: [WeatherData] = []
    ){
        self.eventInformation = eventInformation
        self.sessions = sessions
        self.speakers = speakers
        self.sponsors = sponsors
        self.locations = locations
        self.infoItems = infoItems
        self.currentWeather = currentWeather
        self.hourlyWeather = hourlyWeather
    }

    @MainActor
    @Sendable func listenForSessions() async {
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
    @Sendable func listenForSpeakers() async {
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
                })
                .store(in: &cancellables)
        } catch (let error) {
            fetchError = error
        }
    }
    
    @MainActor
    @Sendable func listenForEventNotification() async {
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
    @Sendable func listenForSponsors() async {
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
    @Sendable func listenForLocations() async {
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
    @Sendable func listenForInfoItems() async {
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
}

#if DEBUG
extension BaseViewModel {
    static let sharedMock = BaseViewModel(
        eventInformation: DummyData.eventInformation,
        sessions: DummyData.sessions,
        speakers: DummyData.speakers,
        sponsors: DummyData.sponsors,
        locations: [DummyData.location],
        infoItems: DummyData.informationItems,
        currentWeather: DummyData.weatherData,
        hourlyWeather: [DummyData.weatherData]
    )
}
#endif
