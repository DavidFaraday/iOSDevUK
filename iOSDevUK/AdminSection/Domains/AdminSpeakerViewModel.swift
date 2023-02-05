//
//  AdminSpeakerViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 15/01/2023.
//

import SwiftUI
import PhotosUI

final class AdminSpeakerViewModel: ObservableObject {
    
    @Published var fullName = ""
    @Published var twitter = ""
    @Published var linkedIn = ""
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
        bio = speaker.biography
    }
    
    func save() {
        //TODO: check if image was changed
        let newSpeaker = Speaker(id: speaker?.id ?? UUID().uuidString, name: fullName, biography: bio, linkedIn: linkedIn, twitterId: twitter, imageLink: "", webLinks: nil)
        
        do {
            try FirebaseReference(.Speaker).document(newSpeaker.id).setData(from: newSpeaker)
        }
        catch {
            print("Error saving speaker", error.localizedDescription)
        }
    }
    
    
    func uploadAvatar() async {
        
    }

    func deleteSpeaker(_ speaker: Speaker) {
        FirebaseReference(.Speaker).document(speaker.id).delete()
    }
}

