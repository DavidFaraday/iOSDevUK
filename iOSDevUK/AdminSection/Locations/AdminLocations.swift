//
//  AdminLocations.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/10/2022.
//

import SwiftUI

struct AdminLocations: View {
    @EnvironmentObject var viewModel: BaseViewModel
    @StateObject private var adminLocationViewModel = AdminLocationViewModel()

    var categories: [String : [Location]] {
        .init(
            grouping: viewModel.locations,
            by: { $0.locationType.rawValue }
        )
    }
    
    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        NavigationLink(value: InfoDestination.adminAddLocation(nil)) {
            Image(systemName: "plus")
                .font(.title3)
        }
    }

    
    @ViewBuilder
    private func main() -> some View {
        Form {
            ForEach(categories.keys.sorted(), id: \String.self) { key in
                
                Section {
                    ForEach(categories[key] ?? [], id: \.id) { location in
                        
                        NavigationLink(value: InfoDestination.adminAddLocation(location)) {
                            Text(location.name)
                                .font(.subheadline)
                                .lineLimit(1)
                                .minimumScaleFactor(0.6)
                        }
                    }
                    .onDelete { indexSet in
                        guard let index = indexSet.first, let locations = categories[key] else { return }
                        adminLocationViewModel.deleteLocation(locations[index])
                    }
                } header: {
                    let locationType: LocationType = LocationType(rawValue: key) ?? .other
                    SectionHeaderView(title: locationType.name)
                        .font(.headline)
                }
            }
        }
    }
    
    var body: some View {
        main()
            .navigationTitle("Locations")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
            }
    }
}

struct AdminLocations_Previews: PreviewProvider {
    static var previews: some View {
        AdminLocations()
    }
}
