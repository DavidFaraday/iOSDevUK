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
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: MapDetails.startingLocation , span: MapDetails.defaultSpan)
    @State private var locationCategory: LocationType = .au
    
    private var allLocations: [Location]
    private var singleItemMap: Bool
    
    init(allLocations: [Location], singleItemMap: Bool = false) {
        self.allLocations = allLocations
        self.singleItemMap = singleItemMap
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
        Picker("Location category", selection: $locationCategory) {
            ForEach(LocationType.allCases, id: \.self) { location in
                Text(location.shortName)
            }
        }
        .pickerStyle(.segmented)
        .padding()
        .onChange(of: locationCategory) {_ in
            updateRegion()
        }
    }
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: filteredAnnotations()) { location in
            MapAnnotation(coordinate: location.coordinate) {
                LocationMapAnnotation(location: location, showAnnotation: singleItemMap) {
                    MapViewModel.openInAppleMaps(location: location)
                }
            }
        }
        .accentColor(Color(.systemPink))
        .navigationBarTitle("Map", displayMode: .inline)
        .safeAreaInset(edge: .bottom) {
            if locationManager.locationManager?.authorizationStatus == .denied {
                locationDeniedLabel()
            }
        }
        .safeAreaInset(edge: .top) {
            if !self.singleItemMap {
                categoryPicker()
            }
        }
        .onAppear() {
            updateRegion()
        }
    }

    private func updateRegion() {
        let regionCenter = filteredAnnotations().last?.coordinate ?? MapDetails.startingLocation
        region = MKCoordinateRegion(center: regionCenter , span: MapDetails.defaultSpan)
    }
    
    private func filteredAnnotations() -> [Location] {
        var filteredLocations = allLocations
        if !self.singleItemMap {
            filteredLocations = filteredLocations.filter { $0.locationType == $locationCategory.wrappedValue }
        }
        return filteredLocations
    }
}

struct MapView_Previews: PreviewProvider {
    @EnvironmentObject var locationManager: LocationService

    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: MapDetails.startingLocation , span: MapDetails.defaultSpan)
    @State private var locationCategory: LocationType = .pubs

    static var previews: some View {
        MapView(allLocations: [DummyData.location]).environmentObject(LocationService.shared)
    }
}
