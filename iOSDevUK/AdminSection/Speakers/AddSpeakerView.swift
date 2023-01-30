//
//  AddSpeakerView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/10/2022.
//

import SwiftUI
import PhotosUI

struct AddSpeakerView: View {
    @StateObject private var viewModel =  AdminSpeakerViewModel()
    var speaker: Speaker?
    
    @State private var fullName = ""
    @State private var twitter = ""
    @State private var linkedIn = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data? = nil
    @State private var bio = "Bio"
    
    @State private var webLinkName = ""
    @State private var url = ""

    
    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        Button {
            let speaker = Speaker(id: UUID().uuidString, name: fullName, biography: bio, linkedIn: linkedIn, twitterId: twitter, imageLink: "", webLinks: nil)
            
            viewModel.save(speaker: speaker)
        } label: {
            Text("Save")
        }
    }
    
    @ViewBuilder
    private func photoPickerView() -> some View {
        PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
            HStack {
                Text("Select image")
                Spacer()
                if let selectedImageData,
                   let uiImage = UIImage(data: selectedImageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .frame(width: 50)
                } else {
                    Image(systemName: "photo")
                        .font(.title)
                }
            }
            .frame(height: 50)
        }
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    selectedImageData = data
                }
            }
        }
    }
    
    @ViewBuilder
    private func main() -> some View {
        Form {
            Section {
                TextField("Full name", text: $fullName)
                TextField("Twitter", text: $twitter)
                TextField("Linkedin", text: $linkedIn)
                photoPickerView()
                TextEditor(text: $bio)
                    .frame(height: 80)
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
