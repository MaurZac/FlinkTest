//
//  CharactersModel.swift
//  FlinkTest
//
//  Created by Mauricio Zarate on 23/01/21.
//

import Foundation

 struct  CharactersModel: Codable {
    var results: [results]
}

struct results:Codable {
    public var name: String?
    public var status: String!
    public var species: String!
    public var type: String?
    public var gender: String!
    public var image: String?
}
