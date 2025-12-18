//
//  MedicalInfoView.swift
//  MediMapApp
//

import SwiftUI

struct MedicalInfoView: View {
    @StateObject private var viewModel = MedicalInfoViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 10) {
                    Text("Medical Information")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(Color(hex: "#003265"))
                    
                    Text("Learn about common conditions and treatments")
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
                    TextField("Search conditions...", text: $viewModel.searchText)
                        .font(.system(size: 16, design: .rounded))
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Category filter
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        FilterChip(title: "All", isSelected: viewModel.selectedCategory == nil) {
                            viewModel.selectedCategory = nil
                        }
                        ForEach(viewModel.categories, id: \.self) { category in
                            FilterChip(title: category, isSelected: viewModel.selectedCategory == category) {
                                viewModel.selectedCategory = category
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 10)
                
                // Medical info list
                List {
                    ForEach(viewModel.filteredMedicalInfo) { info in
                        NavigationLink(destination: MedicalInfoDetailView(info: info)) {
                            MedicalInfoRow(info: info)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarHidden(true)
            .onAppear {
                viewModel.fetchMedicalInfo()
            }
        }
    }
}

struct MedicalInfoRow: View {
    let info: MedicalInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(info.title)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(Color(hex: "#003265"))
                
                Spacer()
                
                Text(info.category)
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color(hex: "#f65505"))
                    .cornerRadius(8)
            }
            
            Text(info.description)
                .font(.system(size: 14, weight: .regular, design: .rounded))
                .foregroundColor(.gray)
                .lineLimit(2)
        }
        .padding(.vertical, 8)
    }
}

struct MedicalInfoDetailView: View {
    let info: MedicalInfo
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                // Header
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(info.category)
                            .font(.system(size: 14, weight: .medium, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color(hex: "#f65505"))
                            .cornerRadius(8)
                        
                        Spacer()
                    }
                    
                    Text(info.title)
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(Color(hex: "#003265"))
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(15)
                
                // Description
                VStack(alignment: .leading, spacing: 10) {
                    Text("Description")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(Color(hex: "#003265"))
                    
                    Text(info.description)
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundColor(.primary)
                }
                
                // Symptoms
                VStack(alignment: .leading, spacing: 15) {
                    Text("Common Symptoms")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(Color(hex: "#003265"))
                    
                    ForEach(info.symptoms, id: \.self) { symptom in
                        HStack(spacing: 12) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color(hex: "#f65505"))
                            
                            Text(symptom)
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(15)
                
                // Treatments
                VStack(alignment: .leading, spacing: 15) {
                    Text("Recommended Treatments")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(Color(hex: "#003265"))
                    
                    ForEach(info.treatments, id: \.self) { treatment in
                        HStack(spacing: 12) {
                            Image(systemName: "pill.fill")
                                .foregroundColor(Color(hex: "#f65505"))
                            
                            Text(treatment)
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(15)
                
                // Medical Sources
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Image(systemName: "doc.text.fill")
                            .foregroundColor(Color(hex: "#f65505"))
                        Text("Medical Sources")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .foregroundColor(Color(hex: "#003265"))
                    }
                    
                    ForEach(info.sources) { source in
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
                                    .font(.system(size: 20))
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(source.name)
                                        .font(.system(size: 16, weight: .medium, design: .rounded))
                                        .foregroundColor(.primary)
                                    Text(source.organization)
                                        .font(.system(size: 13, weight: .regular, design: .rounded))
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "arrow.up.right.square")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
                // Disclaimer
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.red)
                        Text("Medical Disclaimer")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(.red)
                    }
                    
                    Text(info.disclaimer)
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.primary)
                    
                    Text("Never delay or disregard seeking professional medical advice from your doctor or qualified health provider because of something you have read in this app.")
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                }
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(15)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MedicalInfoView()
}

