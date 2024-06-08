//
//  IntroScreen.swift
//  ExpenseTrackerApp
//
//  Created by Shivam Sultaniya on 06/06/24.
//

import SwiftUI

struct IntroScreen: View {
    
    //Visibility Status
    @AppStorage("isFirstTime") private var isFirstTime: Bool = true
    
    
    
    var body: some View {
        VStack(spacing:15){
            Text("What's New in the\nExpense Tracker")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding(.top,65)
                .padding(.bottom,35)
            
            
            //Points View
            VStack(alignment: .leading,spacing: 25, content: {
                PointView(imageName: "dollarsign", title: "Transactions", subTitle: "Keep track of your earnings and expenses.")
                PointView(imageName: "chart.bar.fill", title: "Visual Charts", subTitle: "View your transactions using eye-catching graphic representations.")
                PointView(imageName: "magnifyingglass", title: "Advance Filters", subTitle: "Find the expenses you want by advance search and filtering.")
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal,15)
            
            Spacer()
            
            Button(action: {
                isFirstTime = false
            }, label: {
                Text("Continue")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,14)
                    .background(appTint.gradient)
                    .cornerRadius(12)
                    .contentShape(.rect)
                
            })
        }
        .padding(15)
    }
    
}

#Preview {
    IntroScreen()
}


struct PointView: View{
    
    var imageName: String
    var title: String
    var subTitle: String
    
    var body: some View{
        HStack(spacing:20){
            Image(systemName: imageName)
                .font(.largeTitle)
                .foregroundStyle(appTint.gradient)
                .frame(width: 45)
            
            VStack(alignment: .leading, spacing: 6, content: {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                Text(subTitle)
                    .foregroundStyle(.gray)
            })
        }
    }
}
