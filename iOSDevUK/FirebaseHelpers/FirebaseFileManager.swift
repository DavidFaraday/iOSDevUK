//
//  FirebaseFileManager.swift
//  iOSDevUK
//
//  Created by David Kababyan on 06/02/2023.
//

import Foundation
import FirebaseStorage


class FirebaseFileManager {
    enum UploadDirectory: String {
        case Speakers, Sponsors
    }
    
    static let shared = FirebaseFileManager()
    
    private let FILE_REFERENCE = FirebaseLinks.fileReference
    private let storage = Storage.storage()
    
    private init() {  }
    
    
    //MARK: - Image
    func uploadImage(_ imageData: Data, directory: UploadDirectory) async throws -> String {
        
        
        try await withCheckedThrowingContinuation { continuation in
            
            
            if Reachability.HasConnection() {
                
                let fileName = directory.rawValue + "/" + UUID().uuidString + ".jpg"
                
                let storageRef = storage.reference(forURL: FILE_REFERENCE).child(fileName)
                
                var task : StorageUploadTask!
                
                
                task = storageRef.putData(imageData, metadata: nil, completion: {
                    metadata, error in
                    
                    task.removeAllObservers()
                    
                    if let error = error {
                        continuation.resume(throwing: error)
                        return
                    }
                    
                    storageRef.downloadURL(completion: { (url, error) in
                        
                        guard let downloadUrl = url else {
//                            continuation.resume(throwing: error)
                            return
                        }
                        
                        continuation.resume(returning: downloadUrl.absoluteString)
                    })
                    
                })
            } else {
                //                continuation.resume(throwing: error)
            }
        }
        
    }
    
    
    //    class func downloadImage(imageUrl: String, isMessage: Bool = false, completion: @escaping (_ image: UIImage?) -> Void) {
    //
    //        let imageFileName = fileNameFrom(fileUrl: imageUrl)
    //
    //        if fileExistsAtPath(path: imageFileName) {
    //
    //            if let contentsOfFile = UIImage(contentsOfFile: fileInDocumentsDirectory(filename: imageFileName)) {
    //                completion(contentsOfFile)
    //            } else {
    //                print("couldn't generate local image")
    //                completion(UIImage(named: "avatar"))
    //            }
    //
    //        } else {
    //
    //            if imageUrl != "" {
    //
    //                let documentURL = URL(string: imageUrl)
    //
    //                let downloadQueue = DispatchQueue(label: "imageDownloadQueue")
    //
    //                downloadQueue.async {
    //
    //                    let data = NSData(contentsOf: documentURL!)
    //
    //                    if data != nil {
    //
    //                        let imageToReturn = UIImage(data: data! as Data)
    //
    //                        //save all
    //                        FileStorage.saveFileLocally(fileData: data!, fileName: imageFileName)
    //
    //                        //save locally if its a message
    //                        //                        if isMessage {
    //                        //                            FileStorage.saveFileLocally(fileData: data!, fileName: imageFileName)
    //                        //                        }
    //
    //                        DispatchQueue.main.async {
    //                            completion(imageToReturn!)
    //                        }
    //
    //                    } else {
    //                        DispatchQueue.main.async {
    //                            print("No document in database")
    //                            completion(nil)
    //                        }
    //                    }
    //                }
    //
    //            } else {
    //                completion(UIImage(named: "avatar"))
    //            }
    //        }
    //    }
}
