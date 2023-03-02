//
//  AddSponsor.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/10/2022.
//

import SwiftUI

struct AddSponsor: View {
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
        .navigationTitle("Sponsors")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddSponsor_Previews: PreviewProvider {
    static var previews: some View {
        AddSponsor()
    }
}
