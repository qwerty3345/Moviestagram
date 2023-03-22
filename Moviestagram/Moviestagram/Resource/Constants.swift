//
//  Constants.swift
//  Moviestagram
//
//  Created by Mason Kim on 2023/02/10.
//

import UIKit

enum Constants {
    enum Design {
        static let initialUsername = "Mason Kim"
        static let initialRatingLabelText = "0\nRating"
        static let initialBookmarkLabelText = "0\nBookmark"
        static let skeletonDashText = "-"
        static let skeletonTextForSummaryLabel = ".\n. \n. "
        static let skeletonTextForYearLabel = "2000년"
        static let skeletonTextForRatingLabel = "평균: ★"

        static let feedNavigationTitle = "Movies"
        static let sortByLikeActionTitle = "인기순 정렬"
        static let sortByLikeRatingActionTitle = "평점순 정렬"
        static let profileNavigationTitle = "Mason Kim"
    }

    enum Color {
        static let appColor = #colorLiteral(red: 0.8431372549, green: 0.1058823529, blue: 0.2666666667, alpha: 1) // UIColor(red: 215, green: 27, blue: 68, alpha: 1)
    }
}
