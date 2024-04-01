//
//  LocationsListView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 25/03/2023.
//

import SwiftUI

struct LocationsListView: View {
    @EnvironmentObject var viewModel: BaseViewModel
    @State var expanded: Bool = true
    var groupedLocations: [String : [Location]] {
        .init(
            grouping: viewModel.locations,
            by: { $0.locationType.rawValue }
        )
    }
    
    @ViewBuilder
    private func main() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            NavigationLink(value: InfoDestination.locations(locations: viewModel.locations)) {
                UniversityMapView()
                    .padding(.horizontal, 16)
            }
            .buttonStyle(.plain)
            
            ScrollView {
                ForEach(groupedLocations.keys.sorted(), id: \String.self) { key in
                    let locationType: LocationType = LocationType(rawValue: key) ?? .au
                    
                    DropDownRowView(
                        title: locationType.name,
                        imageName: locationType.shortName,
                        locations: groupedLocations[key] ?? []
                    )
                    .padding(.horizontal, 16)
                }
            }
        }
    }
    
    
    var body: some View {
        main()
            .navigationBarTitle(AppStrings.locations, displayMode: .inline)
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
    }
}
