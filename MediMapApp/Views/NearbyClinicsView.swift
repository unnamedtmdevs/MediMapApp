//
//  NearbyClinicsView.swift
//  MediMapApp
//

import SwiftUI

struct NearbyClinicsView: View {
    @StateObject private var viewModel = NearbyClinicsViewModel()
    @State private var selectedClinic: Clinic?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 10) {
                    Text("Medical Facilities")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(Color(hex: "#003265"))
                    
                    Text("Browse healthcare facilities and services")
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
                    TextField("Search facilities...", text: $viewModel.searchText)
                        .font(.system(size: 16, design: .rounded))
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Filters
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        FilterChip(title: viewModel.filterByOpen ? "Open Now ✓" : "Open Now", isSelected: viewModel.filterByOpen) {
                            viewModel.filterByOpen.toggle()
                        }
                        
                        FilterChip(title: "All Specialties", isSelected: viewModel.selectedSpecialty == nil) {
                            viewModel.selectedSpecialty = nil
                        }
                        
                        ForEach(viewModel.specialties, id: \.self) { specialty in
                            FilterChip(title: specialty, isSelected: viewModel.selectedSpecialty == specialty) {
                                viewModel.selectedSpecialty = specialty
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 10)
                
                // List View
                List {
                    ForEach(viewModel.filteredClinics) { clinic in
                        NavigationLink(destination: ClinicDetailView(clinic: clinic)) {
                            ClinicRow(clinic: clinic)
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarHidden(true)
            .onAppear {
                viewModel.fetchClinics()
            }
        }
    }
}

struct ClinicRow: View {
    let clinic: Clinic
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(clinic.name)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(Color(hex: "#003265"))
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 12))
                    Text(String(format: "%.1f", clinic.rating))
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundColor(.primary)
                }
            }
            
            Label(clinic.address, systemImage: "mappin.circle")
                .font(.system(size: 14, design: .rounded))
                .foregroundColor(.gray)
            
            HStack {
                Text(clinic.isOpen ? "Open Now" : "Closed")
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(clinic.isOpen ? Color.green : Color.red)
                    .cornerRadius(8)
                
                ForEach(clinic.specialties.prefix(2), id: \.self) { specialty in
                    Text(specialty)
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .foregroundColor(Color(hex: "#003265"))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
            }
        }
        .padding(.vertical, 8)
    }
}

struct ClinicDetailView: View {
    let clinic: Clinic
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                // Header
                HStack {
                    Image(systemName: "cross.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(Color(hex: "#f65505"))
                    
                    Spacer()
                    
                    HStack(spacing: 8) {
                        Image(systemName: clinic.isOpen ? "clock.fill" : "clock")
                        Text(clinic.isOpen ? "Open Now" : "Closed")
                    }
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(clinic.isOpen ? Color.green : Color.red)
                    .cornerRadius(20)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(15)
                
                VStack(alignment: .leading, spacing: 15) {
                    // Name and rating
                    HStack {
                        Text(clinic.name)
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(Color(hex: "#003265"))
                        
                        Spacer()
                        
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text(String(format: "%.1f", clinic.rating))
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                        }
                    }
                    
                    // Address
                    HStack(spacing: 12) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(Color(hex: "#f65505"))
                            .font(.system(size: 20))
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Address")
                                .font(.system(size: 12, weight: .medium, design: .rounded))
                                .foregroundColor(.gray)
                            Text(clinic.address)
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // Phone
                    HStack(spacing: 12) {
                        Image(systemName: "phone.circle.fill")
                            .foregroundColor(Color(hex: "#f65505"))
                            .font(.system(size: 20))
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Phone Number")
                                .font(.system(size: 12, weight: .medium, design: .rounded))
                                .foregroundColor(.gray)
                            Text(clinic.phoneNumber)
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                        }
                        
                        Spacer()
                        
                        Link(destination: URL(string: "tel:\(clinic.phoneNumber.filter { $0.isNumber })")!) {
                            Image(systemName: "phone.fill")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.green)
                                .clipShape(Circle())
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    // Specialties
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Specialties")
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .foregroundColor(Color(hex: "#003265"))
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                            ForEach(clinic.specialties, id: \.self) { specialty in
                                Text(specialty)
                                    .font(.system(size: 14, weight: .medium, design: .rounded))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(Color(hex: "#f65505"))
                                    .cornerRadius(10)
                            }
                        }
                    }
                    
                    // Info note
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(Color(hex: "#f65505"))
                            Text("Contact Information")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                        }
                        
                        Text("This information is provided for reference only. Always verify details directly with the medical facility before visiting.")
                            .font(.system(size: 14, weight: .regular, design: .rounded))
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    NearbyClinicsView()
}

