//
//  AllLocationsView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct AllLocationsView: View {
    @StateObject private var viewModel: AllLocationsViewModel

    init(viewModel: AllLocationsViewModel = AllLocationsViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        List {
            ForEach(viewModel.locations) { location in
                LocationCellView(location: location)
            }
        }
        .listStyle(.grouped)
        .navigationTitle("All Locations")
        .task {
            await viewModel.getLocations()
        }
    }
}

struct AllLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView {
            AllLocationsView()
        }

    }
}
