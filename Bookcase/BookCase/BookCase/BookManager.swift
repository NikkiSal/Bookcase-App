//
//  BookManager.swift
//  BookCase
//
//  Copyright © 2019 Myph. All rights reserved.
//

import Foundation

enum SortOrder: Int {
    case title
    case author
    
}

class BooksManager {
    
    private lazy var books = loadBooks() // lazy stored property because it's an instance method
    var sortOrder:SortOrder = .title {
        didSet {
            sort(books: &books)
        }
    }
    
    var bookCount:Int {
        return books.count
    }
    func getBook(at index:Int)->Book {
        return books[index]
    }
    
    private func loadBooks() -> [Book] {
        return sampleBooks()
    }
    
    func addBook(_ book:Book) {
        books.append(book)
        sort(books: &books)
    }
    
    func updateBook(at index:Int, with book:Book) {
        books[index] = book
        sort(books: &books)
    }
    
    func removeBooks(at index:Int) {
        books.remove(at: index)
    }
    
    private func sampleBooks() ->[Book] {
        var books = [
            Book(title: "Great Expectations", author: "Charles Dickes", rating: 5, isbn: "97454545345", notes: " gift from papa"),
            Book(title: "Don Quixote", author: "Miquel De Cervantes", rating: 4, isbn: "32344534534", notes: ""),
            Book(title: "Harry Potter", author: "J.K. Rowling", rating: 5, isbn: "345345345", notes: "Best book ever"),
            Book(title: "Gulliver's Travels", author: "Jonathan Swift", rating: 5, isbn: "", notes: "")
        ]
        sort(books: &books)
        return books
    }
    func sort(books:inout [Book]) {
        switch sortOrder {
        case .title:
            books.sort {
                return ($0.title.localizedLowercase, $1.author.localizedLowercase) < ($1.title.localizedLowercase, $1.author.localizedLowercase)
            }
        case .author:
            books.sort {
                return ($0.author.localizedLowercase, $1.title.localizedLowercase) < ($1.author.localizedLowercase, $1.title.localizedLowercase)
            }
        default:
            print("do something else")
        }
    }
}
