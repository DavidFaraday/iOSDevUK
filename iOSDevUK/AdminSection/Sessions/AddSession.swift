//
//  AddSession.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/10/2022.
//


/*
 each session has speakerIds array
 we show view of all speakers, user selects multiple
 on navigate back we keep binding array of selected speakers
 on the cell we show speaker names that were selected
 when saved, we take array of speakers and save each speaker id to array and assign to a session.
 when we load a session for edit, we pull speakers from ids and populate the array to show in the cell also show selection if the user goes to edit speakers
 same do with the location
 */

import SwiftUI

struct AddSession: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var baseViewModel: BaseViewModel
    @ObservedObject var viewModel: AdminSessionViewModel
    
    @State private var showSpeakersView = false
    @State private var selectedSpeakers = Set<Speaker>()
    
    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        Button {
            Task {
                await viewModel.save(speakers: selectedSpeakers)
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
            TextField("Title", text: $viewModel.title)
            DatePicker("Start date", selection: $viewModel.startDate)
            DatePicker("End date", selection: $viewModel.endDate, in: viewModel.startDate...)
            
            
            Picker("Location", selection: $viewModel.location) {
                ForEach(baseViewModel.locations.filter({ $0.locationType == .au })) { location in
                    Text(location.name)
                        .tag(location as Location?)
                }
            }
            
            //TODO: Need work with pickers
            //                Picker("Speakers", selection: $viewModel.speaker) {
            //                    ForEach(baseViewModel.speakers) { speaker in
            //                        Text(speaker.name)
            //                            .tag(speaker as Speaker?)
            //                    }
            //                }
            
            Picker("Type", selection: $viewModel.type) {
                ForEach(SessionType.allCases, id: \.self) { type in
                    Text(type.name)
                        .tag(type)
                }
            }
            
            VStack(alignment: .leading, spacing: 4.0) {
                Text("Speakers")
                if !selectedSpeakers.isEmpty {
                    Text( selectedSpeakers.map { $0.name }, format: .list(type: .and))
                        .foregroundColor(.red)
                        .multilineTextAlignment(.leading)
                }
            }
            .onTapGesture {
                showSpeakersView = true
            }
            
            
            TextEditor(text: $viewModel.content)
                .frame(height: AppConstants.textViewHeight)
        }
    }
    
    var body: some View {
        main()
            .navigationTitle(viewModel.session?.title ?? "Add Session")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
            }
            .sheet(isPresented: $showSpeakersView, content: {
                SelectSpeakerView(selectedSpeakers: $selectedSpeakers)
            })
    }
}

struct AddSession_Previews: PreviewProvider {
    static var previews: some View {
        AddSession(viewModel: AdminSessionViewModel(session: nil))
    }
}
