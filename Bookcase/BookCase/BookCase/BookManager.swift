//
//  BookManager.swift
//  BookCase
//
//  Created by Marzieh on 2019-11-06.
//  Copyright © 2019 Myph. All rights reserved.
//

import Foundation

class BooksManager {
    
    private lazy var books = loadBooks() // lazy stored property because it's an instance method
    var bookCount:Int {
        return books.count
    }
    func getBook(at index:Int)->Book {
        return books[index]
    }
    
    private func loadBooks() -> [Book] {
        return sampleBooks()
    }
    
    private func sampleBooks() ->[Book] {
        return [
            Book(title: "Great Expectations", author: "Charles Dickes", rating: 5, isbn: "97454545345", notes: " gift from papa"),
            Book(title: "Don Quixote", author: "Miquel De Cervantes", rating: 4, isbn: "32344534534", notes: ""),
            Book(title: "Harry Potter", author: "J.K. Rowling", rating: 5, isbn: "345345345", notes: "Best book ever"),
            Book(title: "Gulliver's Travels", author: "Jonathan Swift", rating: 5, isbn: "", notes: "")
        ]
        
    }
}
