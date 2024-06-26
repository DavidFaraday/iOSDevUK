//
//  Constants.swift
//  iOSDevUK
//
//  Created by David Kababyan on 18/10/2022.
//

import Foundation

struct AppStrings {
    static let sessions = "Sessions"
    static let loading = "Loading..."
    static let allSessions = "All Sessions"
    static let speakers = "Speakers"
    static let viewAll = "View all"
    static let iOSDevUK = "iOSDevUK"
    static let aberCompTwitter = "AberCompSci"
    static let mySessions = "My Sessions"
    static let emptySessionMessage = "You currently have no sessions added. \n Please bookmark sessions to see them here."
    static let takeMeThere = "Take me there"
    static let attendeeInfo = "Attendee Info"
    static let admin = "Admin"
    static let locations = "Locations"
    static let inclusivity = "Inclusivity"
    static let sponsors = "Sponsors"
    static let aboutIOsDev = "About iOSDevUK"
    static let appInfo = "App Information"
    static let info = "Info"
    static let inclusivityPolicy = "Inclusivity Policy"
    static let map = "Map"
    static let description = "Description"
    static let speaker = "Speaker(s)"
    static let location = "Location"
    static let error = "Error!"
    static let ok = "OK"
    static let biography = "BIOGRAPHY"
    static let session = "SESSIONS"
    static let home = "Home"
    static let schedule = "Schedule"
    static let attendee = "Attendee"
    static let navigate = "Navigate"
    static let adminArea = "Admin Area"
    static let logOut = "Log Out"
    static let login = "Login"
    static let email = "Email"
    static let password = "Password"
    static let selectImage = "Select image"
    static let save = "Save"
    static let fullName = "Full name"
    static let twitter = "Twitter"
    static let linkedIn = "Linkedin"
    static let imageLink = "Image link"
    static let personalInfo = "Personal Info"
    static let addSpeaker = "Add Speaker"
    static let addSession = "Add Session"
    static let selectSpeakers = "Select Speakers"
    static let addLocation = "Add Location"
    static let locationDetails = "Location Details"
    static let sponsorDetails = "Sponsor details"
    static let addSponsor = "Add Sponsor"
    static let webLinks = "LINKS"
    static let time = "Time"
    static let aberystwyth = "Aberystwyth"
    static let position = "Position"

}

struct ImageNames {
    static let bookmark = "bookmark"
    static let bookmarkFill = "bookmark.fill"
    static let mapPin = "mappin.circle.fill"
    static let chevronRight = "chevron.right"
    static let chevronUp = "chevron.up"
    static let chevronDown = "chevron.down"
    static let checkmark = "checkmark"
    static let xmark = "xmark.circle"
    static let envelope = "envelope"
    static let lock = "lock"
    static let plus = "plus"
    static let photo = "photo"
    static let linkedIn = "linkedin"
    static let twitter = "twitter"
    static let phone = "phone"
    static let link = "link"
    static let location = "mapPin"
    static let calendar = "calendar"
    static let about = "about"
    static let inclusivity = "inclusivity"
    static let sponsors = "inclusivity"
    static let schedule = "schedule"
    static let attendee = "attendee"
    static let mapImage = "mapImage"
}


struct ContactAccounts {
    static let developer = "\(BaseUrl.twitter)Dave_iOSDev"
    static let designer = "\(BaseUrl.linkedIn)oksana-korotun"
    static let aberCompSci = "\(BaseUrl.twitter)AberCompSci"
    static let iOSDevUK = "\(BaseUrl.twitter)iOSDevUK"
    static let digidol = "\(BaseUrl.twitter)digidol"
}

struct BaseUrl {
    static let twitter = "https://twitter.com/"
    static let linkedIn = "https://linkedIn.com/in/"
}

struct Slack {
    static let channelLink = "https://iosdevuk.slack.com"
}

struct FirebaseKeys {
    static let speakerIds = "speakerIds"
}

struct AppConstants {
    static let textViewHeight = 300.0
    static let sessionKey = "favoriteSessionIds"
}

struct FirebaseLinks {
    static let fileReference = "gs://iosdevuk-684dd.appspot.com"//should be changed
}
