//
//  InfoView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct InfoView: View {
    @EnvironmentObject var router: NavigationRouter

    var body: some View {
        NavigationStack(path: $router.infoPath) {
            Form {
                NavigationLink("Inclusivity", value: InfoDestination.inclusivity)
                NavigationLink("Sponsors", value: InfoDestination.sponsors)
                NavigationLink("About iOSDevUK", value: InfoDestination.aboutApp)
                NavigationLink("App Information", value: InfoDestination.appInformation)
            }
            .navigationTitle("Info")
            .navigationDestination(for: InfoDestination.self) { destination in
                switch destination {
                case .inclusivity:
                    InclusivityView()
                case .sponsors:
                    SponsorsView()
                case .aboutApp:
                    AboutView()
                case .appInformation:
                    AppInformationView()
                }
            }
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
