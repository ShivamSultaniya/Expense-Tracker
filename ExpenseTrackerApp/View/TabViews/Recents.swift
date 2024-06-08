//
//  Recents.swift
//  ExpenseTrackerApp
//
//  Created by Shivam Sultaniya on 06/06/24.
//

import SwiftUI
import SwiftData

struct Recents: View {
    
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    @State private var selectedCategory: Category = .expense
    @State private var showFilterView: Bool = false
    //for animation
    @Namespace private var animation
    
    var body: some View {
        GeometryReader{
            let size = $0.size
            
            NavigationStack{
                ScrollView(.vertical) {
                    LazyVStack(spacing:10, pinnedViews: [.sectionHeaders]){
                        Section {
                            //Date Filter Button
                            Button {
                                showFilterView = true
                            } label: {
                                Text("\(format(date: startDate, format: "dd-MMM-yy")) to \(format(date: endDate, format: "dd-MMM-yy"))")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            .hSpacing(.leading)
                            
                            FilterTransactionsView(startDate: startDate, endDate: endDate) { transactions in
                                //card view
                                CardView(income: total(transactions, category: .income),
                                         expense: total(transactions, category: .expense))
                                
                                //Custom Segmented Control
                                CustomSegmentedControl()
                                    .padding(.bottom,5)
                                
                                ForEach(transactions.filter({ $0.category == selectedCategory.rawValue })){ transaction in
                                    NavigationLink(value: transaction) {
                                        TransactionCardView(transaction: transaction)
                                    }
                                }
                            }
                        } header: {
                            HeaderView(size: size)
                        }
                    }
                    .padding(15)
                }
                .background(.gray.opacity(0.15))
                .blur(radius: showFilterView ? 8:0)
                .disabled(showFilterView)
                .navigationDestination(for: Transaction.self) { transaction in
                    TransactionView(editTransaction: transaction)
                }
            }
            .overlay{
                ZStack{
                    if showFilterView{
                        DateFilterView(start: startDate, end: endDate, onSubmit: {
                            start, end in
                            startDate = start
                            endDate = end
                            showFilterView = false
                        }, onClose: {
                            showFilterView = false
                        })
                            .transition(.move(edge: .leading))
                    }
                }
            }
            .animation(.snappy, value: showFilterView)
        }
    }
    
    
    @ViewBuilder
    func CustomSegmentedControl() -> some View{
        HStack(spacing:0){
            ForEach(Category.allCases, id: \.rawValue){ category in
                Text(category.rawValue)
                    .hSpacing()
                    .padding(.vertical,10)
                    .background{
                        if category == selectedCategory{
                            Capsule()
                                .fill(.background)
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                    .contentShape(.capsule)
                    .onTapGesture {
                        withAnimation(.snappy){
                            selectedCategory = category
                        }
                    }
            }
        }
        .background(.gray.opacity(0.15), in: .capsule)
        .padding(.top,5)
    }
    
}

#Preview {
    Recents()
}

struct HeaderView: View{
    
    var size: CGSize
    //User Properties
    @AppStorage("userName")private var userName: String = ""
    
    var body: some View{
        
        HStack(spacing:10){
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Welcome!")
                    .font(.title.bold())
                
                if !userName.isEmpty{
                    Text(userName)
                        .font(.callout)
                        .foregroundStyle(.gray)
                    
                }
                
            }
            
            Spacer(minLength: 0)
            
            NavigationLink {
                TransactionView()
            } label: {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(appTint.gradient, in: .circle)
                    .contentShape(.circle)
            }
        }
        .padding(.bottom,userName.isEmpty ? 10 : 5)
        .background{
            Rectangle()
                .fill(.ultraThinMaterial)
                .padding(.horizontal,-15)
                .padding(.top,-(safeArea.top + 15))
        }
    }
}
