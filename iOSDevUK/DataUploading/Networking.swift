//
//  Networking.swift
//  iOSDevUK
//
//  Created by David Kababyan on 11/09/2022.
//

import SwiftUI

//custom object used only to get locations from the JSON to upload to firebase
struct CustomLocation: Codable, Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let note: String
    let imageLink: String?
    let latitude: Double
    let longitude: Double
    let webLink: Weblink?
    let locationType: LocationType

    private enum CodingKeys : String, CodingKey {
        case name, locationType = "locationTypeRecordName", note, imageLink, latitude, longitude, id, webLink
    }
}

struct CustomSpeaker: Codable, Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let biography: String
    let linkedIn: String?
    let twitterId: String?
    let imageLink: String = "https://images.unsplash.com/photo-1489424731084-a5d8b219a5bb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80"
    let webLinks: [Weblink]?
}


//MARK: - used only to get files from JSON and save to Firebase
final class FileUploadService {
    static let shared = FileUploadService()
    let firebaseRepo = FirebaseRepository()
    
    private init() { }
    
//    //to be called only 1 time!
//    func uploadNewLocations() async throws {
//        let locations = Bundle.main.decode([CustomLocation].self, from: "locations.json")
//        //need to delete all from firebase before upload
//
//        for location in locations {
//            do {
//                try firebaseRepo.saveData(data: location, to: .Location)
//            } catch {
//                print(error.localizedDescription)
//                throw AppError.unknownError
//            }
//        }
//    }


    func uploadNewData(from fileName: String, to collection: FCollectionReference) async throws {
        let objects = Bundle.main.decode([CustomSpeaker].self, from: fileName)
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

