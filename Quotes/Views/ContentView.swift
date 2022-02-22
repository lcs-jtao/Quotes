//
//  ContentView.swift
//  Quotes
//
//  Created by Joyce Tao on 2022-02-22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            Text("The two most powerful warriors are patience and time.")
                .multilineTextAlignment(.leading)
                .padding(30)
                .overlay(
                    Rectangle()
                        .stroke(Color.primary, lineWidth: 4)
                )
                .padding(10)
            
            Image(systemName: "heart.circle")
                .resizable()
                .frame(width: 40, height: 40)
            
            Button(action: {
                print("Button was pressed")
            }, label: {
                Text("Another one!")
            })
                .buttonStyle(.bordered)
            
            HStack {
                Text("Favourites")
                    .bold()
                    .font(.title)
                Spacer()
            }
            
            List {
                Text("Nothing is a waste of time if you use the experience wisely.")
                Text("If your actions inspire others to dream more, learn more, do more and become more, you are a leader.")
            }
            
            Spacer()
                        
        }
        .navigationTitle("Quotes")
        .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
