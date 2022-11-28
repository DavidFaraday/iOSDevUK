//
//  MocFirebaseRepository.swift
//  iOSDevUKTests
//
//  Created by David Kababyan on 27/11/2022.
//

import Foundation
@testable import iOSDevUK
import FirebaseFirestore
import Combine

//final class MocFirebaseRepository: FirebaseRepositoryProtocol {
//    
//    func getDocuments<T: Codable>(from collection: FCollectionReference) async throws -> [T]? {
//        print("calling moc")
//        return try await withCheckedThrowingContinuation { continuation in
//            continuation.resume(returning: DummyData.speakers as! [T])
//        }
//    }
//    
//    func getDocuments<T: Codable>(from collection: FCollectionReference, where field: String, isEqualTo value: String) async throws -> [T]? {
//        return nil
//    }
//    
//    func getDocuments<T: Codable>(from collection: FCollectionReference, where field: String, arrayContains value: String) async throws -> [T]? {
//        return nil
//    }
//    
//    func getDocument<T: Codable>(from collection: FCollectionReference, with id: String) async throws -> T? {
//        return nil
//    }
//    
//    func listen<T: Codable>(from collection: FCollectionReference) async throws -> AnyPublisher<[T], Error> {
//        print("calling moc Listen")
//
//        let subject = PassthroughSubject<[T], Error>()
//        
//        subject.send(DummyData.speakers as! [T])
//        return subject.eraseToAnyPublisher()
//    }
//    
//    func deleteDocument(with id: String, from collection: FCollectionReference) {
//        
//    }
//}
