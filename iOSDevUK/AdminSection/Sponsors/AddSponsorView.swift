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
            Text(AppStrings.save)
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
                    TextField("Image link dark", text: $viewModel.imageLinkDark)
                    Spacer()
                    if !viewModel.imageLinkDark.isEmpty {
                        RemoteImageView(url: URL(string: viewModel.imageLinkDark))
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .frame(width: 50)
                    }
                }

                HStack {
                    TextField("Image link light", text: $viewModel.imageLinkLight)
                    Spacer()
                    if !viewModel.imageLinkLight.isEmpty {
                        RemoteImageView(url: URL(string: viewModel.imageLinkLight))
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .frame(width: 50)
                    }
                }
                
                TextEditor(text: $viewModel.tagline)
                    .frame(height: AppConstants.textViewHeight)
            } header: {
                Text(AppStrings.sponsorDetails)
            }
        }
    }

    
    var body: some View {
        main()
            .navigationTitle(viewModel.sponsor?.name ?? AppStrings.addSponsor)
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
