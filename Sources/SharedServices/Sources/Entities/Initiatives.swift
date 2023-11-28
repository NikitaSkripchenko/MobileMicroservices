//
//  Initiatives.swift
//  ViperApp
//
//  Created by Nikita Skrypchenko on 28.11.2023.
//  Copyright © 2023 OporaOrg. All rights reserved.
//

import Foundation

// MARK: - Initiative
struct Initiative: Codable {
    let id, title, description, media: String
    let status: String
    let isUrgent: Bool
    let progress: Int
    let sponsor: Sponsor
    let contacts: [Contact]
    let directions: [Direction]
    let items: [Item]
}

// MARK: - Contact
struct Contact: Codable {
    let firstName, lastName: String
    let phones: [Phone]
    let email: String
    let links: [Link]
}

// MARK: - Link
struct Link: Codable {
    let url: String
    let platform: String
}

// MARK: - Phone
struct Phone: Codable {
    let number: String
    let types: [String]
}

// MARK: - Direction
struct Direction: Codable {
    let directionsType: String
    let street: String?
    let town, directions: String
    let office: Int?
    let recipient: Contact?
}

// MARK: - Item
struct Item: Codable {
    let title, description, media, unit: String
    let target, current: Int
}

// MARK: - Sponsor
struct Sponsor: Codable {
    let id, userName, name: String
}

typealias Initiatives = [Initiative]
