//
//  AddSession.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/10/2022.
//

import SwiftUI

struct AddSession: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: AdminSessionViewModel

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
                TextField("Title", text: $viewModel.title)
                DatePicker("Start date", selection: $viewModel.startDate)
                DatePicker("End date", selection: $viewModel.endDate, in: viewModel.startDate...)

                Picker("Type", selection: $viewModel.type) {
                    ForEach(SessionType.allCases, id: \.self) { type in
                        Text(type.name)
                            .tag(type)
                    }
                }
                
                TextEditor(text: $viewModel.content)
                    .frame(height: 200)
            } header: {
                Text("Session details")
            }
        }
    }

    
    var body: some View {
        main()
            .navigationTitle(viewModel.session?.title ?? "Add Session")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
            }
    }
}

struct AddSession_Previews: PreviewProvider {
    static var previews: some View {
        AddSession(viewModel: AdminSessionViewModel(session: nil))
    }
}
