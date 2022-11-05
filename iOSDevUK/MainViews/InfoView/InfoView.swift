//
//  InfoView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct InfoView: View {

    var body: some View {
        Form {
            NavigationLink(destination: InclusivityView()) { Text("Inclusivity") }
            NavigationLink(destination: SponsorsView()) { Text("Sponsors") }
            NavigationLink(destination: AboutView()) { Text("About iOSDevUK") }
            NavigationLink(destination: AppInformationView()) { Text("App Information") }
            //NavigationLink(destination: AdminView()) { Text("Admin Section") }
        }
        .navigationTitle("Info")
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
