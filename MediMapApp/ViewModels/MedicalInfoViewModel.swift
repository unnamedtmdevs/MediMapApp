//
//  MedicalInfoViewModel.swift
//  MediMapApp
//

import Foundation
import Combine

class MedicalInfoViewModel: ObservableObject {
    @Published var medicalInfo: [MedicalInfo] = []
    @Published var searchText: String = ""
    @Published var selectedCategory: String?
    
    private let dataService = DataService.shared
    
    var categories: [String] {
        Array(Set(medicalInfo.map { $0.category })).sorted()
    }
    
    var filteredMedicalInfo: [MedicalInfo] {
        medicalInfo.filter { info in
            let matchesSearch = searchText.isEmpty ||
                info.title.localizedCaseInsensitiveContains(searchText) ||
                info.description.localizedCaseInsensitiveContains(searchText)
            let matchesCategory = selectedCategory == nil || info.category == selectedCategory
            return matchesSearch && matchesCategory
        }
    }
    
    func fetchMedicalInfo() {
        medicalInfo = dataService.fetchMedicalInfo()
    }
    
    func clearFilters() {
        searchText = ""
        selectedCategory = nil
    }
}

