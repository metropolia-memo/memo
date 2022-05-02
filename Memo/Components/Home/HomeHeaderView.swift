//
//  HomeHeaderView.swift
//  Memo
//
//  Created by Markus Nivasalo on 7.4.2022.
//
//  Header portion of the Home screen
//

import SwiftUI

struct HomeHeaderView: View {
    
    @StateObject private var dataController = DataController()
    @ObservedObject var api : QuoteApi = QuoteApi()
    
    @EnvironmentObject private var userSettings: UserSettings
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading) {
                    Text(userSettings.nickname != "" ? "Welcome back, \(userSettings.nickname)" : "Welcome back")
                        .font(.system(size: 28))
                    Text("Last visit: 15/03/2022")
                        .font(.caption)
                }
                NavigationLink(destination: Profile().environment(\.managedObjectContext, dataController.container.viewContext)) {
                    ProfilePicture()
                        .frame(width: 100, height: 100)
                }
            }
            .fixedSize()
            VStack(alignment: .leading){
                Text(self.api.dailyQuote).font(.system(size: 16))
                    .italic()
                    .padding(5)
                Text("- \(self.api.dailyAuthor)").font(.caption)
                    .padding(5)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.accentColor, lineWidth: 1)
            )
            
        }
        .onAppear {
            api.callAPI()
        }
        .padding()
    }
    
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView()
            .previewLayout(.sizeThatFits)
    }
}
