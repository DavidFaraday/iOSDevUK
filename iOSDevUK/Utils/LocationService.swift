//
//  LocationManager.swift
//  iOSDevUK
//
//  Created by David Kababyan on 25/03/2023.
//

import MapKit

enum MapDetails {
    static let startingLatitude: CLLocationDegrees = 52.41483885670968
    static let startingLongitude: CLLocationDegrees =  -4.076185527558135
    static let defaultLocationAberystwyth = CLLocation(latitude: startingLatitude, longitude: startingLongitude)
    static let aberystwythCoordinates = defaultLocationAberystwyth.coordinate
    static let defaultSpan = MKCoordinateSpan.init(latitudeDelta: 0.025, longitudeDelta: 0.025)
}

class LocationService: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.aberystwythCoordinates,
                                               span: MapDetails.defaultSpan)
    
    @Published var currentLocation = MapDetails.aberystwythCoordinates
    
    static let shared = LocationService()
    
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
        guard let manager = locationManager else { return }
        
        if manager.authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("DEBUG: Updated location")
        currentLocation = locations.last!.coordinate
        region = MKCoordinateRegion(center: currentLocation, span: MapDetails.defaultSpan)
    }
}
