//
//  InclusivityView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 11/09/2022.
//

import SwiftUI

struct InclusivityView: View {
    
    let inclusivityText = """
We believe that anyone should be able to feel welcome, included, and safe at our conference. That means anyone, irrespective of gender, gender identity and expression, sexual orientation, disability, physical appearance, body size, race, religion.
       
First, we'll do everything we can to accommodate people's needs. All we ask is that, if you know you're going to need something, you tell us about it before the event - the sooner the better.
       
Second, we won't tolerate staff, speakers, attendees, or sponsors engaging in behaviour that excludes people, whether that's harassment, bullying, overt or covert racism or sexism. Not tolerating means we'll eject people, if we have to.

Harassment includes offensive verbal comments related to gender, gender identity and expression, sexual orientation, disability, physical appearance, body size, race, religion, sexual images in public spaces, deliberate intimidation, stalking, following, harassing photography or recording, sustained disruption of talks or other events, inappropriate physical contact, and unwelcome sexual attention.

Anyone asked to stop harassing behaviour is expected to do so, immediately.
       
If you are being harassed, notice that someone else is being harassed, or have any other concerns, please contact one of the iOSDevUK team immediately.
       
iOSDevUK staff will be happy to help participants contact University security or local law enforcement, provide escorts, or otherwise assist those experiencing harassment to feel safe for the duration of the conference. We value your attendance.

The policy applies at all conference and workshop venues and conference-related social events.
"""
    var body: some View {
        ScrollView {
            Image("conferenceImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)

            Text("Inclusivity Policy")
                .font(.largeTitle)
                .minimumScaleFactor(0.7)
            
            Spacer()

            Text(inclusivityText)
                .lineLimit(nil)
                .padding()
        }
        .navigationTitle("Inclusivity")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InclusivityViewView_Previews: PreviewProvider {
    static var previews: some View {
        InclusivityView()
    }
}
