//
//  SessionRowViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 07/10/2022.
//

import SwiftUI

final class SessionRowViewModel: ObservableObject {
    @Published private(set) var location: Location?
       
    @MainActor
    func fetchLocation(with id: String?) async {
        guard let id = id else { return }
        if location == nil {
            do {
                self.location = try await FirebaseRepository<Location>().getDocument(from: .Location, with: id)
            } catch {
                print("error speaker for session")
            }

//            self.location = await FirebaseLocationListener.shared.getLocation(with: id)
        }
    }
}
