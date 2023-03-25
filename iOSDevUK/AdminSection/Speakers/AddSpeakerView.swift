//
//  AddSpeakerView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/10/2022.
//

import SwiftUI
import PhotosUI

struct AddSpeakerView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: AdminSpeakerViewModel
        
    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        Button {
            Task {
                await viewModel.save()
            }
            dismiss()
        } label: {
            Text("Save")
        }
        .disabled(viewModel.invalidForm())
    }
    
    @ViewBuilder
    private func photoPickerView() -> some View {
        PhotosPicker(selection: $viewModel.selectedItem, matching: .images, photoLibrary: .shared()) {
            HStack {
                Text("Select image")
                Spacer()
                if let imageData = viewModel.selectedImageData,
                   let uiImage = UIImage(data: imageData) {
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
        .onChange(of: viewModel.selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    viewModel.selectedImageData = data
                }
            }
        }
    }
    
    @ViewBuilder
    private func main() -> some View {
        Form {
            Section {
                TextField("Full name", text: $viewModel.fullName)
                TextField("Twitter", text: $viewModel.twitter)
                TextField("Linkedin", text: $viewModel.linkedIn)
                HStack {
                    TextField("Image link", text: $viewModel.imageLink)
                    Spacer()
                    if !viewModel.imageLink.isEmpty {
                        RemoteImageView(url: URL(string: viewModel.imageLink))
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .frame(width: 50)
                    }
                }
//                photoPickerView()
                TextEditor(text: $viewModel.bio)
                    .frame(height: 200)
            } header: {
                Text("Personal Info")
            }

//            Section {
//                TextField("Name", text: $viewModel.webLinkName)
//                TextField("Url", text: $viewModel.url)
//            } header: {
//                Text("Web links")
//            }
        }
    }

    
    var body: some View {
        main()
            .navigationTitle(viewModel.speaker?.name ?? "Add Speaker")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
            }
    }
}

struct AddSpeaker_Previews: PreviewProvider {
    static var previews: some View {
        AddSpeakerView(viewModel: AdminSpeakerViewModel())
    }
}
