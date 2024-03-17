//
//  SponsorsView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 27/10/2022.
//

import SwiftUI

struct SponsorsScreen: View {
    @EnvironmentObject var viewModel: BaseViewModel

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 20) {
                ForEach(viewModel.sponsors) { sponsor in
                    SponsorRow(sponsor: sponsor)
                }
            }
            .padding([.top, .horizontal], 16)
        }
        .navigationTitle(AppStrings.sponsors)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SponsorsView_Previews: PreviewProvider {
    static var previews: some View {
        SponsorsScreen()
    }
}
