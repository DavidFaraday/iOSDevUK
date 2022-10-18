//
//  MapView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 18/10/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    let allLocations: [Location]

    var body: some View {
        Map(coordinateRegion: $locationManager.region, showsUserLocation: true, userTrackingMode: .constant(.follow), annotationItems: allLocations) {
            
            MapMarker(coordinate: $0.coordinate)
        }
        .ignoresSafeArea(SafeAreaRegions.all, edges: .top)
        .accentColor(Color(.systemPink))
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(allLocations: [])
    }
}

