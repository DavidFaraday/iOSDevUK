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
    
    init(allLocations: [Location]) {
        self.allLocations = allLocations
    }
    
    @ViewBuilder
    private func navigationBarTrailingItem() -> some View {
        HStack{
            Image(systemName: pinForLocationFetcher(locationCategory))
            Menu {
                Picker("Location category", selection: $locationCategory) {
                    ForEach(LocationType.allCases, id: \.self) { location in
                        HStack {
                            Image(systemName: pinForLocationFetcher(location))
                            Text(location.name)
                        }
                        .tag(location.name)
                    }
                }
                .onChange(of: locationCategory) {_ in
                    updateRegion()
                }
            } label: {
                Text(Image(systemName: "line.3.horizontal.decrease.circle"))
            }
        }
    }
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: filteredAnnotations()) { location in
            MapAnnotation(coordinate: location.coordinate) {
                LocationMapAnnotation(location: location, showAnnotation: false) {
                    MapViewModel.openInAppleMaps(location: location)
                }
            }
        }
        .accentColor(Color(.systemPink))
        .navigationBarTitle("Map", displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: navigationBarTrailingItem)
        }
        .safeAreaInset(edge: .bottom) {
            if locationManager.locationManager?.authorizationStatus == .denied {
                LocationDeniedLabel()
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
        return allLocations.filter { $0.locationType == $locationCategory.wrappedValue }
    }
    
    private func pinForLocationFetcher(_ locationType: LocationType) -> String {
        switch locationType {
        case .au: return MapIcons.book
        case .ev: return MapIcons.plug
        case .other: return MapIcons.mapPin
        case .pubs: return MapIcons.mug
        case .sm: return MapIcons.basket
        case .transport: return MapIcons.car
        }
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
