//
//  LocationService.swift
//  iOSDevUK
//
//  Created by David Kababyan on 18/10/2022.
//

import MapKit

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 52.414704, longitude: -4.080645)
    static let defaultSpan = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
}


class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation,
                                               span: MapDetails.defaultSpan)
    
    @Published var currentLocation = MapDetails.startingLocation
    
    static let shared = LocationManager()
    
    var locationManager: CLLocationManager?

    
    private override init() {
        super.init()
        requestLocationAccess()
    }
    
    func requestLocationAccess() {
        
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.requestWhenInUseAuthorization()
            
            locationManager!.activityType = .other
            locationManager!.pausesLocationUpdatesAutomatically = true

            locationManager!.startMonitoringSignificantLocationChanges()
        }
    }
    
    static func region(for coordinates: [CLLocationCoordinate2D]) -> MKCoordinateRegion {

        var rect = MKMapRect.null
        
        for coordinate in coordinates {
            
            let point = MKMapPoint(coordinate)
            rect = rect.union(MKMapRect(x: point.x, y: point.y, width: 0, height: 0))
        }
        
        var region = MKCoordinateRegion(rect)
        region.span.latitudeDelta *= 1.5
        region.span.longitudeDelta *= 1.5
        
        return region
    }

    
    //MARK: - Delegates
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("DEBUG: Failed to get location")
    }
    

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if self.locationManager!.authorizationStatus == .notDetermined {
            self.locationManager!.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("DEBUG: Updated location")
        currentLocation = locations.last!.coordinate
        region = MKCoordinateRegion(center: currentLocation, span: MapDetails.defaultSpan)
    }

}

