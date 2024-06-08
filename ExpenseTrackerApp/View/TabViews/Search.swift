//
//  Search.swift
//  ExpenseTrackerApp
//
//  Created by Shivam Sultaniya on 06/06/24.
//

import SwiftUI
import Combine

struct Search: View {
    
    @State private var searchText: String = ""
    @State private var filterText:String = ""
    @State private var selectedCategory:Category? = nil
    
    let searchPublisher = PassthroughSubject<String,Never>()
    
    var body: some View {
        NavigationStack{
            ScrollView(.vertical) {
                LazyVStack(spacing:12){
                    FilterTransactionsView(category: selectedCategory, searchText: filterText) { transactions in
                        ForEach(transactions){ transaction in
                            NavigationLink {
                                TransactionView(editTransaction: transaction)
                            } label: {
                                    TransactionCardView(transaction: transaction)
                            }
                            .buttonStyle(.plain)

                        }
                    }
                }
                .padding(15)
            }
            .overlay(content:{
                ContentUnavailableView("Search Transactions", systemImage: "magnifyingglass")
                    .opacity(filterText.isEmpty ? 1 : 0)
            })
            .onChange(of: searchText, { oldValue, newValue in
                if(newValue.isEmpty){
                    filterText = ""
                }
                searchPublisher.send(newValue)
            })
            .onReceive(searchPublisher.debounce(for: .seconds(0.3), scheduler: DispatchQueue.main), perform: { text in
                filterText = text
                print(filterText)
            })
            .searchable(text: $searchText)
            .navigationTitle("Search")
            .background(.gray.opacity(0.15))
        }
    }
}

#Preview {
    Search()
}
