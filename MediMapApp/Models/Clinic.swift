//
//  Clinic.swift
//  MediMapApp
//

import Foundation

struct Clinic: Identifiable, Codable {
    let id: Int
    let name: String
    let address: String
    let phoneNumber: String
    let specialties: [String]
    let rating: Double
    let isOpen: Bool
    
    init(id: Int, name: String, address: String, phoneNumber: String, specialties: [String], rating: Double, isOpen: Bool) {
        self.id = id
        self.name = name
        self.address = address
        self.phoneNumber = phoneNumber
        self.specialties = specialties
        self.rating = rating
        self.isOpen = isOpen
    }
}

