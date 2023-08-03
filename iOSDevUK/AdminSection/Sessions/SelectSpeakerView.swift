//
//  SelectSpeakerView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/04/2023.
//

import SwiftUI

struct SelectSpeakerView: View {
        
    @EnvironmentObject var viewModel: BaseViewModel
    @Environment(\.dismiss) var dismiss


    @Binding var selectedSpeakers: Set<Speaker>

    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        Button {
            dismiss()
        } label: {
            Text(AppStrings.save)
        }
    }


    @ViewBuilder
    private func main() -> some View {
        Form {
            ForEach(viewModel.speakers) { speaker in
                Button(action: { toggleSelection(speaker) }) {
                    HStack {
                        Text(speaker.name)
                            .font(.subheadline)
                        Spacer()
                        if selectedSpeakers.contains(where: { $0.id == speaker.id }) {
                            Image(systemName: ImageNames.checkmark)
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(Color.accentColor)
                        }
                    }
                }
                .tag(speaker.id)
            }
        }
    }

    var body: some View {
        NavigationStack {
            main()
                .navigationTitle(AppStrings.selectSpeakers)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
                }

        }
    }
    
    private func toggleSelection(_ speaker: Speaker) {
        if let existingIndex = selectedSpeakers.firstIndex(where: { $0.id == speaker.id }) {
            selectedSpeakers.remove(at: existingIndex)
        } else {
            selectedSpeakers.insert(speaker)
        }
    }

}

struct SelectSpeakerView_Previews: PreviewProvider {
    static var previews: some View {
        SelectSpeakerView(selectedSpeakers: .constant([]))
    }
}
