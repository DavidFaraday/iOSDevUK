//
//  AdminViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 26/10/2022.
//

import Foundation
import Factory

final class AdminViewModel: ObservableObject {
    @Injected(\.firebaseAuthRepository) private var firebaseAuth
    
    @Published var logoutError: Error?
    @Published var showError = false

    @MainActor
    func logOutUser() async {
        do {
            try await firebaseAuth.logOutUser()
        } catch (let error) {
            logoutError = error
        }
        
        showError = logoutError != nil
    }
    
    @MainActor
    @Sendable func uploadNewData() async {
//        try? await FileUploadService.shared.uploadNewData(from: "sponsors.json", to: .Sponsor, objectType: Sponsor.self)
//        sleep(2)
//        try? await FileUploadService.shared.uploadNewData(from: "speakers.json", to: .Speaker, objectType: Speaker.self)
//        sleep(2)
//        try? await FileUploadService.shared.uploadNewData(from: "locations.json", to: .Location, objectType: Location.self)
//        sleep(2)
//        try? await FileUploadService.shared.uploadNewData(from: "sessions.json", to: .Session, objectType: CustomSession.self)
        
        print("DEBUG: Uploaded new data to firestore!")
    }
}
