//
//  AdminSessionViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 05/03/2023.
//

import Foundation
import Factory

final class AdminSessionViewModel: ObservableObject {
    @Injected(Container.firebaseRepository) private var firebaseRepository

    @Published var title = ""
    @Published var content = "Session content"
    @Published var type = SessionType.talk
    @Published var location: Location?
    @Published var speakers: [Speaker] = []
    @Published var speaker: Speaker?
    @Published var startDate = Date()
    @Published var endDate = Date()
    
    @Published private var speakerIds = ""
    @Published private var locationId = ""

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
        $speaker
            .map({ $0?.id ?? "" })
            .assign(to: &$speakerIds)
        
//        $speakers
//            .map({ $0.map({ $0.id }).joined(separator: ", ") })
//            .assign(to: &$speakerIds)
    }
    
    private func setupUI() {
        guard let session = session else { return }
        
        title = session.title
        content = session.content
        type = session.type
        locationId = session.locationId
        speakerIds = session.speakerIds.joined(separator: ", ")
        startDate = session.startDate
        endDate = session.endDate
    }
    
    func save() async {

        let newSession = Session(id: session?.id ?? UUID().uuidString, title: title, content: content, startDate: startDate, endDate: endDate, locationId: locationId, speakerIds: speakers.map({ $0.id }), type: type)
        do {
            try firebaseRepository.saveData(data: newSession, to: .Session)
        }
        catch {
            print("Error saving session", error.localizedDescription)
        }
    }
    
    func deleteSession(_ session: Session) {
        firebaseRepository.deleteDocument(with: session.id, from: .Session)
    }
    
    func invalidForm() -> Bool {
        title == "" || content == "" || locationId == "" || speakerIds == ""
    }
}
