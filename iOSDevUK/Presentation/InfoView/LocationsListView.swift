//
//  LocationsListView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 25/03/2023.
//

import SwiftUI

struct LocationsListView: View {
    @EnvironmentObject var viewModel: BaseViewModel
    
    var categories: [String : [Location]] {
        .init(
            grouping: viewModel.locations,
            by: { $0.locationType.rawValue }
        )
    }
    
    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        NavigationLink(AppStrings.map, value: InfoDestination.locations(locations: viewModel.locations))
    }
    

    @ViewBuilder
    private func main() -> some View {
        
        Form {
            ForEach(categories.keys.sorted(), id: \String.self) { key in
                
                Section {
                    ForEach(categories[key] ?? [], id: \.id) { location in
                        
                        NavigationLink(value: InfoDestination.locations(locations: [location])) {
                            Text(location.name)
                                .font(.subheadline)
                                .lineLimit(1)
                                .minimumScaleFactor(0.6)
                        }
                    }
                } header: {
                    let locationType: LocationType = LocationType(rawValue: key) ?? .au
                    SectionHeaderView(title: locationType.name)
                        .font(.headline)
                }
            }
        }
    }


    var body: some View {
        main()
            .navigationBarTitle(AppStrings.locations, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
            }
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
    }
}
