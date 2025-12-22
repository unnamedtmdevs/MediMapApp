//
//  SymptomCheckerView.swift
//  MediMapApp
//

import SwiftUI

struct SymptomCheckerView: View {
    @StateObject private var viewModel = SymptomCheckerViewModel()
    @State private var showRecommendation = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 10) {
                    Text("Symptom Checker")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(Color(hex: "#003265"))
                    
                    Text("Select your symptoms to get recommendations")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.white)
                
                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search symptoms...", text: $viewModel.searchText)
                        .font(.system(size: 16, design: .rounded))
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Severity filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        FilterChip(title: "All", isSelected: viewModel.filterBySeverity == nil) {
                            viewModel.filterBySeverity = nil
                        }
                        FilterChip(title: "Mild", isSelected: viewModel.filterBySeverity == .mild) {
                            viewModel.filterBySeverity = .mild
                        }
                        FilterChip(title: "Moderate", isSelected: viewModel.filterBySeverity == .moderate) {
                            viewModel.filterBySeverity = .moderate
                        }
                        FilterChip(title: "Severe", isSelected: viewModel.filterBySeverity == .severe) {
                            viewModel.filterBySeverity = .severe
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 10)
                
                // Symptoms list
                List {
                    ForEach(viewModel.filteredSymptoms) { symptom in
                        SymptomRow(
                            symptom: symptom,
                            isSelected: viewModel.selectedSymptoms.contains(symptom.id)
                        ) {
                            viewModel.toggleSymptom(symptom.id)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                
                // Bottom action bar
                if !viewModel.selectedSymptoms.isEmpty {
                    VStack(spacing: 15) {
                        HStack {
                            Text("\(viewModel.selectedSymptoms.count) symptom(s) selected")
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(Color(hex: "#003265"))
                            
                            Spacer()
                            
                            Button(action: {
                                viewModel.clearSelection()
                            }) {
                                Text("Clear")
                                    .font(.system(size: 16, weight: .medium, design: .rounded))
                                    .foregroundColor(Color(hex: "#f65505"))
                            }
                        }
                        
                        Button(action: {
                            showRecommendation = true
                        }) {
                            Text("Get Recommendation")
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(hex: "#f65505"))
                                .cornerRadius(15)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: -5)
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                viewModel.fetchSymptoms()
            }
            .sheet(isPresented: $showRecommendation) {
                RecommendationView(
                    selectedSymptoms: viewModel.selectedSymptomsDetails,
                    viewModel: viewModel
                )
            }
        }
    }
}

struct SymptomRow: View {
    let symptom: Symptom
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 15) {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isSelected ? Color(hex: "#f65505") : Color.gray)
                    .font(.system(size: 24))
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(symptom.name)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(Color(hex: "#003265"))
                    
                    if !symptom.description.isEmpty {
                        Text(symptom.description)
                            .font(.system(size: 14, weight: .regular, design: .rounded))
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                Text(symptom.severity.rawValue)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(hex: symptom.severity.color))
                    .cornerRadius(8)
            }
            .padding(.vertical, 10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundColor(isSelected ? .white : Color(hex: "#003265"))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color(hex: "#f65505") : Color(.systemGray6))
                .cornerRadius(20)
        }
    }
}

struct RecommendationView: View {
    @Environment(\.dismiss) var dismiss
    let selectedSymptoms: [Symptom]
    let viewModel: SymptomCheckerViewModel
    
    var recommendation: (text: String, severity: SymptomSeverity?) {
        viewModel.getSeverityRecommendation()
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Icon
                    Image(systemName: "heart.text.square.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(Color(hex: "#f65505"))
                        .padding(.top, 30)
                    
                    // Recommendation
                    VStack(spacing: 15) {
                        Text("Health Recommendation")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(Color(hex: "#003265"))
                        
                        Text(recommendation.text)
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(15)
                    }
                    .padding(.horizontal)
                
                    // Selected symptoms
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Selected Symptoms:")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .foregroundColor(Color(hex: "#003265"))
                        
                        ForEach(selectedSymptoms) { symptom in
                            HStack {
                                Circle()
                                    .fill(Color(hex: symptom.severity.color))
                                    .frame(width: 10, height: 10)
                                
                                Text(symptom.name)
                                    .font(.system(size: 16, weight: .regular, design: .rounded))
                                
                                Spacer()
                                
                                Text(symptom.severity.rawValue)
                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: .black.opacity(0.05), radius: 5)
                    .padding(.horizontal)
                    
                    // Medical Sources Section
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Image(systemName: "doc.text.fill")
                                .foregroundColor(Color(hex: "#f65505"))
                            Text("Medical Sources & References")
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .foregroundColor(Color(hex: "#003265"))
                        }
                        
                        Text(viewModel.getSourcesRelevantText())
                            .font(.system(size: 14, weight: .regular, design: .rounded))
                            .foregroundColor(.gray)
                            .padding(.bottom, 8)
                        
                        ForEach(viewModel.medicalSources) { source in
                            Button(action: {
                                if let url = URL(string: source.url) {
                                    #if canImport(UIKit)
                                    UIApplication.shared.open(url)
                                    #elseif canImport(AppKit)
                                    NSWorkspace.shared.open(url)
                                    #endif
                                }
                            }) {
                                HStack(spacing: 12) {
                                    Image(systemName: "link.circle.fill")
                                        .foregroundColor(Color(hex: "#f65505"))
                                        .font(.system(size: 18))
                                    
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text(source.name)
                                            .font(.system(size: 15, weight: .medium, design: .rounded))
                                            .foregroundColor(.primary)
                                        Text(source.organization)
                                            .font(.system(size: 12, weight: .regular, design: .rounded))
                                            .foregroundColor(.gray)
                                    }
                                    
                                    Spacer()
                                    
                                    Image(systemName: "arrow.up.right.square")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 16))
                                }
                                .padding(12)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(color: .black.opacity(0.05), radius: 5)
                    .padding(.horizontal)
                    
                    // Medical Disclaimer
                    VStack(spacing: 8) {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.red)
                            Text("Important Medical Disclaimer")
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                                .foregroundColor(.red)
                        }
                        
                        Text("This symptom checker is NOT a diagnostic tool and does not provide medical advice. It is for informational purposes only.")
                            .font(.system(size: 13, weight: .medium, design: .rounded))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                        
                        Text("Always consult with a qualified healthcare professional for proper medical evaluation, diagnosis and treatment. If you have a medical emergency, call emergency services immediately.")
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Done")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(hex: "#f65505"))
                            .cornerRadius(15)
                            .padding(.horizontal)
                    }
                    .padding(.bottom, 20)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 24))
                    }
                }
            }
        }
    }
}

#Preview {
    SymptomCheckerView()
}

