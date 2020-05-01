//
//  Characters.swift
//  DisplayCardTesting
//
//  Created by Tayler Moosa on 4/26/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import Foundation

struct Character: Codable {
    let name: String
    let species: Species
    let gender: Gender
    let house, dateOfBirth: String
    let yearOfBirth: YearOfBirth
    let ancestry, eyeColour, hairColour: String
    let wand: Wand
    let patronus: String
    let hogwartsStudent, hogwartsStaff: Bool
    let actor: String
    let alive: Bool
    let image: String
}
enum Gender: String, Codable {
    case female     = "female"
    case male       = "male"
}

enum Species: String, Codable {
    case cat        = "cat"
    case halfGiant  = "half-giant"
    case human      = "human"
    case werewolf   = "werewolf"
}
struct Wand: Codable {
    let wood, core: String
    let length: Length
}
enum Length: Codable {
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Length.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Length"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
enum YearOfBirth: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(YearOfBirth.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for YearOfBirth"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
