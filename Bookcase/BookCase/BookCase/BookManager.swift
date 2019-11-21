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
    case isbn
}

class BooksManager {
    
    private lazy var books = loadBooks() // lazy stored property because it's an instance method
    private var filteredBooks:[Book] = []
    
    var sortOrder:SortOrder = .title {
        didSet {
            sort(books: &books)
        }
    }
    var searchFilter = "" {
        didSet {
            filter()
        }
    }
    
    var bookCount:Int {
        // if the searh is empty then return the regualr book count, if not return the filtered books count
        return searchFilter.isEmpty ? books.count : filteredBooks.count
        
    }
    func getBook(at index:Int)->Book {
        return searchFilter.isEmpty ? books[index] : filteredBooks[index]
    }
    
    private func loadBooks() -> [Book] {
        return sampleBooks()
    }
    
    func addBook(_ book:Book) {
        books.append(book)
        sort(books: &books)
    }
    
    func updateBook(at index:Int, with book:Book) {
        if searchFilter.isEmpty {
            books[index] = book
            sort(books: &books)
        } else {
            let bookToUpdate = filteredBooks[index]
            guard let bookIndex = books.firstIndex(of: bookToUpdate) else {
                print("Error:book not found")
                return
            }
            books[bookIndex] = book //
            sort(books: &books) // the updated book might need to be resorted
            filter() // the updated book might need to be refiltered
        }
        
    }
    
    func removeBooks(at index:Int) {
        if searchFilter.isEmpty {
        books.remove(at: index)
        } else {
            // index is relevant to filteredBooks
            //  the book also needs to be removed from the books array, and inorder to do that we can get the index of the book from here
            let removedBook = filteredBooks.remove(at: index)
            guard let bookIndex = books.firstIndex(of: removedBook) else {
                print("print (Error:book not found")
                return
            }
            books.remove(at:bookIndex)
        }
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
    func filter () {
        filteredBooks = books.filter { book in
            return book.title.localizedLowercase.contains(searchFilter.localizedLowercase) || book.author.localizedLowercase.contains(searchFilter.localizedLowercase)
        }
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
