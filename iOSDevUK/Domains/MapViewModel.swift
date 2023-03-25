//
//  MapViewModel.swift
//  iOSDevUK
//
//  Created by David Kababyan on 25/03/2023.
//

import Foundation
import SwiftUI
import MapKit

final class MapViewModel: ObservableObject {
        
    static func openInGoogleMaps(location: Location) {

        let url = URL(string: "comgooglemaps://?saddr=&daddr=\(location.latitude),\(location.longitude)&directionsmode=driving")
        
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        } else {
            let urlBrowser = URL(string: "https://www.google.co.in/maps/dir/??saddr=&daddr=\(location.latitude),\(location.longitude)&directionsmode=driving")
            
            UIApplication.shared.open(urlBrowser!, options: [:], completionHandler: nil)
        }
    }
    
    static func openInAppleMaps(location: Location) {

        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: location.coordinate, addressDictionary:nil))
        mapItem.name = location.name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
}
