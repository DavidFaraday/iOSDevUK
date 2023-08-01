//
//  FCollectionReference.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import Firebase
import FirebaseFirestoreSwift


enum FCollectionReference: String {
    case Speaker
    case Session
    case Sponsor
    case Location
    case InformationItem
    case AppInformation
    case TestData //used only for testing purposes
}


func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}
