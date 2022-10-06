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
}


func FirebaseReference(_ collectionReference: FCollectionReference) -> CollectionReference{
    return Firestore.firestore().collection(collectionReference.rawValue)
}
