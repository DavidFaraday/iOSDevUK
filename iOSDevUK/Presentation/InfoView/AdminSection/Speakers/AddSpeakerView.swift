//
//  AddSpeakerView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/10/2022.
//

import SwiftUI

struct AddSpeakerView: View {
    var adminViewModel =  AdminViewModel()
    var speaker: Speaker?
    
    @State private var fullName = ""
    @State private var twitter = ""
    @State private var linkedIn = ""
    @State private var bio = "Bio"
    
    @State private var webLinkName = ""
    @State private var url = ""
    
    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        Button {
            let speaker = Speaker(id: UUID().uuidString, name: fullName, biography: bio, linkedIn: linkedIn, twitterId: twitter, imageLink: "", webLinks: nil)
            
            adminViewModel.save(speaker: speaker)
        } label: {
            Text("Save")
        }
    }
    
    @ViewBuilder
    private func main() -> some View {
        Form {
            Section {
                TextField("Full name", text: $fullName)
                TextField("Twitter", text: $twitter)
                TextField("Linkedin", text: $linkedIn)
                TextEditor(text: $bio)
            } header: {
                Text("Personal Info")
            }
            
//            Section {
//                TextField("Name", text: $webLinkName)
//                TextField("Url", text: $url)
//            } header: {
//                Text("Web links")
//            }
        }
    }

    
    var body: some View {
        main()
        .navigationTitle(speaker?.name ?? "Add Speaker")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
        }

    }
}

struct AddSpeaker_Previews: PreviewProvider {
    static var previews: some View {
        AddSpeakerView()
    }
}
