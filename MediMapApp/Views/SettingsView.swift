//
//  SettingsView.swift
//  MediMapApp
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

struct SettingsView: View {
    @AppStorage("needsOnboarding") private var needsOnboarding: Bool = false
    @AppStorage("hasAcceptedDisclaimer") private var hasAcceptedDisclaimer: Bool = false
    @AppStorage("notificationsEnabled") private var notificationsEnabled: Bool = true
    @AppStorage("darkModeEnabled") private var darkModeEnabled: Bool = false
    @AppStorage("distanceUnit") private var distanceUnit: String = "km"
    @State private var showDisclaimer = false
    
    var body: some View {
        NavigationView {
            List {
                // App Info Section
                Section {
                    HStack {
                        Image(systemName: "heart.text.square.fill")
                            .font(.system(size: 50))
                            .foregroundColor(Color(hex: "#f65505"))
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("MostMap App")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(Color(hex: "#003265"))
                            
                            Text("Version 1.0.0")
                                .font(.system(size: 14, weight: .regular, design: .rounded))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 10)
                } header: {
                    Text("About")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                }
                
                // Preferences Section
                Section {
                    Toggle(isOn: $notificationsEnabled) {
                        HStack {
                            Image(systemName: "bell.fill")
                                .foregroundColor(Color(hex: "#f65505"))
                                .frame(width: 30)
                            Text("Notifications")
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                        }
                    }
                    .tint(Color(hex: "#f65505"))
                    
                    Toggle(isOn: $darkModeEnabled) {
                        HStack {
                            Image(systemName: "moon.fill")
                                .foregroundColor(Color(hex: "#f65505"))
                                .frame(width: 30)
                            Text("Dark Mode")
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                        }
                    }
                    .tint(Color(hex: "#f65505"))
                    
                    Picker(selection: $distanceUnit, label: HStack {
                        Image(systemName: "ruler.fill")
                            .foregroundColor(Color(hex: "#f65505"))
                            .frame(width: 30)
                        Text("Distance Unit")
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                    }) {
                        Text("Kilometers").tag("km")
                        Text("Miles").tag("mi")
                    }
                } header: {
                    Text("Preferences")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                }
                
                // Data & Privacy Section
                Section {
                    NavigationLink(destination: PrivacyPolicyView()) {
                        HStack {
                            Image(systemName: "lock.shield.fill")
                                .foregroundColor(Color(hex: "#f65505"))
                                .frame(width: 30)
                            Text("Privacy Policy")
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                        }
                    }
                    
                    NavigationLink(destination: TermsOfServiceView()) {
                        HStack {
                            Image(systemName: "doc.text.fill")
                                .foregroundColor(Color(hex: "#f65505"))
                                .frame(width: 30)
                            Text("Terms of Service")
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                        }
                    }
                } header: {
                    Text("Legal")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                }
                
                // Medical & Legal Section
                Section {
                    Button(action: {
                        showDisclaimer = true
                    }) {
                        HStack {
                            Image(systemName: "exclamationmark.shield.fill")
                                .foregroundColor(.red)
                                .frame(width: 30)
                            Text("Medical Disclaimer")
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                .foregroundColor(.primary)
                        }
                    }
                } header: {
                    Text("Important Information")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                }
                
                // Support Section
                Section {
                    Button(action: {
                        // Open email client or support page
                        if let url = URL(string: "mailto:support@medimap.com") {
                            #if canImport(UIKit)
                            UIApplication.shared.open(url)
                            #elseif canImport(AppKit)
                            NSWorkspace.shared.open(url)
                            #endif
                        }
                    }) {
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(Color(hex: "#f65505"))
                                .frame(width: 30)
                            Text("Contact Support")
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                .foregroundColor(.primary)
                        }
                    }
                    
                    NavigationLink(destination: FAQView()) {
                        HStack {
                            Image(systemName: "questionmark.circle.fill")
                                .foregroundColor(Color(hex: "#f65505"))
                                .frame(width: 30)
                            Text("FAQ")
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                        }
                    }
                    
                    Button(action: {
                        needsOnboarding = true
                    }) {
                        HStack {
                            Image(systemName: "arrow.counterclockwise.circle.fill")
                                .foregroundColor(Color(hex: "#f65505"))
                                .frame(width: 30)
                            Text("Show Onboarding")
                                .font(.system(size: 16, weight: .regular, design: .rounded))
                                .foregroundColor(.primary)
                        }
                    }
                } header: {
                    Text("Support")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                }
                
                // Credits Section
                Section {
                    VStack(alignment: .center, spacing: 10) {
                        Text("Made with ❤️ for better health")
                            .font(.system(size: 14, weight: .regular, design: .rounded))
                            .foregroundColor(.gray)
                        
                        Text("© 2025 MostMap App. All rights reserved.")
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $showDisclaimer) {
                DisclaimerView()
            }
        }
    }
}

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Privacy Policy")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(Color(hex: "#003265"))
                
                Text("Last updated: December 17, 2025")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(.gray)
                
                VStack(alignment: .leading, spacing: 15) {
                    SectionView(title: "Information We Collect", content: "MediMap collects minimal information necessary to provide our services, including location data (only when you use the clinic finder feature) and symptom data (stored locally on your device).")
                    
                    SectionView(title: "How We Use Your Information", content: "We use your information solely to provide and improve our services. Your health data never leaves your device unless you explicitly choose to share it.")
                    
                    SectionView(title: "Data Security", content: "We implement industry-standard security measures to protect your information. All data is encrypted and stored securely on your device.")
                    
                    SectionView(title: "Your Rights", content: "You have the right to access, modify, or delete your data at any time. You can do this through the app settings or by contacting our support team.")
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TermsOfServiceView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Terms of Service")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(Color(hex: "#003265"))
                
                Text("Last updated: December 17, 2025")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(.gray)
                
                VStack(alignment: .leading, spacing: 15) {
                    SectionView(title: "Acceptance of Terms", content: "By using MediMap, you agree to these terms of service. If you do not agree, please do not use the app.")
                    
                    SectionView(title: "Medical Disclaimer", content: "MediMap is NOT a substitute for professional medical advice, diagnosis, or treatment. Always seek the advice of your physician or other qualified health provider with any questions you may have regarding a medical condition.")
                    
                    SectionView(title: "Use of Service", content: "You agree to use MediMap only for lawful purposes and in accordance with these terms. You must not use the app in any way that could damage, disable, or impair the service.")
                    
                    SectionView(title: "Limitation of Liability", content: "MediMap and its developers are not liable for any direct, indirect, incidental, or consequential damages arising from your use of the app.")
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FAQView: View {
    var body: some View {
        List {
            FAQItem(
                question: "Is MediMap a replacement for seeing a doctor?",
                answer: "No. MediMap is an informational tool designed to help you understand symptoms and find healthcare facilities. It should never replace professional medical advice."
            )
            
            FAQItem(
                question: "How accurate is the symptom checker?",
                answer: "The symptom checker provides general guidance based on common medical knowledge. It's not a diagnostic tool and should not be used as such."
            )
            
            FAQItem(
                question: "Does MediMap share my health data?",
                answer: "No. All your health data is stored locally on your device and is never shared with third parties."
            )
            
            FAQItem(
                question: "How do I update clinic information?",
                answer: "Clinic information is regularly updated. If you notice incorrect information, please contact our support team."
            )
            
            FAQItem(
                question: "Can I use MediMap offline?",
                answer: "Some features like symptom checking and medical information work offline. However, the clinic finder requires an internet connection."
            )
        }
        .navigationTitle("FAQ")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct FAQItem: View {
    let question: String
    let answer: String
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(question)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(Color(hex: "#003265"))
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(Color(hex: "#f65505"))
                }
            }
            
            if isExpanded {
                Text(answer)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundColor(.gray)
                    .padding(.top, 5)
            }
        }
        .padding(.vertical, 8)
    }
}

struct SectionView: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 18, weight: .semibold, design: .rounded))
                .foregroundColor(Color(hex: "#003265"))
            
            Text(content)
                .font(.system(size: 14, weight: .regular, design: .rounded))
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    SettingsView()
}

