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
    
    // Медицинские источники для рекомендаций
    let medicalSources: [MedicalSource] = [
        .cdc,
        .mayoClinic,
        .nih,
        .who
    ]
    
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
    
    func getSeverityRecommendation() -> (text: String, severity: SymptomSeverity?) {
        guard !selectedSymptoms.isEmpty else {
            return ("Select symptoms to get a recommendation", nil)
        }
        
        let maxSeverity = selectedSymptomsDetails.map { $0.severity }.max { severity1, severity2 in
            let order: [SymptomSeverity] = [.mild, .moderate, .severe, .emergency]
            return order.firstIndex(of: severity1)! < order.firstIndex(of: severity2)!
        }
        
        switch maxSeverity {
        case .emergency:
            return ("⚠️ EMERGENCY: Seek immediate medical attention or call emergency services immediately! Do not wait.", .emergency)
        case .severe:
            return ("🚨 Based on your symptoms, you should visit a doctor or urgent care facility as soon as possible for proper medical evaluation.", .severe)
        case .moderate:
            return ("⚕️ We recommend scheduling an appointment with your healthcare provider within the next 1-2 days to discuss your symptoms.", .moderate)
        case .mild:
            return ("💊 Monitor your symptoms carefully. If symptoms persist or worsen, consult a healthcare professional. Rest and stay hydrated.", .mild)
        case .none:
            return ("Select symptoms to get a recommendation", nil)
        }
    }
    
    func getSourcesRelevantText() -> String {
        return "These recommendations are based on general medical guidelines from trusted health organizations. They are for informational purposes only and should not replace professional medical advice."
    }
}

