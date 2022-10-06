//
//  LocationCellView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import SwiftUI

struct LocationCellView: View {
    var location: Location!
    let imageWidth: CGFloat = 60

    init(location: Location) {
        self.location = location
    }
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .frame(width: imageWidth + 5)
                    .foregroundColor(.green)
                RemoteImage(urlString: location.imageLink ?? "")
                    .frame(width: imageWidth, height: imageWidth)
                    .clipShape(Circle())
            }
            
            Text(location.name)
                .font(.title2)
                .minimumScaleFactor(0.6)
        }
    }
}

struct LocationCellView_Previews: PreviewProvider {
    static var previews: some View {
        LocationCellView(location: DummyData.location)
    }
}
