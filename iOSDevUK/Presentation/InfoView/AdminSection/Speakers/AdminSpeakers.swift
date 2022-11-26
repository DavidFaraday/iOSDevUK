//
//  AdminSpeakers.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/10/2022.
//

import SwiftUI

struct AdminSpeakers: View {
//    @StateObject private var viewModel = AdminSpeakersViewModel()
    @EnvironmentObject var viewModel: BaseViewModel    
    
    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        NavigationLink {
            AddSpeakerView()
        } label: {
            Image(systemName: "plus.circle")
        }
    }

    @ViewBuilder
    private func main() -> some View {
        Form {
            ForEach(viewModel.speakers) { speaker in
                NavigationLink {
                    AddSpeakerView(speaker: speaker)
                } label: {
                    Text(speaker.name)
                        .font(.subheadline)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
        }
    }
    
    var body: some View {
        main()
            .navigationTitle("Speakers")
    }

}

struct AdminSpeakers_Previews: PreviewProvider {
    static var previews: some View {
        AdminSpeakers()
    }
}
