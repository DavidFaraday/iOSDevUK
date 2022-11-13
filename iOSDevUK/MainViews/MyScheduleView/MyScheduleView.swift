//
//  MyScheduleView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI
import CoreData

struct MyScheduleView: View {
    @Environment(\.managedObjectContext) var moc
    
    
    @SectionedFetchRequest(sectionIdentifier: \.startDateName, sortDescriptors: [SortDescriptor(\.startDate)], animation: .default)
    private var records: SectionedFetchResults<String?, SavedSession>
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.startDate)]) var sessions: FetchedResults<SavedSession>
    
    @StateObject private var viewModel = MyScheduleViewModel()

    var body: some View {
        List {
            ForEach(records) { section in
                Section(header: Text(section.id ?? "")) {
                    ForEach(section) { session in
                        
                        NavigationLink {
                            SessionDetailView(sessionId: session.id ?? "")
                        } label: {
                            SessionRowForLocalSession(session: session)
                        }
                    }
                    .onDelete(perform: delete)
                }
            }
        }
        .navigationTitle("My Sessions")
    }
    
    private func delete(at offsets: IndexSet) {
        for offset in offsets {
            let session = sessions[offset]
            moc.delete(session)
        }
        
        try? moc.save()
    }
}

struct MyScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        MyScheduleView()
    }
}
