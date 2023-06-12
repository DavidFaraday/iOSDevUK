//
//  AdminSpeakerViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 15/01/2023.
//

import SwiftUI
import PhotosUI
import Factory

final class AdminSpeakerViewModel: ObservableObject {
    @Injected(\.firebaseRepository) private var firebaseRepository

    @Published var fullName = ""
    @Published var twitter = ""
    @Published var linkedIn = ""
    @Published var imageLink = ""
    @Published var selectedItem: PhotosPickerItem?
    @Published var selectedImageData: Data? = nil
    @Published var bio = "Bio"
    
    @Published var webLinkName = ""
    @Published var url = ""

    var speaker: Speaker?

    init(speaker: Speaker? = nil) {
        self.speaker = speaker
        setupUI()
    }
    
    private func setupUI() {
        guard let speaker = speaker else { return }
        
        fullName = speaker.name
        twitter = speaker.twitterId
        linkedIn = speaker.linkedIn
        imageLink = speaker.imageLink
        bio = speaker.biography
    }
    
    func save() async {
        let newSpeaker = Speaker(id: speaker?.id ?? UUID().uuidString, name: fullName, biography: bio, linkedIn: linkedIn, twitterId: twitter, imageLink: imageLink, webLinks: nil)

        do {
            try firebaseRepository.saveData(data: newSpeaker, to: .Speaker)
        }
        catch {
            print("Error saving speaker", error.localizedDescription)
        }

        //With image uploading func Will add in new version
//        Task {
//            let imageLink = await uploadAvatar()
//
//            let newSpeaker = Speaker(id: speaker?.id ?? UUID().uuidString, name: fullName, biography: bio, linkedIn: linkedIn, twitterId: twitter, imageLink: imageLink, webLinks: nil)
//        do {
//            try FirebaseReference(.Speaker).document(newSpeaker.id).setData(from: newSpeaker)
//        }
//        catch {
//            print("Error saving speaker", error.localizedDescription)
//        }
//        }
    }
    
    
//    func uploadAvatar() async -> String {
//        guard let imageData = selectedImageData else { return "" }
//
//        do  {
//            return try await FirebaseFileManager.shared.uploadImage(imageData, directory: .Speakers)
//        } catch {
//            print(error.localizedDescription)
//            return ""
//        }
//    }

    func deleteSpeaker(_ speaker: Speaker) {
        firebaseRepository.deleteDocument(with: speaker.id, from: .Speaker)
    }
    
    func invalidForm() -> Bool {
        fullName == "" || bio == "" || imageLink == ""
    }
}

