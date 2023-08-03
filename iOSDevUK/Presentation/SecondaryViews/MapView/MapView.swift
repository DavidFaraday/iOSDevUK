//
//  MapView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 18/10/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var locationManager: LocationService
    @StateObject var viewModel: MapViewModel

    init(allLocations: [Location]) {
        self.init(viewModel: MapViewModel(allLocations: allLocations))
    }

    private init(viewModel: MapViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    @ViewBuilder
     private func locationDeniedLabel() -> some View {
       Text("Location access denied.\n You can enable it in Setting->Privacy & Security.")
         .font(.caption)
         .foregroundColor(.pink)
         .frame(maxWidth: .infinity)
         .multilineTextAlignment(.center)
         .padding(.horizontal)
     }

    @ViewBuilder
    private func categoryPicker() -> some View {
        Picker("", selection: $viewModel.locationCategory) {
            ForEach(LocationType.allCases, id: \.self) { location in
                Text(location.shortName)
            }
        }
        .pickerStyle(.segmented)
        .padding(.vertical, 5)
        .onChange(of: viewModel.locationCategory) {_ in
            viewModel.updateRegion()
        }
    }
    
    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: viewModel.filteredAnnotations()) { location in
            MapAnnotation(coordinate: location.coordinate) {
                LocationMapAnnotation(location: location, showAnnotation: viewModel.allLocations.count == 1) {
                    MapViewModel.openInAppleMaps(location: location)
                }
            }
        }
        .accentColor(Color(.systemPink))
        .navigationBarTitle(AppStrings.map, displayMode: .inline)
        .safeAreaInset(edge: .bottom) {
            if locationManager.locationManager?.authorizationStatus == .denied {
                locationDeniedLabel()
            }
        }
        .safeAreaInset(edge: .top) {
            if viewModel.allLocations.count > 1 {
                categoryPicker()
            }
        }
        .onAppear() {
            viewModel.updateRegion()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    @EnvironmentObject var locationManager: LocationService

    static var previews: some View {
        MapView(allLocations: [DummyData.location]).environmentObject(LocationService.shared)
    }
}
