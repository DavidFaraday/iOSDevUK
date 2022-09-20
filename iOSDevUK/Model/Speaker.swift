//
//  Speaker.swift
//  iOSDevUK
//
//  Created by David Kababyan on 10/09/2022.
//

import Foundation

struct Speaker: Codable, Identifiable {
    let id: String
    let name: String
    let biography: String
    let linkedIn: String
    let twitterId: String
    let imageLink: String
      
    static let dummySpeaker = Speaker(id: UUID().uuidString, name: "Artur Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum", linkedIn: "my linked in", twitterId: "@ArturIosDev", imageLink: "https://picsum.photos/200/300")
    
    static let arrayOfSpeakers = [
        Speaker(id: UUID().uuidString, name: "Artur Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown ", linkedIn: "my linked in", twitterId: "@ArturIosDev", imageLink: "https://picsum.photos/200/300"),
        Speaker(id: UUID().uuidString, name: "Somevewrylong Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown ", linkedIn: "my linked in", twitterId: "@ArturIosDev", imageLink: "https://picsum.photos/200/300"),
        Speaker(id: UUID().uuidString, name: "Armen Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown ", linkedIn: "my linked in", twitterId: "@ArturIosDev", imageLink: "https://picsum.photos/200/300"),
        Speaker(id: UUID().uuidString, name: "Kristina Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown ", linkedIn: "my linked in", twitterId: "@ArturIosDev", imageLink: "https://picsum.photos/200/300"),
        Speaker(id: UUID().uuidString, name: "Daniel Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown ", linkedIn: "my linked in", twitterId: "@ArturIosDev", imageLink: "https://picsum.photos/200/300"),
        Speaker(id: UUID().uuidString, name: "David Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown ", linkedIn: "my linked in", twitterId: "@ArturIosDev", imageLink: "https://picsum.photos/200/300")
    ]
}
