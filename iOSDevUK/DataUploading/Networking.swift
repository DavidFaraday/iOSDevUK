//
//  Networking.swift
//  iOSDevUK
//
//  Created by David Kababyan on 11/09/2022.
//

import SwiftUI

//used only for uploading sessions because of the date/time format
struct CustomSession: Codable, Identifiable {
    let id: String
    let title: String
    let content: String
    let startDate: Date?
    let endDate: Date?
    let locationId: String?
    let speakerIds: [String]
    let type: SessionType
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.content = try container.decode(String.self, forKey: .content)
        self.locationId = try? container.decode(String.self, forKey: .locationId)
        self.speakerIds = try container.decode([String].self, forKey: .speakerIds)
        self.type = try container.decode(SessionType.self, forKey: .type)

        let startDateString = try container.decode(String.self, forKey: .startDate)
        let endDateString = try container.decode(String.self, forKey: .endDate)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        if let startDate = dateFormatter.date(from: startDateString) {
            self.startDate = startDate
        } else {
            throw DecodingError.dataCorruptedError(forKey: .startDate,
                                                   in: container,
                                                   debugDescription: "Invalid date format start")
        }

        if let endDate = dateFormatter.date(from: endDateString) {
            self.endDate = endDate
        } else {
            throw DecodingError.dataCorruptedError(forKey: .endDate,
                                                   in: container,
                                                   debugDescription: "Invalid date format end")
        }
    }
}


//MARK: - used only to get files from JSON and save to Firebase
final class FileUploadService {
    static let shared = FileUploadService()
    let firebaseRepo = FirebaseRepository()
    
    private init() { }

    func uploadNewData<T: CodableIdentifiable>(from fileName: String, to collection: FCollectionReference, objectType: T.Type) async throws {
        
        let objects = Bundle.main.decode([T].self, from: fileName)
        
        for object in objects {
            do {
                try firebaseRepo.saveData(data: object, to: collection)
            } catch {
                print(error.localizedDescription)
                throw AppError.unknownError
            }
        }
    }
}

