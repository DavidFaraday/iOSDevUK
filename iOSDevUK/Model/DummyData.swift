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
        InformationItem(id: UUID().uuidString, name: "Tickets", link: "http://users.aber.ac.uk/nst/iosdevuk/jump.php?to=tickets"),
        InformationItem(id: UUID().uuidString, name: "Joining Instructions", link: "http://users.aber.ac.uk/nst/iosdevuk/jump.php?to=joining")
    ]

    static let location = Location(id: UUID().uuidString ,name: "Great Hall", note: "Some notes about the location", imageLink: "https://picsum.photos/200", latitude: 52.416120, longitude: -4.083800, webLink: DummyData.link, locationType: .pubs)
    
    static let link = Weblink(name: "google", recordName: "google", url: "https://google.com")
    
    static let sponsors = [
        Sponsor(id: UUID().uuidString, name: "Aberystwyth University", tagline: "Aberystwyth University has a Computer Science department with excellent research, producing graduates with strong technical skills. Talk to us about how we can work together to get our graduates working for your company.", url: "https://www.aber.ac.uk/en/cs/", urlText: "Aber Comp Sci Website", sponsorCategory: .Gold, imageLink: "https://picsum.photos/200/300"),
        Sponsor(id: UUID().uuidString, name: "Cookpad", tagline: "Cookpad is a tech company working to make everyday cooking fun because we believe that cooking is the key to a happier and healthier life for people, communities and the planet.  Our  engineers work with community teams around the world to develop a recipe sharing platform that connects communities of home cooks and empowers them to help each other to cook by sharing recipes, tips and experiences.\nIf you are someone who's ready to think big, act boldly and execute with urgency, we want to hear from you. Find out what it's like to work at Cookpad and view our latest opportunities. We are actively hiring at present.", url: "https://careers.cookpad.com/", urlText: "Careers at Cookpad", sponsorCategory: .Gold, imageLink: "https://picsum.photos/200/300")
    ]
    
    static let sessions = [
        Session(id: UUID().uuidString, title: "Lorem Ipsum has been the industry's", content: contentForSession, startDate: Date().date(with: 2022, month: 11, day: 10), endDate: Date(), locationId: "376A09A8-6E1D-404E-AAD6-05C8E950DF32", speakerIds: ["1667F0A8-A62E-4C66-8957-96B08550DB4D"], type: .talk),
        
        Session(id: UUID().uuidString, title: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout", content: contentForSession, startDate: Date(), endDate: Date(), locationId: "376A09A8-6E1D-404E-AAD6-05C8E950DF32", speakerIds: ["1667F0A8-A62E-4C66-8957-96B08550DB4D", "C3DD9203-7B66-492B-AE8B-FB77168FAED5"], type: .talk)
    ]

        
    static let speakers = [
        Speaker(id: "Speaker1ID", name: "Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown ", linkedIn: "my linked in", twitterId: "@ArturIosDev", imageLink: "https://xsgames.co/randomusers/avatar.php?g=male", webLinks: nil),
        Speaker(id: "Speaker2ID", name: "Somevewrylong Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown ", linkedIn: "my linked in", twitterId: "@ArturIosDev", imageLink: "https://xsgames.co/randomusers/avatar.php?g=female", webLinks: nil)
    ]

    static let aboutString = "iOSDevUK is a conference organised by the Computer Science Department at Aberystwyth University. iOS, iPhone, iPad, Apple Watch, watchOS, Apple TV and tvOS are trademarks of Apple Inc. For the avoidance of doubt, Apple Inc. has no association with this conference."
    
    static let eventNotification = "iOSDevUK 10 has finished.\n Follow @iOSDevUK for details about next year."
}
