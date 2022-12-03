//
//  SessionRowViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 07/10/2022.
//

import SwiftUI
import Factory

final class SessionRowViewModel: ObservableObject {
    @Injected(Container.firebaseRepository) private var firebaseRepository

    @Published private(set) var location: Location?
       
    @MainActor
    func fetchLocation(with id: String?) async {
        guard let id = id else { return }
        if location == nil {
            do {
                self.location = try await firebaseRepository.getDocument(from: .Location, with: id)
            } catch {
                print("error speaker for session")
            }
        }
    }
}
