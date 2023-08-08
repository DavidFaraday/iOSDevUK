//
//  DummyData.swift
//  iOSDevUK
//
//  Created by David Kababyan on 06/10/2022.
//

import Foundation
import Combine

final class MockFirebaseRepository: FirebaseRepositoryProtocol {
    
    func deleteData<T>(data: T, from collection: FCollectionReference) async throws where T : Identifiable {
        //TODO: unit tests
    }
    
    
    func saveData<T>(data: T, to collection: FCollectionReference) throws where T : Encodable, T : Identifiable {
        //TODO: unit tests
    }
    
    

    let objectsToReturn: [Codable]
    let shouldReturnError: Bool
    
    init(objectsToReturn: [Codable], shouldReturnError: Bool = false) {
        self.objectsToReturn = objectsToReturn
        self.shouldReturnError = shouldReturnError
    }
    
    
    func getDocuments<T: Codable>(from collection: FCollectionReference) async throws -> [T]? {
        if shouldReturnError {
            throw AppError.badSnapshot
        } else {
            return objectsToReturn as? [T]
        }
    }
    
    func getDocuments<T: Codable>(from collection: FCollectionReference, where field: String, isEqualTo value: String) async throws -> [T]? {
        if shouldReturnError {
            throw AppError.badSnapshot
        } else {
            return objectsToReturn as? [T]
        }
    }
    
    func getDocuments<T: Codable>(from collection: FCollectionReference, where field: String, arrayContains value: String) async throws -> [T]? {

        if shouldReturnError {
            throw AppError.badSnapshot
        } else {
            return objectsToReturn as? [T]
        }
    }
    
    func getDocument<T: Codable>(from collection: FCollectionReference, with id: String) async throws -> T? {
        print("sending back")
        if shouldReturnError {
            throw AppError.badSnapshot
        } else {
            return objectsToReturn.first as? T
        }

    }
    
    func listen<T: Codable>(from collection: FCollectionReference) async throws -> AnyPublisher<[T], Error> {

        let subject = PassthroughSubject<[T], Error>()
        
        subject.send(DummyData.speakers as! [T])
        return subject.eraseToAnyPublisher()
    }
    
    func deleteDocument(with id: String, from collection: FCollectionReference) {
        
    }
}


struct DummyData {
    
    static let contentForSession = "when an unknown printer."

    static let informationItems = [
        InformationItem(id: UUID().uuidString, name: "Tickets", link: "http://users.aber.ac.uk/nst/iosdevuk/jump.php?to=tickets", imageName: "questionmark"),
        InformationItem(id: UUID().uuidString, name: "Joining Instructions", link: "http://users.aber.ac.uk/nst/iosdevuk/jump.php?to=joining", imageName: "questionmark")
    ]

    static let location = Location(id: "TestLocation123" ,name: "Great Hall", note: "Some notes about the location", imageLink: "https://picsum.photos/200", latitude: 52.416120, longitude: -4.083800, webLink: DummyData.link, locationType: .pubs)
    
    static let link = Weblink(name: "google", recordName: "google", url: "https://google.com")
    
    static let sponsors = [
        Sponsor(id: UUID().uuidString, name: "Aberystwyth University", tagline: "Aberystwyth University.", url: "https://www.aber.ac.uk/en/cs/", urlText: "Aber Comp Sci Website", sponsorCategory: .Gold, imageLinkDark: "https://picsum.photos/200/300", imageLinkLight: "https://picsum.photos/200/300"),
        Sponsor(id: UUID().uuidString, name: "Cookpad", tagline: "Cookpad is a tech company.", url: "https://careers.cookpad.com/", urlText: "Careers at Cookpad", sponsorCategory: .Gold, imageLinkDark: "https://picsum.photos/200/300", imageLinkLight: "https://picsum.photos/200/300")
    ]
    
    static let sessions = [
        Session(id: "Session123", title: "Lorem Ipsum has been the industry's", content: contentForSession, startDate: Date().date(with: 2022, month: 11, day: 10), endDate: Date(), locationId: "376A09A8-6E1D-404E-AAD6-05C8E950DF32", speakerIds: ["1667F0A8-A62E-4C66-8957-96B08550DB4D"], type: .talk),
        
        Session(id: "Session321", title: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout", content: contentForSession, startDate: Date(), endDate: Date(), locationId: "376A09A8-6E1D-404E-AAD6-05C8E950DF32", speakerIds: ["1667F0A8-A62E-4C66-8957-96B08550DB4D", "C3DD9203-7B66-492B-AE8B-FB77168FAED5"], type: .talk)
    ]
        
    static let speakers = [
        Speaker(id: "Speaker1ID", name: "Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown ", linkedIn: "davidkababyan", twitterId: "@ArturIosDev", imageLink: "https://xsgames.co/randomusers/avatar.php?g=male", webLinks: [link]),
        Speaker(id: "Speaker2ID", name: "Somevewrylong Kababyan", biography: "is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown ", linkedIn: "davidkababyan", twitterId: "@ArturIosDev", imageLink: "https://xsgames.co/randomusers/avatar.php?g=female", webLinks: nil)
    ]

    static let aboutString = "iOSDevUK is a conference."
    
    static let eventNotification = "iOSDevUK 10 has finished."
    
    static let weatherData = WeatherData(tempDate: .now, condition: "Blowing Dust", symbolName: "sun.max", currentTempC: 22.1, feelsLikeC: 22.5)

    static let eventInformation = EventInformation(
        about: "iOSDevUK is a conference organised by the Computer Science Department at Aberystwyth University. iOS, iPhone, iPad, Apple Watch, watchOS, Apple TV and tvOS are trademarks of Apple Inc. For the avoidance of doubt, Apple Inc. has no association with this conference.",
        notification: "iOSDevUK 11 will take place at Aberystwyth University from  4th to 7th September, 2023",
        startDate: Calendar.current.date(from: DateComponents(year: 2023, month: 9, day: 4))!,
        endDate:  Calendar.current.date(from: DateComponents(year: 2023, month: 9, day: 7))!,
        inclusivityText: "We believe that anyone should be able to feel welcome, included, and safe at our conference. That means anyone, irrespective of gender, gender identity and expression, sexual orientation, disability, physical appearance, body size, race, religion."
    )
}
