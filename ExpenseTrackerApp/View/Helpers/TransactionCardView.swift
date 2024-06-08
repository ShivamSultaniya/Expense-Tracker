//
//  TransactionCardView.swift
//  ExpenseTrackerApp
//
//  Created by Shivam Sultaniya on 07/06/24.
//

import SwiftUI

struct TransactionCardView: View {
    
    var transaction: Transaction
    
    var body: some View {
        HStack(spacing:12){
            Text("\(String(transaction.title.prefix(1)))")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(width: 45, height: 45)
                .background(transaction.color.gradient, in: .circle)
            
            VStack(alignment:.leading, spacing: 4){
                Text(transaction.title)
                    .foregroundStyle(Color.primary)
                Text(transaction.remarks)
                    .font(.caption)
                    .foregroundStyle(Color.primary.secondary)
                Text(format(date: transaction.dateAdded, format: "dd MMM yyyy"))
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            .lineLimit(1)
            .hSpacing(.leading)
            
            Text(currencyString(transaction.amount, allowedDigits: 1))
                .fontWeight(.semibold)
        }
        .padding(.horizontal,15)
        .padding(.vertical,10)
        .background(.background, in: .rect(cornerRadius: 10))
    }
}

