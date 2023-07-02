//
//  LocationMapAnnotation.swift
//  iOSDevUK
//
//  Created by David Kababyan on 30/10/2022.
//

import SwiftUI

struct LocationMapAnnotation: View {
    private let location: Location
    
    @State private var pinTapped: Bool
    private let buttonAction: () -> Void

    init(location: Location, showAnnotation: Bool, navigationClicked: @escaping () -> Void) {
        self.location = location
        self.buttonAction = navigationClicked
        pinTapped = showAnnotation
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            Image(systemName: ImageNames.MapIcons.mapPin)
                .scaleEffect(pinTapped ? 2.5 : 2.0)
                .foregroundStyle(.white, .blue)
                .padding(10)
                .onTapGesture {
                    withAnimation {
                        pinTapped.toggle()
                    }
                }
            
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .background(.ultraThinMaterial)

                    Text(location.name)
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(10)
                        .fixedSize()
                }

                Button("Navigate", action: buttonAction)
                    .buttonStyle(.borderedProminent)
                    .tint(Color(ColorNames.secondary))

            }
            .opacity(pinTapped ? 1.0 : 0.0)
            .offset(y: pinTapped ? 5 : -10)
        }
    }
}

struct MapAnnotation_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapAnnotation(location: DummyData.location, showAnnotation: false) {
            
        }
    }
}
