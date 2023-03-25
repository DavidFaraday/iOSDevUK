//
//  AddSponsorView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/10/2022.
//

import SwiftUI

struct AddSponsorView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: AdminSponsorViewModel

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
    private func main() -> some View {
        Form {
            Section {
                TextField("Name", text: $viewModel.name)
                TextField("Url in https:// format", text: $viewModel.url)
                TextField("Link Text", text: $viewModel.urlText)
                
                Picker("Category", selection: $viewModel.category) {
                    ForEach(SponsorCategory.allCases, id: \.self) { category in
                        Text(category.rawValue)
                            .tag(category)
                    }
                }
                
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
                
                TextEditor(text: $viewModel.tagline)
                    .frame(height: 200)
            } header: {
                Text("Sponsor details")
            }
        }
    }

    
    var body: some View {
        main()
            .navigationTitle(viewModel.sponsor?.name ?? "Add Sponsor")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
            }
    }
}

struct AddSponsor_Previews: PreviewProvider {
    static var previews: some View {
        AddSponsorView(viewModel: AdminSponsorViewModel())
    }
}
