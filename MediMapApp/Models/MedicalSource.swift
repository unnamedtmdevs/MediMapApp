//
//  MedicalSource.swift
//  MediMapApp
//

import Foundation

struct MedicalSource: Identifiable, Codable {
    let id: Int
    let name: String
    let organization: String
    let url: String
    let year: Int
    
    var displayText: String {
        "\(name) - \(organization), \(year)"
    }
}

// Common medical sources for citations
extension MedicalSource {
    static let mayoClinic = MedicalSource(
        id: 1,
        name: "Mayo Clinic",
        organization: "Mayo Foundation for Medical Education and Research",
        url: "https://www.mayoclinic.org",
        year: 2024
    )
    
    static let cdc = MedicalSource(
        id: 2,
        name: "Centers for Disease Control and Prevention",
        organization: "U.S. Department of Health & Human Services",
        url: "https://www.cdc.gov",
        year: 2024
    )
    
    static let nih = MedicalSource(
        id: 3,
        name: "National Institutes of Health",
        organization: "U.S. Department of Health & Human Services",
        url: "https://www.nih.gov",
        year: 2024
    )
    
    static let medlinePlus = MedicalSource(
        id: 4,
        name: "MedlinePlus",
        organization: "National Library of Medicine",
        url: "https://medlineplus.gov",
        year: 2024
    )
    
    static let who = MedicalSource(
        id: 5,
        name: "World Health Organization",
        organization: "WHO",
        url: "https://www.who.int",
        year: 2024
    )
    
    static let webMD = MedicalSource(
        id: 6,
        name: "WebMD",
        organization: "WebMD LLC",
        url: "https://www.webmd.com",
        year: 2024
    )
}

