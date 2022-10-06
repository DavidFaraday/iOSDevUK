//
//  DummyData.swift
//  iOSDevUK
//
//  Created by David Kababyan on 06/10/2022.
//

import Foundation

struct DummyData {
    static let informationItems = [
        InformationItem(id: UUID().uuidString, name: "Tickets", link: ""),
        InformationItem(id: UUID().uuidString, name: "JoiningInstructions", link: ""),
        InformationItem(id: UUID().uuidString, name: "Accommodation", link: ""),
        InformationItem(id: UUID().uuidString, name: "Parking", link: ""),
        InformationItem(id: UUID().uuidString, name: "University Information", link: "")
    ]

    static let location = Location(name: "Great Hall", note: "Some notes about the location", imageLink: "https://picsum.photos/200", latitude: 52.416120, longitude: -4.083800, locationTypeRecordName: "pub", webLink: DummyData.link)
    
    static let link = WebLink(recordName: "Google", name: "google", url: "https://google.com")
    static let sponsor = Sponsor(id: UUID().uuidString, name: "Aberystwyth University", tagline: "Aberystwyth University has a Computer Science department with excellent research, producing graduates with strong technical skills. Talk to us about how we can work together to get our graduates working for your company.", url: "https://www.aber.ac.uk/en/cs/", urlText: "Aber Comp Sci Website", sponsorCategory: .Gold, imageLink: "https://picsum.photos/200/300")

    
    static let session = Session(id: UUID().uuidString, title: "I love SwiftUI", content: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software", startDate: Date(), endDate: Date(), locationId: "location123", speakerIds: ["speaker123"], type: .talk)
    
    static let sessions = [
        Session(id: UUID().uuidString, title: "I love SwiftUI and other things from Apple", content: "Some long description about the session", startDate: Date(), endDate: Date(), locationId: "location123", speakerIds: ["speaker123"], type: .talk),
        Session(id: UUID().uuidString, title: "I love SwiftUI", content: "Some long description about the session", startDate: Date(), endDate: Date(), locationId: "location123", speakerIds: ["speaker123"], type: .talk),
        Session(id: UUID().uuidString, title: "I love SwiftUI", content: "Some long description about the session", startDate: Date(), endDate: Date(), locationId: "location123", speakerIds: ["speaker123"], type: .talk),
        Session(id: UUID().uuidString, title: "I love SwiftUI", content: "Some long description about the session", startDate: Date(), endDate: Date(), locationId: "location123", speakerIds: ["speaker123"], type: .talk),
        Session(id: UUID().uuidString, title: "I love SwiftUI", content: "Some long description about the session", startDate: Date(), endDate: Date(), locationId: "location123", speakerIds: ["speaker123"], type: .talk)
    ]

    
    static let speaker = Speaker(id: UUID().uuidString, name: "Artur Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum", linkedIn: "davidkababyan", twitterId: "@ArturIosDev", imageLink: "https://picsum.photos/200/300", webLinks: nil)
    
    static let speakers = [
        Speaker(id: UUID().uuidString, name: "Artur Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown ", linkedIn: "my linked in", twitterId: "@ArturIosDev", imageLink: "https://picsum.photos/200/300", webLinks: nil),
        Speaker(id: UUID().uuidString, name: "Somevewrylong Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown ", linkedIn: "my linked in", twitterId: "@ArturIosDev", imageLink: "https://picsum.photos/200/300", webLinks: nil),
        Speaker(id: UUID().uuidString, name: "Armen Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown ", linkedIn: "my linked in", twitterId: "@ArturIosDev", imageLink: "https://picsum.photos/200/300", webLinks: nil),
        Speaker(id: UUID().uuidString, name: "Kristina Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown ", linkedIn: "my linked in", twitterId: "@ArturIosDev", imageLink: "https://picsum.photos/200/300", webLinks: nil),
        Speaker(id: UUID().uuidString, name: "Daniel Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown ", linkedIn: "my linked in", twitterId: "@ArturIosDev", imageLink: "https://picsum.photos/200/300", webLinks: nil),
        Speaker(id: UUID().uuidString, name: "David Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown ", linkedIn: "my linked in", twitterId: "@ArturIosDev", imageLink: "https://picsum.photos/200/300", webLinks: nil)
    ]

}
