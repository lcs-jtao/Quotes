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
    @State var favourites: [Quote] = []
    @State var currentQuoteAddedToFavourites: Bool = false
    
    // MARK: Computed properties
    var body: some View {
        VStack {
            
            VStack(spacing: 20) {
                Text(currentQuote.quoteText)
                    .minimumScaleFactor(0.5)
                    .font(.title)

                HStack {
                    Spacer()
                    Text("- \(currentQuote.quoteAuthor)")
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
                .font(.largeTitle)
                .onTapGesture {
                    if currentQuoteAddedToFavourites == false {
                        favourites.append(currentQuote)
                        currentQuoteAddedToFavourites = true
                    }
                }
                .foregroundColor(currentQuoteAddedToFavourites == true ? .red : .secondary)
            
            Button(action: {
                print("Button was pressed")
                Task {
                    await loadNewQuote()
                }
            }, label: {
                Text("Another one!")
            })
                .buttonStyle(.bordered)
            
            HStack {
                Text("Favourites")
                    .bold()
                    .font(.title2)
                Spacer()
            }
            
            List(favourites, id: \.self) { currentQuote in
                Text(currentQuote.quoteText)
            }
            
            Spacer()
                        
        }
        .task {
            await loadNewQuote()
            
            print("Have just attempted to load a new quote.")
        }
        .navigationTitle("Quotes")
        .padding()
    }
    
    func loadNewQuote() async {
        let url = URL(string: "https://api.forismatic.com/api/1.0/?method=getQuote&key=457653&format=json&lang=en")!
        
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let urlSession = URLSession.shared
        
        do {
            let (data, _) = try await urlSession.data(for: request)

            currentQuote = try JSONDecoder().decode(Quote.self, from: data)
            
            currentQuoteAddedToFavourites = false
        } catch {
            print("Could not retrieve or decode the JSON from endpoint.")

            print(error)
        }
    }
    
    func persistFavourites() {
        
        let filename = getDocumentsDirectory().appendingPathComponent(savedFavouritesLabel)
        
        do {
            let encoder = JSONEncoder()

            encoder.outputFormatting = .prettyPrinted
            
            let data = try encoder.encode(favourites)
            
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            
            print("Saved data to documents directory successfully.")
            print("===")
            print(String(data: data, encoding: .utf8)!)
            
        } catch {
            
            print(error.localizedDescription)
            print("Unable to write list of favourites to documents directory in app bundle on device.")
            
        }

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
