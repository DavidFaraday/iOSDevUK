//
//  AdminViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 26/10/2022.
//

import Foundation

final class AdminViewModel: ObservableObject {
    private let firebaseAuth: FirebaseAuthenticationServiceProtocol
    
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
    
    init(firebaseAuth: FirebaseAuthenticationServiceProtocol =  FirebaseAuthenticationService.shared) {
        self.firebaseAuth = firebaseAuth
    }
    
    @MainActor
    func uploadNewData() async {
//        try? await FileUploadService.shared.uploadNewData(from: "sponsors.json", to: .Sponsor, objectType: Sponsor.self)
//        sleep(2)
//        try? await FileUploadService.shared.uploadNewData(from: "speakers.json", to: .Speaker, objectType: Speaker.self)
//        sleep(2)
//        try? await FileUploadService.shared.uploadNewData(from: "locations.json", to: .Location, objectType: Location.self)
//        sleep(2)
//        try? await FileUploadService.shared.uploadNewData(from: "sessions.json", to: .Session, objectType: CustomSession.self)
//        sleep(2)
//        try? await FileUploadService.shared.uploadNewData(from: "eventInformation.json", to: .AppInformation, objectType: CustomEventInformation.self)
        
//        print("DEBUG: Uploaded new data to firestore!")
    }
}
