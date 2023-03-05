//
//  AdminSessions.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/10/2022.
//

import SwiftUI

struct AdminSessions: View {
    @EnvironmentObject var viewModel: BaseViewModel
    @StateObject private var adminSessionViewModel = AdminSessionViewModel()

    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        NavigationLink(value: InfoDestination.adminAddSession(nil)) {
            Image(systemName: "plus")
                .font(.title3)
        }
    }
    
    @ViewBuilder
    private func main() -> some View {
        Form {
            ForEach(viewModel.sessions, id: \.id) { session in
                NavigationLink(value: InfoDestination.adminAddSession(session)) {
                    SessionRowView(session: session)
                }
            }
            .onDelete { indexSet in
                guard let index = indexSet.first else { return }
                adminSessionViewModel.deleteSession(viewModel.sessions[index])
            }
        }
        .listStyle(.plain)
    }


    var body: some View {
        main()
            .navigationTitle("Sessions")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
            }
    }
}

struct AdminSessions_Previews: PreviewProvider {
    static var previews: some View {
        AdminSessions()
    }
}
