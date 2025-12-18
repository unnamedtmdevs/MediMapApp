//
//  SymptomCheckerViewModel.swift
//  MediMapApp
//

import Foundation
import Combine

class SymptomCheckerViewModel: ObservableObject {
    @Published var symptoms: [Symptom] = []
    @Published var selectedSymptoms: Set<Int> = []
    @Published var searchText: String = ""
    @Published var filterBySeverity: SymptomSeverity?
    
    private let dataService = DataService.shared
    private var cancellables = Set<AnyCancellable>()
    
    var filteredSymptoms: [Symptom] {
        symptoms.filter { symptom in
            let matchesSearch = searchText.isEmpty || symptom.name.localizedCaseInsensitiveContains(searchText)
            let matchesSeverity = filterBySeverity == nil || symptom.severity == filterBySeverity
            return matchesSearch && matchesSeverity
        }
    }
    
    var selectedSymptomsDetails: [Symptom] {
        symptoms.filter { selectedSymptoms.contains($0.id) }
    }
    
    func fetchSymptoms() {
        symptoms = dataService.fetchSymptoms()
    }
    
    func toggleSymptom(_ symptomId: Int) {
        if selectedSymptoms.contains(symptomId) {
            selectedSymptoms.remove(symptomId)
        } else {
            selectedSymptoms.insert(symptomId)
        }
    }
    
    func clearSelection() {
        selectedSymptoms.removeAll()
    }
    
    func getSeverityRecommendation() -> String {
        guard !selectedSymptoms.isEmpty else {
            return "Select symptoms to get a recommendation"
        }
        
        let maxSeverity = selectedSymptomsDetails.map { $0.severity }.max { severity1, severity2 in
            let order: [SymptomSeverity] = [.mild, .moderate, .severe, .emergency]
            return order.firstIndex(of: severity1)! < order.firstIndex(of: severity2)!
        }
        
        switch maxSeverity {
        case .emergency:
            return "⚠️ EMERGENCY: Seek immediate medical attention or call emergency services!"
        case .severe:
            return "🚨 Visit a doctor or urgent care as soon as possible"
        case .moderate:
            return "⚕️ Consider scheduling a doctor's appointment within 1-2 days"
        case .mild:
            return "💊 Monitor symptoms. Consider over-the-counter remedies and rest"
        case .none:
            return "Select symptoms to get a recommendation"
        }
    }
}

