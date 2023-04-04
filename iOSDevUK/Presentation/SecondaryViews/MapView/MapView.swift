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

    private var allLocations: [Location]

    init(allLocations: [Location]) {
        self.allLocations = allLocations
    }

    var body: some View {
        Map(coordinateRegion: $locationManager.region, showsUserLocation: true, annotationItems: allLocations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                LocationMapAnnotation(location: location) {
                    MapViewModel.openInAppleMaps(location: location)
                }
            }
        }
        .ignoresSafeArea(SafeAreaRegions.all, edges: .top)
        .accentColor(Color(.systemPink))
        .navigationTitle("Map")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            if locationManager.locationManager?.authorizationStatus == .denied {
                Text("Location access denied.\n You can enable it in Setting->Privacy & Security.")
                    .font(.caption)
                    .foregroundColor(.pink)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
        
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(allLocations: [DummyData.location])
    }
}

