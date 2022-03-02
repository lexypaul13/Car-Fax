//
//  Cars.swift
//  Car Fax
//
//  Created by Alex Paul on 3/1/22.
//

import Foundation

struct Cars: Codable, Hashable {
    let listings: [Listing]
    enum CodingKeys: String, CodingKey {
        case listings
    }
}

struct Listing: Codable, Hashable {
    
    let dealer: Dealer
    let id: String
    let images: Images
    let make: String
    let mileage: Int
    let year: Int
    let listPrice: Int
    let trim: String
    let model: String
    let currentPrice: Int

    enum CodingKeys: String, CodingKey {
        
        case dealer
        case id
        case images
        case make
        case model
        case listPrice
        case mileage
        case year
        case trim
        case currentPrice
    }
}


struct Dealer: Codable,Hashable {
    
    let address: String
    let city: String
    let phone: String
    let state: String
    
    enum CodingKeys: String, CodingKey {
        
        case address
        case city
        case phone
        case state
    }
}

struct Images: Codable,Hashable {
    let baseURL: String
    let firstPhoto: FirstPhoto

    enum CodingKeys: String, CodingKey {
        case baseURL = "baseUrl"
        case firstPhoto
    }
}

struct FirstPhoto: Codable,Hashable {
    
    let large, medium, small: String
}



extension String {
    public func toPhoneNumber() -> String {
        return self.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: nil)
    }
}
