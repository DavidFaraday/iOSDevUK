//
//  AttendeeView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct AttendeeView: View {
    @StateObject private var viewModel: AttendeeViewModel
    
    var categories: [String : [Location]] {
        .init(
            grouping: viewModel.allLocations,
            by: {$0.locationTypeRecordName }
        )
    }

    init(viewModel: AttendeeViewModel = AttendeeViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        NavigationLink {
            MapView(allLocations: viewModel.allLocations)
        } label: {
            Text("All locations")
                .bold()
        }
    }

    
    @ViewBuilder
    private func informationView() -> some View {
        ForEach(viewModel.informationItems) { item in
            NavigationLink(item.name) {
                Text(item.name)
            }
        }
    }
    
    @ViewBuilder
    private func locationCategoryView() -> some View {
        
        ForEach(categories.keys.sorted(), id: \String.self) { key in
            
            Section(locationName(from: key)) {
                ForEach(categories[key] ?? [], id: \.id) { location in
                    NavigationLink {
                        MapView(allLocations: [location])
                    } label: {
                        Text(location.name)
                            .font(.subheadline)
                            .lineLimit(1)
                            .minimumScaleFactor(0.6)
                    }
                }
            }
        }
    }
    
    
    @ViewBuilder
    private func main() -> some View {
        
        Form {
            Section("Information") {
                informationView()
            }
            
            Section { } header: {
                Text("Locations")
                      .font(.headline)
                      .foregroundColor(.primary)
            }
            .padding(.bottom, -10)
                
            locationCategoryView()
        }
    }

    var body: some View {
        main()
            .navigationTitle("Attendee Info")
            .task(viewModel.listenForLocations)
            .task(viewModel.fetchInformationItems)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
            }
    }
}

struct AttendeeView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeView()
    }
}
