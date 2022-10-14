//
//  DummyData.swift
//  iOSDevUK
//
//  Created by David Kababyan on 06/10/2022.
//

import Foundation

struct DummyData {
    
    static let contentForSession = "when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"
    
    static let informationItems = [
        InformationItem(id: UUID().uuidString, name: "Tickets", link: ""),
        InformationItem(id: UUID().uuidString, name: "Joining Instructions", link: ""),
        InformationItem(id: UUID().uuidString, name: "Accommodation", link: ""),
        InformationItem(id: UUID().uuidString, name: "Parking", link: ""),
        InformationItem(id: UUID().uuidString, name: "University Information", link: "")
    ]

    static let location = Location(id: UUID().uuidString ,name: "Great Hall", note: "Some notes about the location", imageLink: "https://picsum.photos/200", latitude: 52.416120, longitude: -4.083800, locationTypeRecordName: "pub", webLink: DummyData.link)
    
    static let link = Weblink(name: "google", recordName: "google", url: "https://google.com")
    static let sponsor = Sponsor(id: UUID().uuidString, name: "Aberystwyth University", tagline: "Aberystwyth University has a Computer Science department with excellent research, producing graduates with strong technical skills. Talk to us about how we can work together to get our graduates working for your company.", url: "https://www.aber.ac.uk/en/cs/", urlText: "Aber Comp Sci Website", sponsorCategory: .Gold, imageLink: "https://picsum.photos/200/300")

    
    static let session = Session(id: UUID().uuidString, title: "I love SwiftUI", content: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software", startDate: Date(), endDate: Date(), locationId: "location123", speakerIds: ["speaker123"], type: .talk)
    
    static let sessions = [
        Session(id: UUID().uuidString, title: "Lorem Ipsum has been the industry's", content: contentForSession, startDate: Date().date(with: 2022, month: 11, day: 10), endDate: Date(), locationId: "376A09A8-6E1D-404E-AAD6-05C8E950DF32", speakerIds: ["1667F0A8-A62E-4C66-8957-96B08550DB4D"], type: .talk),
        
        Session(id: UUID().uuidString, title: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout", content: contentForSession, startDate: Date().date(with: 2022, month: 11, day: 12), endDate: Date(), locationId: "376A09A8-6E1D-404E-AAD6-05C8E950DF32", speakerIds: ["1667F0A8-A62E-4C66-8957-96B08550DB4D", "C3DD9203-7B66-492B-AE8B-FB77168FAED5"], type: .talk),
        
        Session(id: UUID().uuidString, title: "Any desktop publishing packages", content: contentForSession, startDate: Date(), endDate: Date(), locationId: "0708312C-27E4-44CE-870A-ED8EEA82C307", speakerIds: ["C3DD9203-7B66-492B-AE8B-FB77168FAED5"], type: .talk),
        
        Session(id: UUID().uuidString, title: "There are many", content: contentForSession, startDate: Date().date(with: 2022, month: 11, day: 12), endDate: Date(), locationId: "0708312C-27E4-44CE-870A-ED8EEA82C307", speakerIds: ["EF2DC245-4CC1-4014-B24E-D94913A3146C"], type: .talk),
        
        Session(id: UUID().uuidString, title: "Discovered the undoubtable source", content: contentForSession, startDate: Date().date(with: 2022, month: 11, day: 14), endDate: Date(), locationId: "0708312C-27E4-44CE-870A-ED8EEA82C307", speakerIds: ["EF2DC245-4CC1-4014-B24E-D94913A3146C"], type: .workshop)
    ]

    
    static let speaker = Speaker(id: UUID().uuidString, name: "Artur Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum", linkedIn: "davidkababyan", twitterId: "@ArturIosDev", imageLink: "https://xsgames.co/randomusers/avatar.php?g=male", webLinks: nil)
    
    static let speakers = [
        Speaker(id: UUID().uuidString, name: "Artur Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown ", linkedIn: "my linked in", twitterId: "@ArturIosDev", imageLink: "https://xsgames.co/randomusers/avatar.php?g=male", webLinks: nil),
        Speaker(id: UUID().uuidString, name: "Somevewrylong Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown ", linkedIn: "my linked in", twitterId: "@ArturIosDev", imageLink: "https://xsgames.co/randomusers/avatar.php?g=female", webLinks: nil),
        Speaker(id: UUID().uuidString, name: "Armen Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown ", linkedIn: "my linked in", twitterId: "@ArturIosDev", imageLink: "https://xsgames.co/randomusers/avatar.php?g=male", webLinks: nil),
        Speaker(id: UUID().uuidString, name: "Kristina Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown ", linkedIn: "my linked in", twitterId: "@ArturIosDev", imageLink: "https://xsgames.co/randomusers/avatar.php?g=female", webLinks: nil),
        Speaker(id: UUID().uuidString, name: "Daniel Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown ", linkedIn: "my linked in", twitterId: "@ArturIosDev", imageLink: "https://picsum.photos/200", webLinks: nil),
        Speaker(id: UUID().uuidString, name: "David Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown ", linkedIn: "my linked in", twitterId: "@ArturIosDev", imageLink: "https://xsgames.co/randomusers/avatar.php?g=male", webLinks: nil)
    ]

    static let aboutString = "iOSDevUK is a conference organised by the Computer Science Department at Aberystwyth University. iOS, iPhone, iPad, Apple Watch, watchOS, Apple TV and tvOS are trademarks of Apple Inc. For the avoidance of doubt, Apple Inc. has no association with this conference."
    static let eventNotification = "iOSDevUK 10 has finished.\n Follow @iOSDevUK for details about next year."
}
