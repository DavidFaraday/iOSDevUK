//
//  MapView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 18/10/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(\.dismiss) private var dismiss
    
    var allLocations: [Location]
        
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 52.414704, longitude: -4.080645),
        span: MKCoordinateSpan.init(latitudeDelta: 0.03, longitudeDelta: 0.03)
    )

    
    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: allLocations) { location in
            
            MapAnnotation(coordinate: location.coordinate) {
                LocationMapAnnotation(location: location)
            }
            
        }
        .ignoresSafeArea(SafeAreaRegions.all, edges: .top)
        .accentColor(Color(.systemPink))
        .navigationTitle("Map")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(allLocations: [DummyData.location])
    }
}

