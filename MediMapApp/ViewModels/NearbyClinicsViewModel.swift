//
//  NearbyClinicsViewModel.swift
//  MediMapApp
//

import Foundation
import Combine

class NearbyClinicsViewModel: ObservableObject {
    @Published var clinics: [Clinic] = []
    @Published var searchText: String = ""
    @Published var filterByOpen: Bool = false
    @Published var selectedSpecialty: String?
    
    private let dataService = DataService.shared
    private var cancellables = Set<AnyCancellable>()
    
    var specialties: [String] {
        Array(Set(clinics.flatMap { $0.specialties })).sorted()
    }
    
    var filteredClinics: [Clinic] {
        clinics.filter { clinic in
            let matchesSearch = searchText.isEmpty ||
                clinic.name.localizedCaseInsensitiveContains(searchText) ||
                clinic.address.localizedCaseInsensitiveContains(searchText)
            let matchesOpen = !filterByOpen || clinic.isOpen
            let matchesSpecialty = selectedSpecialty == nil || clinic.specialties.contains(selectedSpecialty!)
            return matchesSearch && matchesOpen && matchesSpecialty
        }.sorted { clinic1, clinic2 in
            // Sort by rating
            return clinic1.rating > clinic2.rating
        }
    }
    
    func fetchClinics() {
        clinics = dataService.fetchClinics()
    }
    
    func clearFilters() {
        searchText = ""
        filterByOpen = false
        selectedSpecialty = nil
    }
}

