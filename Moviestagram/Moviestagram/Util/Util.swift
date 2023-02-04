//
//  Util.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/04.
//

import Foundation

enum Util {
    static func ratingAttributedText(with rating: Double) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: "평균: "))
        attributedString.append(NSAttributedString(string: "★", attributes: [.foregroundColor: appColor]))
        attributedString.append(NSAttributedString(string: "\(rating / 2)"))
        return attributedString
    }

    static func runtimeToHourMinute(runtime: Int) -> String {
        let hour = runtime / 60
        let minute = runtime % 60
        return "\(hour)hour \(minute)min"
    }
}
