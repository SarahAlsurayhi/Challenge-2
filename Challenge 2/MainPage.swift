import SwiftUI

struct MainPage: View {
    @StateObject private var viewModel = MainPageViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea()
                VStack(spacing: 16) {
                    HStack {
                        Text("Journal")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Menu {
                            Button("All Entries", action: { viewModel.filterOption = .all })
                            Button("Bookmark", action: { viewModel.filterOption = .bookmarked })
                            Button("Recent", action: { viewModel.filterOption = .recent })
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                                .foregroundColor(.tx1)
                                .font(.system(size: 24))
                        }
                        
                        Button(action: {
                            viewModel.isEditing = false
                            viewModel.selectedEntry = nil
                            viewModel.showAddEntry.toggle()
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(.tx1)
                                .font(.system(size: 24))
                        }
                        .sheet(isPresented: $viewModel.showAddEntry) {
                            AddJournalEntryView(viewModel: viewModel)
                        }
                    }
                    .padding()

                    SearchBarView(searchText: $viewModel.searchText)
                    
                    if viewModel.journalEntries.isEmpty {
                        EmptyStateView()
                    } else {
                        JournalEntriesListView(entries: viewModel.filteredEntries, viewModel: viewModel)
                    }
                }
            }
        }
        .accentColor(.white)
    }
}

struct SearchBarView: View {
    @Binding var searchText: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.2))
                .frame(width: 370, height: 50)

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading, 10.0)

                TextField("Search", text: $searchText)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.clear)

                Button(action: {}) {
                    Image(systemName: "mic")
                        .foregroundColor(.gray)
                        .padding(.trailing, 10)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image("NoteBook")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)

            Text("Begin Your Journal")
                .foregroundColor(.tx1)
                .font(.system(size: 24))
                .font(.title)
                .fontWeight(.bold)

            Text("Craft your personal diary, tap the plus icon to begin")
                .font(.system(size: 18))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.top, -55)
                .padding(.horizontal, 40)
                .frame(width: 350, height: 90)

            Spacer()
        }
        .padding(.top, -60)
    }
}

struct JournalEntriesListView: View {
    var entries: [JournalEntry]
    var viewModel: MainPageViewModel

    var body: some View {
        List {
            ForEach(entries) { entry in
                JournalRow(entry: entry) {
                    viewModel.toggleBookmark(for: entry)
                }
                .listRowBackground(Color.clear)
                .swipeActions(edge: .leading) {
                    Button {
                        viewModel.selectedEntry = entry
                        viewModel.isEditing = true
                        viewModel.showAddEntry.toggle()
                    } label: {
                        Image(systemName: "pencil")
                    }
                    .tint(.blue)
                }
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        viewModel.deleteEntry(entry: entry)
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct JournalRow: View {
    var entry: JournalEntry
    var toggleBookmark: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(entry.title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(entry.date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(entry.content)
                    .font(.body)
                    .foregroundColor(.white)
                    .lineLimit(2)
            }
            Spacer()
            Button(action: toggleBookmark) {
                Image(systemName: entry.isBookmarked ? "bookmark.fill" : "bookmark")
                    .foregroundColor(.tx1)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 5)
    }
}

#Preview {
    MainPage()
}
