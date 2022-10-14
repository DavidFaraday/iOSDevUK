//
//  AllSessionsView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 21/09/2022.
//

import SwiftUI

struct AllSessionsView: View {
    
    let sessions: [Session]
    
    var body: some View {
        Form {
            ForEach(sessions) { session in
                
                NavigationLink {
                    SessionDetailView(session: session)
                } label: {
                    SessionRowView(session: session)
                }
            }
        }
        .navigationTitle("Sessions")
    }
}

struct SessionsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AllSessionsView(sessions: DummyData.sessions)
        }
    }
}
