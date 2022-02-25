//
//  Quote.swift
//  Quotes
//
//  Created by Joyce Tao on 2022-02-22.
//

import Foundation

struct Quote: Decodable, Identifiable {
    let id = UUID()
    let quoteText: String
    let quoteAuthor: String
    let senderName: String
    let senderLink: String
    let quoteLink: String
}
