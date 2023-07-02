//
//  MapView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 18/10/2022.
//

import SwiftUI
import MapKit

struct MapSingleObjectView: View {
    @EnvironmentObject var locationManager: LocationService
    @State private var region: MKCoordinateRegion
    
    private var location: Location
    
    init(location: Location) {
        self.location = location
        region = MKCoordinateRegion(center: location.coordinate , span: MapDetails.defaultSpan)
    }
    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: [location]) { item in
            MapAnnotation(coordinate: item.coordinate) {
                LocationMapAnnotation(location: item, showAnnotation: true) {
                    MapViewModel.openInAppleMaps(location: item)
                }
            }
        }
        .accentColor(Color(.systemPink))
        .navigationBarTitle("Map", displayMode: .inline)
        .safeAreaInset(edge: .bottom) {
            if locationManager.locationManager?.authorizationStatus == .denied {
                LocationDeniedLabel()
            }
        }
    }
}

struct MapSingleObjectView_Previews: PreviewProvider {
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: MapDetails.startingLocation , span: MapDetails.defaultSpan)
    
    static var previews: some View {
        MapSingleObjectView(location: DummyData.location).environmentObject(LocationService())
    }
}
