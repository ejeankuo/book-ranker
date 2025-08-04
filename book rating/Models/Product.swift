//
//  Product.swift
//  book rating
//
//  Created by Ejean Kuo on 8/4/25.
//

import Foundation

struct Book : Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var description: String
    var author: String
    //var rating: Int
}
