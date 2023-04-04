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
    @Published var locationId = ""
    @Published var startDate = Date()
    @Published var endDate = Date()
    @Published var speakerIds = ""
    
    var session: Session?
    
    init(session: Session? = nil) {
        self.session = session
        setupUI()
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
        //TODO: Fix location and speakers
        let newSession = Session(id: session?.id ?? UUID().uuidString, title: title, content: content, startDate: startDate, endDate: endDate, locationId: locationId, speakerIds: [], type: type)
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
