//
//  ContentView.swift
//  CoreData Playground
//
//  Created by Martin Václavík on 29.12.2023.
//

import SwiftUI
import CoreData

struct AppView: View {
    var body: some View {
        NavigationStack {
            NavigationLink {
                ContentView()
            } label: {
                Text("Go to list")
            }
        }
    }
}

#Preview {
    AppView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.timestamp, order: .reverse)],
        animation: .spring)
    private var items: FetchedResults<Item>

    var body: some View {
        List {
            ForEach(items) { item in
                RowView(item: item)
                    .swipeActions(edge: .leading) {
                        Button {
                            item.managedObjectContext?.delete(item)
                            try? viewContext.save()
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(.green)

                        Button(role: .destructive) { // <-- If we remove the destructive role, app no longer crashes. See green button above
                            item.managedObjectContext?.delete(item)
                            try? viewContext.save()
                        } label: {
                            Label("Delete", systemImage: "xmark")
                        }
                    }
            }
            .onDelete(perform: delete(indexes:)) // <-- ForEachs onDelete modifier works as expected
        }
        .toolbar {
            Button("Add") {
                let item = Item(context: viewContext)
                item.timestamp = .now
            }
        }
    }

    func delete(indexes: IndexSet) {
        indexes.forEach { i in
            viewContext.delete(items[i])
        }
        try? viewContext.save()
    }
}

struct RowView: View {
    @ObservedObject var item: Item // <-- If we remove this, app no longer crashes, but we lose UI updates if the objects properties changes

    var body: some View {
        NavigationLink(value: item) {
            Text(item.timestamp ?? .now, format: .dateTime)
        }
    }
}
