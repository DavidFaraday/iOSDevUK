//
//  AdminSpeakers.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/10/2022.
//

import SwiftUI

struct AdminSpeakers: View {
    @EnvironmentObject var viewModel: BaseViewModel
    @StateObject private var adminSpeakerViewModel = AdminSpeakerViewModel()
    
    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        NavigationLink(value: InfoDestination.adminAddSpeaker(nil)) {
            Image(systemName: ImageNames.plus)
                .font(.title3)
        }
    }

    @ViewBuilder
    private func main() -> some View {
        Form {
            ForEach(viewModel.speakers) { speaker in
                NavigationLink(value: InfoDestination.adminAddSpeaker(speaker)) {
                    Text(speaker.name)
                        .font(.subheadline)
                }
            }
            .onDelete { indexSet in
                guard let index = indexSet.first else { return }
                adminSpeakerViewModel.deleteSpeaker(viewModel.speakers[index])
            }
        }
        
    }
    
    var body: some View {
        main()
            .navigationTitle(AppStrings.speakers)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
            }
    }

}

struct AdminSpeakers_Previews: PreviewProvider {
    static var previews: some View {
        AdminSpeakers()
    }
}
