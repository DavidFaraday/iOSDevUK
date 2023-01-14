//
//  AdminSpeakers.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/10/2022.
//

import SwiftUI

struct AdminSpeakers: View {
    @EnvironmentObject var viewModel: BaseViewModel
    
    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        NavigationLink(value: InfoDestination.adminAddSpeaker(nil)) {
            Image(systemName: "plus")
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
