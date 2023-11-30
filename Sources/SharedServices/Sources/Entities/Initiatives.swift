//
//  Initiatives.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 28.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation

// MARK: - Initiative
public struct Initiative: Codable, Equatable {
    public static func == (lhs: Initiative, rhs: Initiative) -> Bool {
        lhs.id == rhs.id
    }
    
    public let id, title, description, media: String
    public let status: String
    public let isUrgent: Bool
    public let progress: Int
    public let sponsor: Sponsor
    public let contacts: [Contact]
    public let directions: [Direction]
    public let items: [Item]
}

extension Initiative: Identifiable { }

// MARK: - Contact
public struct Contact: Codable, Hashable {
    public static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.email == rhs.email &&
        lhs.firstName == rhs.firstName &&
        lhs.lastName == rhs.lastName
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(firstName)
        hasher.combine(lastName)
        hasher.combine(email)
    }
    
    public let firstName, lastName: String
    public let phones: [Phone]
    public let email: String
    public let links: [Link]
}

// MARK: - Link
public struct Link: Codable {
    public let url: String
    public let platform: String
}

// MARK: - Phone
public struct Phone: Codable {
    public let number: String
    public let types: [String]
}

// MARK: - Direction
public struct Direction: Codable, Hashable {
    public let directionsType: String
    public let street: String?
    public let town, directions: String
    public let office: Int?
    public let recipient: Contact?
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(street)
        hasher.combine(office)
    }
}

// MARK: - Item
public struct Item: Codable, Hashable {
    public let title, description, media, unit: String
    public let target, current: Int
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(description)
    }
}

extension Item: Identifiable {
    public var id: UUID {
        UUID()
    }
    
    
}

// MARK: - Sponsor
public struct Sponsor: Codable {
    public let id, userName, name: String
}

extension Sponsor: Equatable {
    
}

public typealias Initiatives = [Initiative]
