//
//  AddLocation.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/10/2022.
//

import SwiftUI

struct AddLocation: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: AdminLocationViewModel

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
                TextField("Latitude", text: $viewModel.latitude)
                    .keyboardType(.decimalPad)
                TextField("Latitude", text: $viewModel.longitude)
                    .keyboardType(.decimalPad)

                Picker("Type", selection: $viewModel.locationType) {
                    ForEach(LocationType.allCases, id: \.self) { location in
                        Text(location.name)
                            .tag(location)
                    }
                }
                TextEditor(text: $viewModel.note)
                    .frame(height: AppConstants.textViewHeight)

            } header: {
                Text(AppStrings.locationDetails)
            }
        }
    }

    var body: some View {
        main()
            .navigationTitle(viewModel.location?.name ?? AppStrings.addLocation)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
            }
    }
}

struct AddLocation_Previews: PreviewProvider {
    static var previews: some View {
        AddLocation(viewModel: AdminLocationViewModel())
    }
}
