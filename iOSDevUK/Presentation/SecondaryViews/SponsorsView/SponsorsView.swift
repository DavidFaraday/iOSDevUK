//
//  SponsorsView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 27/10/2022.
//

import SwiftUI

struct SponsorsView: View {
    @EnvironmentObject var viewModel: BaseViewModel

    var body: some View {
        List {
            ForEach(viewModel.sponsors, id: \.id) { sponsor in
                if let url = sponsor.webUrl {
                    Link(destination: url) {
                        SponsorRow(sponsor: sponsor)
                    }
                } else {
                    SponsorRow(sponsor: sponsor)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle(AppStrings.sponsors)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SponsorsView_Previews: PreviewProvider {
    static var previews: some View {
        SponsorsView()
            .environmentObject(BaseViewModel.sharedMock)
    }
}
