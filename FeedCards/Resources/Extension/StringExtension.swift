//
//  StringExtension.swift
//  FeedCards
//
//  Created by Daniel Oliveira on 03/02/22.
//

import Foundation

protocol Localizable {
    var localized: String { get }
}

extension String: Localizable {
    var localized: String {
        var localizedString = Bundle.main.localizedString(forKey: self, value: nil, table: nil)
        
        // - LocalizedString is different to self when in specific localizable file ("Localizable.strings")
        //  contains the translation to the key
        if localizedString == self {
            // - Fetch the translation for the default locacalizable file ("GeneralLocalizable.strings")
            localizedString = Bundle.main.localizedString(forKey: self, value: nil, table: "Localizable")
        }
        
        return localizedString
    }
}

extension String {
    func getFormatedDate() -> String {
        var dateFormatted = String()
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let postDate = dateFormatter.date(from: self) {
            let currentDate = Date()
            let delta = postDate.timeIntervalSince(currentDate)
            if delta < .zero {
                let dayFormatter = DateComponentsFormatter()
                dayFormatter.allowedUnits = [.day]
                
                let timeFormatter = DateFormatter()
                timeFormatter.timeZone = .current
                
                guard let dayString = dayFormatter.string(from: delta), let consecutiveDays = Int(dayString.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.").inverted)) else { return String() }
                if consecutiveDays > .zero {
                    timeFormatter.dateFormat = "dd-MM-yyyy"
                    timeFormatter.string(from: currentDate)
                    let date = timeFormatter.string(from: currentDate)
                    dateFormatted = "Posted on: \(date)"
                } else {
                    timeFormatter.timeStyle = .short
                    let time = timeFormatter.string(from: postDate)
                    dateFormatted = "Posted today at: \(time)"
                }
            }
        }
        return dateFormatted
    }
}
