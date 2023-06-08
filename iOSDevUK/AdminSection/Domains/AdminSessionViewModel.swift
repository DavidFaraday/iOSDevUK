//
//  AdminSessionViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 05/03/2023.
//

import Foundation
import Factory
import Combine


final class AdminSessionViewModel: ObservableObject {
    @Injected(Container.firebaseRepository) private var firebaseRepository

    @Published var title = ""
    @Published var content = "Session content"
    @Published var type = SessionType.talk
    
    @Published var location: Location?
    @Published private var locationId = ""
    
    @Published var selectedSpeakers = Set<Speaker>()

    @Published private var speakerIds: [String] = []

    @Published var startDate = Date()
    @Published var endDate = Date()
    
    var subscriptions = Set<AnyCancellable>()

    var session: Session?
    
    init(session: Session? = nil) {
        self.session = session
        setupUI()
        observerData()
    }
    
    private func observerData() {
        $location
            .map({ $0?.id ?? "" })
            .assign(to: &$locationId)
        
        $selectedSpeakers
            .map({ $0.map({ $0.id }) })
            .assign(to: &$speakerIds)
    }
    
        
    private func setupUI() {
        guard let session = session else { return }
        
        title = session.title
        content = session.content
        type = session.type
        locationId = session.locationId
        speakerIds = session.speakerIds
        startDate = session.startDate
        endDate = session.endDate
    }
    
    @MainActor
    func save(speakers: Set<Speaker>) async {
        selectedSpeakers = speakers

        
        guard !speakerIds.isEmpty else { return }
        
        let newSession = Session(id: session?.id ?? UUID().uuidString, title: title, content: content, startDate: startDate, endDate: endDate, locationId: locationId, speakerIds: speakerIds, type: type)
        
        print(newSession)
        
//        do {
//            try firebaseRepository.saveData(data: newSession, to: .Session)
//        }
//        catch {
//            print("Error saving session", error.localizedDescription)
//        }
    }
    
    func deleteSession(_ session: Session) {
        firebaseRepository.deleteDocument(with: session.id, from: .Session)
    }
    
    func invalidForm() -> Bool {
        title == "" || content == "" || locationId == ""
    }
}
