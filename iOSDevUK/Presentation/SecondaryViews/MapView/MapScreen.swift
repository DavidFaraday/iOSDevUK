//
//  MapView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 18/10/2022.
//

import SwiftUI
import MapKit

struct MapScreen: View {
    @EnvironmentObject var locationManager: LocationService
    @Environment(\.presentationMode) var presentationMode

    @StateObject var viewModel: MapViewModel
    @State var selectedLocation: Location?
    
    init(allLocations: [Location]) {
        self.init(viewModel: MapViewModel(allLocations: allLocations))
    }
    
    private init(viewModel: MapViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @ViewBuilder
    private func navigationBarLeadingItem() -> some View {
        Button { presentationMode.wrappedValue.dismiss() }
        label: { Image(.back) }
            .tint(Color(.mainText))
    }

    @ViewBuilder
    private func locationDeniedLabel() -> some View {
        Text("Location access denied.\n You can enable it in Setting->Privacy & Security.")
            .appFont(size: 14)
            .foregroundColor(.pink)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
    
    @ViewBuilder
    private func mapView() -> some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: viewModel.filteredAnnotations()) { location in
            
            MapAnnotation(coordinate: location.coordinate) {
                MapPinView(imageName: location.locationType.shortName, isSelected: selectedLocation == location)
                    .onTapGesture {
                        withAnimation {
                            selectedLocation = location
                        }
                    }
            }
        }
        .accentColor(Color(.systemPink))
    }
    
    
    @ViewBuilder
    private func categoryPicker() -> some View {
        Picker("Location type", selection: $viewModel.locationCategory) {
            ForEach(LocationType.allCases, id: \.self) { location in
                Text(location.shortName)
            }
        }
        .pickerStyle(.segmented)
        .padding(5)
        .onChange(of: viewModel.locationCategory) { _ in
            selectedLocation = nil
            viewModel.updateRegion()
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            mapView()
            
            if let selectedLocation {
                LocationInfoCardView(location: selectedLocation) {
                    MapViewModel.openInAppleMaps(location: selectedLocation)
                }
                .padding(16)
            }
        }
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
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading, content: navigationBarLeadingItem)
        }

    }
}

struct MapView_Previews: PreviewProvider {
    @EnvironmentObject var locationManager: LocationService
    
    static var previews: some View {
        MapScreen(allLocations: [DummyData.location]).environmentObject(LocationService.shared)
    }
}
