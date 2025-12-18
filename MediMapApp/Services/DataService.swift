//
//  DataService.swift
//  MediMapApp
//

import Foundation

class DataService {
    static let shared = DataService()
    
    private init() {}
    
    // MARK: - Symptoms Data
    
    func fetchSymptoms() -> [Symptom] {
        return [
            Symptom(id: 1, name: "Cough", description: "Persistent or occasional cough", severity: .mild),
            Symptom(id: 2, name: "Fever", description: "Elevated body temperature", severity: .moderate),
            Symptom(id: 3, name: "Headache", description: "Pain in the head region", severity: .mild),
            Symptom(id: 4, name: "Chest Pain", description: "Pain or discomfort in the chest area", severity: .severe),
            Symptom(id: 5, name: "Shortness of Breath", description: "Difficulty breathing", severity: .severe),
            Symptom(id: 6, name: "Nausea", description: "Feeling of sickness", severity: .mild),
            Symptom(id: 7, name: "Dizziness", description: "Feeling lightheaded or unsteady", severity: .moderate),
            Symptom(id: 8, name: "Fatigue", description: "Extreme tiredness", severity: .mild),
            Symptom(id: 9, name: "Sore Throat", description: "Pain or irritation in the throat", severity: .mild),
            Symptom(id: 10, name: "Severe Bleeding", description: "Uncontrolled bleeding", severity: .emergency)
        ]
    }
    
    // MARK: - Clinics Data
    
    func fetchClinics() -> [Clinic] {
        return [
            Clinic(
                id: 1,
                name: "City General Hospital",
                address: "123 Main Street, Suite 100",
                phoneNumber: "+1 (555) 123-4567",
                specialties: ["Emergency", "General Practice", "Surgery", "Internal Medicine"],
                rating: 4.5,
                isOpen: true
            ),
            Clinic(
                id: 2,
                name: "Downtown Medical Center",
                address: "456 Oak Avenue, Floor 2",
                phoneNumber: "+1 (555) 234-5678",
                specialties: ["Cardiology", "Pediatrics", "Orthopedics", "Radiology"],
                rating: 4.7,
                isOpen: true
            ),
            Clinic(
                id: 3,
                name: "Northside Clinic",
                address: "789 Pine Road, Building A",
                phoneNumber: "+1 (555) 345-6789",
                specialties: ["Family Medicine", "Dermatology", "Women's Health"],
                rating: 4.3,
                isOpen: false
            ),
            Clinic(
                id: 4,
                name: "Westside Urgent Care",
                address: "321 Elm Street",
                phoneNumber: "+1 (555) 456-7890",
                specialties: ["Urgent Care", "X-Ray", "Lab Services", "Minor Surgery"],
                rating: 4.6,
                isOpen: true
            ),
            Clinic(
                id: 5,
                name: "Community Health Center",
                address: "555 Maple Drive",
                phoneNumber: "+1 (555) 567-8901",
                specialties: ["Primary Care", "Mental Health", "Dental"],
                rating: 4.4,
                isOpen: true
            ),
            Clinic(
                id: 6,
                name: "Sunrise Medical Group",
                address: "888 Cedar Lane",
                phoneNumber: "+1 (555) 678-9012",
                specialties: ["Ophthalmology", "ENT", "Allergy"],
                rating: 4.8,
                isOpen: true
            )
        ]
    }
    
    // MARK: - Medical Information
    
    func fetchMedicalInfo() -> [MedicalInfo] {
        return [
            MedicalInfo(
                id: 1,
                title: "Common Cold",
                category: "Respiratory",
                description: "A viral infection of your nose and throat. Usually harmless but can feel uncomfortable. The common cold is typically caused by rhinoviruses.",
                symptoms: ["Runny nose", "Sore throat", "Cough", "Sneezing", "Mild headache"],
                treatments: ["Rest", "Drink plenty of fluids", "Over-the-counter medications for symptom relief"],
                sources: [.cdc, .mayoClinic, .medlinePlus],
                disclaimer: "This information is for educational purposes only and is not medical advice. Always consult a healthcare professional for diagnosis and treatment."
            ),
            MedicalInfo(
                id: 2,
                title: "Influenza (Flu)",
                category: "Respiratory",
                description: "A contagious respiratory illness caused by influenza viruses. It can cause mild to severe illness, and at times can lead to death.",
                symptoms: ["Fever or feeling feverish", "Cough", "Sore throat", "Body aches", "Fatigue", "Headaches"],
                treatments: ["Antiviral medications (prescribed by doctor)", "Rest", "Drink plenty of fluids", "Over-the-counter pain relievers"],
                sources: [.cdc, .who, .mayoClinic],
                disclaimer: "This information is for educational purposes only and is not medical advice. Consult your doctor immediately if you have severe symptoms or are in a high-risk group."
            ),
            MedicalInfo(
                id: 3,
                title: "Migraine",
                category: "Neurological",
                description: "A neurological condition characterized by intense, debilitating headaches. Migraines can cause significant pain for hours to days.",
                symptoms: ["Severe throbbing headache", "Nausea and vomiting", "Sensitivity to light and sound", "Visual disturbances (aura)", "Dizziness"],
                treatments: ["Prescription migraine medications", "Pain relievers", "Rest in quiet, dark room", "Cold compress", "Avoiding triggers"],
                sources: [.mayoClinic, .nih, .medlinePlus],
                disclaimer: "This is general information only. If you experience severe or frequent migraines, consult a neurologist for proper diagnosis and treatment plan."
            ),
            MedicalInfo(
                id: 4,
                title: "Gastroenteritis",
                category: "Digestive",
                description: "Inflammation of the stomach and intestines, commonly called 'stomach flu'. It's usually caused by a viral or bacterial infection.",
                symptoms: ["Watery diarrhea", "Nausea and vomiting", "Stomach cramps and pain", "Low-grade fever", "Dehydration"],
                treatments: ["Drink plenty of clear fluids", "Oral rehydration solutions", "Rest", "Gradual return to bland foods (BRAT diet)", "Avoid solid foods initially"],
                sources: [.cdc, .mayoClinic, .webMD],
                disclaimer: "Seek immediate medical attention if you have severe dehydration, bloody stools, high fever, or symptoms lasting more than several days."
            ),
            MedicalInfo(
                id: 5,
                title: "Allergic Rhinitis (Hay Fever)",
                category: "Respiratory",
                description: "An allergic response to allergens such as pollen, dust mites, or pet dander. It causes cold-like signs and symptoms.",
                symptoms: ["Sneezing", "Itchy nose, eyes or throat", "Runny or stuffy nose", "Watery, red or swollen eyes"],
                treatments: ["Antihistamines", "Nasal corticosteroid sprays", "Avoid known allergens", "Air purifiers", "Immunotherapy for severe cases"],
                sources: [.mayoClinic, .medlinePlus, .nih],
                disclaimer: "For proper allergy diagnosis and treatment, consult an allergist or immunologist."
            )
        ]
    }
}

struct MedicalInfo: Identifiable, Codable {
    let id: Int
    let title: String
    let category: String
    let description: String
    let symptoms: [String]
    let treatments: [String]
    let sources: [MedicalSource]
    let disclaimer: String
}

