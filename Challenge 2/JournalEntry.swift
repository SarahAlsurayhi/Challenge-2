//
//  JournalEntry.swift
//  Challenge 2
//
//  Created by E07 on 26/04/1446 AH.
//

import Foundation

struct JournalEntry: Identifiable {
    let id = UUID()
    var title: String
    var date: String
    var content: String
    var isBookmarked: Bool = false
}
