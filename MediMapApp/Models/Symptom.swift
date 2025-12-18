//
//  Symptom.swift
//  MediMapApp
//

import Foundation

struct Symptom: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String
    let severity: SymptomSeverity
    
    init(id: Int, name: String, description: String = "", severity: SymptomSeverity = .mild) {
        self.id = id
        self.name = name
        self.description = description
        self.severity = severity
    }
}

enum SymptomSeverity: String, Codable {
    case mild = "Mild"
    case moderate = "Moderate"
    case severe = "Severe"
    case emergency = "Emergency"
    
    var color: String {
        switch self {
        case .mild:
            return "#4CAF50"
        case .moderate:
            return "#FF9800"
        case .severe:
            return "#F44336"
        case .emergency:
            return "#D32F2F"
        }
    }
}

