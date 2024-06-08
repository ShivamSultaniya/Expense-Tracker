//
//  Settings.swift
//  ExpenseTrackerApp
//
//  Created by Shivam Sultaniya on 06/06/24.
//

import SwiftUI

struct Settings: View {
    //User Properties
    @AppStorage("userName") private var userName: String = ""
    
    var body: some View {
        NavigationStack{
            List{
                Section("User Name"){
                    TextField("Username", text: $userName)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    ContentView()
}
