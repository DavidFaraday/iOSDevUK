//
//  MyScheduleView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI
import CoreData

struct MyScheduleView: View {
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var router: NavigationRouter
    @EnvironmentObject var baseViewModel: BaseViewModel

    @SectionedFetchRequest(sectionIdentifier: \.startDateName!, sortDescriptors: [SortDescriptor(\.startDate)], animation: .default)
    private var records: SectionedFetchResults<String, SavedSession>

    @StateObject private var viewModel = MyScheduleViewModel()

    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        if !records.isEmpty {
            Button(AppStrings.sessions) {
                router.schedulePath.append(Destination.sessions(baseViewModel.sessions))
            }
        }
    }

    
    @ViewBuilder
    private func main() -> some View {
        ZStack {
            VStack {
                List {
                    ForEach(records) { section in
                        
                        Section {
                            ForEach(section) { session in
                                NavigationLink(value: Destination.savedSession(session)) {
                                    SessionRowForLocalSession(session: session)
                                }
                            }
                            .onDelete { indexSet in
                                withAnimation {
                                    viewModel.deleteItem(
                                        for: indexSet,
                                        section: section,
                                        viewContext: context)
                                }
                            }
                        } header: {
                            SectionHeaderView(title: section.id)
                                .font(.headline)
                        }
                    }
                }
            }
            
            if records.isEmpty {
                EmptySessionView(message: AppStrings.emptySessionMessage, buttonTitle: AppStrings.takeMeThere) {
                    router.schedulePath.append(Destination.sessions(baseViewModel.sessions))
                }
            }

        }
    }

    var body: some View {
        NavigationStack(path: $router.schedulePath) {
            main()
                .navigationTitle(AppStrings.mySessions)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
                }
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
                    case .locations(let locations):
                        MapView(allLocations: locations)
                    case .savedSession(let savedSession):
                        SessionDetailView(sessionId: savedSession.id ?? "")
                    }
                }
        }
    }
}

struct MyScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        MyScheduleView()
            .environmentObject(BaseViewModel.sharedMock)
            .environmentObject(NavigationRouter.shared)
            .previewDisplayName("Empty view")
    }
}
