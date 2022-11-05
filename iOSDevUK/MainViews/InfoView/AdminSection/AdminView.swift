//
//  AdminView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/10/2022.
//

import SwiftUI

struct AdminView: View {
    
    var body: some View {
        Form {
            NavigationLink(destination: AdminSpeakers()) { Text("Speakers") }
            NavigationLink(destination: AdminSessions()) { Text("Sessions") }
            NavigationLink(destination: InclusivityView()) { Text("Locations") }
            NavigationLink(destination: InclusivityView()) { Text("Sponsors") }

        }
        .navigationTitle("Admin Area")
    }
}

struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
