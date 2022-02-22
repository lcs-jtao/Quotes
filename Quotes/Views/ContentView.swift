//
//  ContentView.swift
//  Quotes
//
//  Created by Joyce Tao on 2022-02-22.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Stored properties
    
    // Holds the current joke
    @State var currentQuote: Quote = Quote(quoteText: "", quoteAuthor: "", senderName: "", senderLink: "", quoteLink: "")
    
    // MARK: Computed properties
    var body: some View {
        VStack {
            
            VStack(spacing: 20) {
                Text(currentQuote.quoteText)

                HStack {
                    Spacer()
                    Text("- \(currentQuote.quoteAuthor)")
                        .font(.caption)
                        .italic()
                }
            }
                .multilineTextAlignment(.center)
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
        .task {
            // Assemble the URL that points to the endpoint
            let url = URL(string: "https://api.forismatic.com/api/1.0/?method=getQuote&key=457653&format=json&lang=en")!
            
            // Define the type of data we want from the endpoint
            // Configure the request to the website
            var request = URLRequest(url: url)
            
            // Ask for JSON data
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            // Start a session to interact (talk with) the endpoint
            let urlSession = URLSession.shared
            
            // Try to fetch a new joke
            // It might not work, so we use a do-catch block
            do {
                // Got the raw data from the endpoint
                let (data, _) = try await urlSession.data(for: request)
                
                // Attempt to decode the raw data into a Swift structure
                // Takes what is in "data" and tries to put it into "currentJoke"
                //                              DATA TYPE TO DECODE TO
                //                                       |
                //                                       V
                currentQuote = try JSONDecoder().decode(Quote.self, from: data)
            } catch {
                print("Could not retrieve or decode the JSON from endpoint.")
                // Print the contents of the "error" constant that the do-catch block populates
                print(error)
            }
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
