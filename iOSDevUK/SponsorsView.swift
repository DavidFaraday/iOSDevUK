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
                SponsorRow(sponsor: sponsor)
                    .onTapGesture {
                        viewModel.goTo(link: sponsor.url ?? "")
                    }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Sponsors")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SponsorsView_Previews: PreviewProvider {
    static var previews: some View {
        SponsorsView()
    }
}
