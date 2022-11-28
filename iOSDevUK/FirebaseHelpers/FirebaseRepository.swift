//
//  FirebaseRepository.swift
//  iOSDevUK
//
//  Created by David Kababyan on 22/11/2022.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase
import Combine

protocol FirebaseRepositoryProtocol {
    func getDocuments<T: Codable>(from collection: FCollectionReference) async throws -> [T]?
    func getDocuments<T: Codable>(from collection: FCollectionReference, where field: String, isEqualTo value: String) async throws -> [T]?
    func getDocuments<T: Codable>(from collection: FCollectionReference, where field: String, arrayContains value: String) async throws -> [T]?
    func getDocument<T: Codable>(from collection: FCollectionReference, with id: String) async throws -> T?
    func listen<T: Codable>(from collection: FCollectionReference) async throws -> AnyPublisher<[T], Error>
    func deleteDocument(with id: String, from collection: FCollectionReference)
}

final class FirebaseRepository: FirebaseRepositoryProtocol {
    
    func getDocuments<T: Codable>(from collection: FCollectionReference) async throws -> [T]? {

        try await withCheckedThrowingContinuation { continuation in

            FirebaseReference(collection).getDocuments { querySnapshot, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let documents = querySnapshot?.documents else {
                    continuation.resume(returning: nil)
                    return
                }

                let result = documents.compactMap { queryDocumentSnapshot -> T? in
                    return try? queryDocumentSnapshot.data(as: T.self)
                }

                continuation.resume(returning: result)
            }
        }
    }
    
    func getDocuments<T: Codable>(from collection: FCollectionReference, where field: String, isEqualTo value: String) async throws -> [T]? {
        try await withCheckedThrowingContinuation { continuation in

            FirebaseReference(collection).whereField(field, isEqualTo: value).getDocuments { querySnapshot, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let documents = querySnapshot?.documents else {
                    continuation.resume(returning: nil)
                    return
                }

                let result = documents.compactMap { queryDocumentSnapshot -> T? in
                    return try? queryDocumentSnapshot.data(as: T.self)
                }

                continuation.resume(returning: result)
            }
        }
    }
    
    
    func getDocuments<T: Codable>(from collection: FCollectionReference, where field: String, arrayContains value: String) async throws -> [T]? {

        try await withCheckedThrowingContinuation { continuation in

            FirebaseReference(collection).whereField(field, arrayContains: value).getDocuments { querySnapshot, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let documents = querySnapshot?.documents else {
                    continuation.resume(returning: nil)
                    return
                }

                let result = documents.compactMap { queryDocumentSnapshot -> T? in
                    return try? queryDocumentSnapshot.data(as: T.self)
                }

                continuation.resume(returning: result)
            }
        }
    }
    
    func getDocument<T: Codable>(from collection: FCollectionReference, with id: String) async throws -> T? {

        try await withCheckedThrowingContinuation { continuation in

            FirebaseReference(collection).document(id).getDocument { querySnapshot, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let document = querySnapshot else {
                    continuation.resume(returning: nil)
                    return
                }

                let result = try? document.data(as: T.self)

                continuation.resume(returning: result)
            }
        }
    }

    
    func listen<T: Codable>(from collection: FCollectionReference) async throws -> AnyPublisher<[T], Error> {
        print("getting from real")
        let subject = PassthroughSubject<[T], Error>()
        
        FirebaseReference(collection).addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                subject.send(completion: .failure(error))
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                subject.send(completion: .failure(FirebaseError.badSnapshot))
                return
            }
            
            let data = documents.compactMap {
                try? $0.data(as: T.self)
            }
            
            subject.send(data)
        }
        
        return subject.eraseToAnyPublisher()
    }
    
//    func saveData(_ data: T, to collection: FCollectionReference) {
//
//        do {
//            try FirebaseReference(collection).setData(from: data)
//        }
//        catch {
//            print("Error saving session", error.localizedDescription)
//        }
//    }
    
    func deleteDocument(with id: String, from collection: FCollectionReference) {
        FirebaseReference(collection).document(id).delete()
    }
}


//class FBR: FirebaseRepositoryProtocol {
//    func getDocuments<T>(from collection: FCollectionReference) async throws -> [T]? where T : Codable {
//        try await withCheckedThrowingContinuation { continuation in
//
//            FirebaseReference(collection).getDocuments { querySnapshot, error in
//                if let error = error {
//                    continuation.resume(throwing: error)
//                    return
//                }
//
//                guard let documents = querySnapshot?.documents else {
//                    continuation.resume(returning: nil)
//                    return
//                }
//
//                let result = documents.compactMap { queryDocumentSnapshot -> T? in
//                    return try? queryDocumentSnapshot.data(as: T.self)
//                }
//
//                continuation.resume(returning: result)
//            }
//        }
//    }
//}


final class MocFirebaseRepository: FirebaseRepositoryProtocol {
    
    func getDocuments<T: Codable>(from collection: FCollectionReference) async throws -> [T]? {
        print("calling moc")
        return try await withCheckedThrowingContinuation { continuation in
            continuation.resume(returning: DummyData.speakers as! [T])
        }
    }
    
    func getDocuments<T: Codable>(from collection: FCollectionReference, where field: String, isEqualTo value: String) async throws -> [T]? {
        return nil
    }
    
    func getDocuments<T: Codable>(from collection: FCollectionReference, where field: String, arrayContains value: String) async throws -> [T]? {
        return nil
    }
    
    func getDocument<T: Codable>(from collection: FCollectionReference, with id: String) async throws -> T? {
        return nil
    }
    
    func listen<T: Codable>(from collection: FCollectionReference) async throws -> AnyPublisher<[T], Error> {
        print("calling moc Listen")

        let subject = PassthroughSubject<[T], Error>()
        
        subject.send(DummyData.speakers as! [T])
        return subject.eraseToAnyPublisher()
    }
    
    func deleteDocument(with id: String, from collection: FCollectionReference) {
        
    }
}
