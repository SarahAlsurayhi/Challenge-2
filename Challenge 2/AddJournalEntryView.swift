//
//  AddJournalEntryView.swift
//  Challenge 2
//
//  Created by E07 on 26/04/1446 AH.
//

import SwiftUI

struct AddJournalEntryView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: MainPageViewModel

    @State private var title = ""
    @State private var content = ""
    @State private var date = Date()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                TextField("Title", text: $title)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    

                Text(dateFormatted(date))
                    .foregroundColor(.tx1)
                    .padding(.trailing, 250)
                
                TextField("Type your Journal...", text: $content, axis:.vertical)
                    .foregroundColor(.white)
                    .font(.system(size: 24))
                    .padding()
                
                
                Spacer()
            }
            .padding()
            .navigationBarItems(
                leading: Button("Cancel") { dismiss() },
                trailing: Button("Save") {
                    viewModel.addOrUpdateEntry(
                        title: title,
                        content: content,
                        date: dateFormatted(date)
                    )
                    dismiss()
                }
            )
            .onAppear {
                if viewModel.isEditing, let entry = viewModel.selectedEntry {
                    title = entry.title
                    content = entry.content
                    date = dateFromString(entry.date) ?? Date()
                }
            }
            .background(Color.lightBG)
        }
        .background(Color.gray)
    }

    func dateFormatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }

    func dateFromString(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.date(from: dateString)
    }
}
