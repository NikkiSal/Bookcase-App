//
//  Book.swift
//  BookCase

import UIKit
struct Book:Equatable {
    static let defaultCover = UIImage(named: "book.png")!// we already have a default image stored
    var title:String
    var author:String
    var rating:Double
    var isbn:String
    var notes:String
    private var image:UIImage? = nil // private resticts access to the image property within the Book struct
    var cover:UIImage{
        get {
            return image ?? Book.defaultCover
        }
        set {
            image = newValue
        }
    }
    init(title:String, author:String, rating:Double, isbn:String, notes:String, cover:UIImage? = nil) {
        self.title = title
        self.author = author
        self.rating = rating
        self.isbn = isbn
        self.notes = notes
        self.image = cover
    }
}
