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
    private func locationCategoryView() -> some View {
        
        ForEach(categories.keys.sorted(), id: \String.self) { key in
            
            Section(locationName(from: key)) {
                ForEach(categories[key] ?? [], id: \.id) { location in
                    NavigationLink {
                        Text(location.name)
                        //TODO: show mapView with the location
                    } label: {
                        LocationRowView(location: location)
                    }
                }
            }
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
    private func main() -> some View {
        
        Form {
            Section("Information") {
                informationView()
            }
            
            Section("Locations") { }
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.bottom, -10)
            locationCategoryView()
        }
    }

    var body: some View {
        main()
            .navigationTitle("Attendee Info")
            .task(viewModel.fetchLocations)
            .task(viewModel.fetchInformationItems)
    }
}

struct AttendeeView_Previews: PreviewProvider {
    static var previews: some View {
        AttendeeView()
    }
}
