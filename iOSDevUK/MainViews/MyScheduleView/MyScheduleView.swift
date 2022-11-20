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
    @EnvironmentObject var router: NavigationRouter
    
    @SectionedFetchRequest(sectionIdentifier: \.startDateName, sortDescriptors: [SortDescriptor(\.startDate)], animation: .default)
    
    private var records: SectionedFetchResults<String?, SavedSession>
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.startDate)]) var sessions: FetchedResults<SavedSession>
    
    @StateObject private var viewModel = MyScheduleViewModel()
    
    @ViewBuilder
    private func main() -> some View {
        List {
            ForEach(records) { section in
                Section(header: Text(section.id ?? "")) {
                    ForEach(section) { session in
                        
                        NavigationLink(value: Destination.savedSession(session)) {
                            SessionRowForLocalSession(session: session)
                        }
                    }
                    .onDelete(perform: delete)
                }
            }
        }
    }
    
    var body: some View {
        NavigationStack(path: $router.schedulePath) {
            main()
                .navigationTitle("My Sessions")
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                    case .session(let session):
                        SessionDetailView(sessionId: session.id)
                    case .sessions(let sessions):
                        AllSessionsView(sessions: sessions)
                    case .speaker(let speaker):
                        SpeakerDetailView(speaker: speaker)
                    case .speakers(let speakers):
                        AllSpeakersView(speakers: speakers)
                    case .sponsor:
                        SponsorsView()
                    case .locations(_):
                        MapView(allLocations: [])
                    case .savedSession(let savedSession):
                        SessionDetailView(sessionId: savedSession.id ?? "")
                    }
                }
        }
    }

    //TODO: move to VM
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
