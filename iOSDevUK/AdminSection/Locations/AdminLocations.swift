//
//  AdminLocations.swift
//  iOSDevUK
//
//  Created by David Kababyan on 20/10/2022.
//

import SwiftUI

struct AdminLocations: View {
    @EnvironmentObject var viewModel: BaseViewModel
    
    var categories: [String : [Location]] {
        .init(
            grouping: viewModel.locations,
            by: { $0.locationType.rawValue }
        )
    }
    
    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        Image(systemName: "plus.circle")
    }
    
    
    @ViewBuilder
    private func main() -> some View {
        Form {
            
            ForEach(categories.keys.sorted(), id: \String.self) { key in
                
                Section {
                    ForEach(categories[key] ?? [], id: \.id) { location in
                        
                        NavigationLink(value: Destination.locations([location])) {
                            Text(location.name)
                                .font(.subheadline)
                                .lineLimit(1)
                                .minimumScaleFactor(0.6)
                        }
                    }
                } header: {
                    SectionHeaderView(title: Location.locationName(from: key))
                        .font(.headline)
                }
            }
        }
    }
    
    var body: some View {
        main()
            .navigationTitle("Locations")
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
