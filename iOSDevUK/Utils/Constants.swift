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
    static let allSpeakers = "All Speakers"
    static let slackChannel = "iOSDevUK Slack Channel"
    static let iOSDevTwitter = "@iOSDevUK on Twitter"
    static let aberCompTwitter = "@AberCompSci on Twitter"
    static let iOSDevUK = "iOSDev UK"
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
    static let biography = "Biography"
    static let session = "Session(s)"
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
    static let webLinks = "Link(s)"
    static let time = "Time"

}

struct ImageNames {
    static let sessionImage = "sessionImage"
    static let aboutImage = "aboutImage"
    static let appIcon = "appIcon"
    static let conferenceImage = "conferenceImage"
    static let bookmark = "bookmark"
    static let bookmarkFill = "bookmark.fill"
    static let house = "house"
    static let list = "list.bullet"
    static let person = "person"
    static let info = "info"
    static let mapPin = "mappin.circle.fill"
    static let chevronRight = "chevron.right"
    static let checkmark = "checkmark"
    static let placeholder = "placeholder"
    static let bulletPoint = "list.bullet.rectangle.portrait"
    static let xmark = "xmark.circle"
    static let envelope = "envelope"
    static let lock = "lock"
    static let plus = "plus"
    static let photo = "photo"
    static let infoBackground = "background"
    static let infoDevices = "devices"
    static let questionmark = "questionmark.circle"
    static let linkedIn = "linkedin"
    static let twitter = "twitter"
    static let mapPinEmpty = "mappin.circle"
    static let personsCircle = "person.circle"
    static let heart = "heart"
    static let iphone = "iphone.gen3"
    static let infoCircle = "info.circle"
    static let ticket = "ticket"

}

struct ColorNames {
    static let goldColor = "goldColor"
    static let platinumColor = "platinumColor"
    static let silverColor = "silverColor"
    static let primary = "primary"
    static let secondary = "secondary"
    static let backgroundColor = "backgroundColor"
}

struct TwitterAccounts {
    static let developer = "\(BaseUrl.twitter)Dave_iOSDev"
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
}

struct FirebaseLinks {
    static let fileReference = "gs://iosdevuk-684dd.appspot.com"
}
