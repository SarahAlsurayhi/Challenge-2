//
//  MainPageViewModel.swift
//  Challenge 2
//
//  Created by E07 on 26/04/1446 AH.
//

import Foundation
import Combine

class MainPageViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var filterOption: FilterOption = .all
    @Published var journalEntries: [JournalEntry] = []
    @Published var showAddEntry = false
    @Published var isEditing = false
    @Published var selectedEntry: JournalEntry? = nil

    enum FilterOption {
        case all, bookmarked, recent
    }

    var filteredEntries: [JournalEntry] {
        var filtered = journalEntries
        switch filterOption {
        case .all:
            break
        case .bookmarked:
            filtered = filtered.filter { $0.isBookmarked }
        case .recent:
            filtered = filtered.sorted { $0.date > $1.date }
        }
        if !searchText.isEmpty {
            filtered = filtered.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.date.localizedCaseInsensitiveContains(searchText) ||
                $0.content.localizedCaseInsensitiveContains(searchText)
            }
        }
        return filtered
    }

    func toggleBookmark(for entry: JournalEntry) {
        if let index = journalEntries.firstIndex(where: { $0.id == entry.id }) {
            journalEntries[index].isBookmarked.toggle()
        }
    }

    func deleteEntry(entry: JournalEntry) {
        if let index = journalEntries.firstIndex(where: { $0.id == entry.id }) {
            journalEntries.remove(at: index)
        }
    }

    func addOrUpdateEntry(title: String, content: String, date: String) {
        if isEditing, let entry = selectedEntry, let index = journalEntries.firstIndex(where: { $0.id == entry.id }) {
            journalEntries[index].title = title
            journalEntries[index].content = content
            journalEntries[index].date = date
        } else {
            let newEntry = JournalEntry(title: title, date: date, content: content)
            journalEntries.append(newEntry)
        }
        isEditing = false
        selectedEntry = nil
    }
}
