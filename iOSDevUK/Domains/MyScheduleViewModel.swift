//
//  MyScheduleViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//
import CoreData
import SwiftUI

final class MyScheduleViewModel: ObservableObject {
    
    func deleteItem(for indexSet: IndexSet, section: SectionedFetchResults<String, SavedSession>.Element, viewContext: NSManagedObjectContext) {
      
        indexSet.map { section[$0] }.forEach(viewContext.delete)

        DataController.save(context: viewContext)
    }

}
