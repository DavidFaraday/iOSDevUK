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
//        try? await FileUploadService.shared.uploadNewData(from: "locations.json", to: .Location)
//        try? await FileUploadService.shared.uploadNewData(from: "speakers.json", to: .Speaker)
//        try? await FileUploadService.shared.uploadNewData(from: "sponsors.json", to: .Sponsor)
        
        print("DEBUG: Uploaded new data to firestore!")
    }

}
