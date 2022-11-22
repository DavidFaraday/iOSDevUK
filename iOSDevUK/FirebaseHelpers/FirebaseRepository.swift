//
//  FirebaseRepository.swift
//  iOSDevUK
//
//  Created by David Kababyan on 22/11/2022.
//

import Foundation
import FirebaseFirestoreSwift
import Combine

final class FirebaseRepository<T : Codable>: NSObject, Codable {

    
    func getDocument(from collection: FCollectionReference) async throws -> [T]? {
        
        return try await withCheckedThrowingContinuation { continuation in
            
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
    
    func getDocument(from collection: FCollectionReference, where field: String, isEqualTo value: String) async throws -> [T]? {
        
        return try await withCheckedThrowingContinuation { continuation in
            
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
    
    
    func getDocument(from collection: FCollectionReference, where field: String, arrayContains value: String) async throws -> [T]? {
        
        return try await withCheckedThrowingContinuation { continuation in
            
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
    
    func getDocument(from collection: FCollectionReference, with id: String) async throws -> T? {
        return try await withCheckedThrowingContinuation { continuation in
            
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

    
    //need fix because its refreshing for all the listeners
    func listen(from collection: FCollectionReference) async throws -> AnyPublisher<[T], Error> {
        
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

}
