//
//  LocationMapAnnotation.swift
//  iOSDevUK
//
//  Created by David Kababyan on 30/10/2022.
//

import SwiftUI

struct LocationMapAnnotation: View {
    private let location: Location
    
    @State private var pinTapped = false
    
    init(location: Location) {
        self.location = location
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            Image(systemName: ImageNames.mapPin)
                .scaleEffect(pinTapped ? 2.5 : 2.0)
                .foregroundStyle(.white, .blue)
            
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .background(.ultraThinMaterial)

                Text(location.name)
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(10)
                    .fixedSize()
            }
            .opacity(pinTapped ? 1.0 : 0.0)
            .offset(y: pinTapped ? 15 : 0)
        }
        .onTapGesture {
            withAnimation {
                pinTapped.toggle()
            }
        }
    }
}

struct MapAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapAnnotation(location: DummyData.location)
    }
}
