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
    @StateObject private var viewModel: MyScheduleViewModel
    
    
    @SectionedFetchRequest(sectionIdentifier: \.startDateName, sortDescriptors: [SortDescriptor(\.startDate)], animation: .default)
    private var records: SectionedFetchResults<String?, SavedSession>
    
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.startDate)]) var sessions: FetchedResults<SavedSession>
    
    init(viewModel: MyScheduleViewModel = MyScheduleViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            List {
                ForEach(records) { section in
                    Section(header: Text(section.id ?? "hmm")) {
                        ForEach(section) { session in
                            Text(session.title ?? "")
                        }
                        .onDelete(perform: delete)
                    }
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
