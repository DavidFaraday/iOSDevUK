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

        let snapshot = try await FirebaseReference(collection).getDocuments()

        return snapshot.documents.compactMap { queryDocumentSnapshot -> T? in
            return try? queryDocumentSnapshot.data(as: T.self)
        }
    }

    
    func getDocuments<T: Codable>(from collection: FCollectionReference, where field: String, isEqualTo value: String) async throws -> [T]? {
        
        let snapshot = try await FirebaseReference(collection).whereField(field, isEqualTo: value).getDocuments()

        return snapshot.documents.compactMap { queryDocumentSnapshot -> T? in
            return try? queryDocumentSnapshot.data(as: T.self)
        }
    }
    
    
    func getDocuments<T: Codable>(from collection: FCollectionReference, where field: String, arrayContains value: String) async throws -> [T]? {
        
        let snapshot = try await FirebaseReference(collection).whereField(field, arrayContains: value).getDocuments()

        return snapshot.documents.compactMap { queryDocumentSnapshot -> T? in
            return try? queryDocumentSnapshot.data(as: T.self)
        }
    }
    
    func getDocument<T: Codable>(from collection: FCollectionReference, with id: String) async throws -> T? {
        
        let snapshot = try await FirebaseReference(collection).document(id).getDocument()
        return try? snapshot.data(as: T.self)
    }

    
    func listen<T: Codable>(from collection: FCollectionReference) async throws -> AnyPublisher<[T], Error> {
                
        
        let subject = PassthroughSubject<[T], Error>()
        
        let handle = FirebaseReference(collection).addSnapshotListener { querySnapshot, error in
            
            if let error = error {
                subject.send(completion: .failure(error))
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                subject.send(completion: .failure(AppError.badSnapshot))
                return
            }
            
            let data = documents.compactMap {
                try? $0.data(as: T.self)
            }
            
            subject.send(data)
        }
        
        return subject.handleEvents(receiveCancel: {
            handle.remove()
        }).eraseToAnyPublisher()
    }
    

    
//    func saveData(_ data: NewLocation, to collection: FCollectionReference) {
//
//        do {
//            try FirebaseReference(collection).document(data.id).setData(from: data.self)
//        }
//        catch {
//            print("Error saving session", error.localizedDescription)
//        }
//    }
    
    func deleteDocument(with id: String, from collection: FCollectionReference) {
        FirebaseReference(collection).document(id).delete()
    }
}


