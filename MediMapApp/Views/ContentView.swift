//
//  ContentView.swift
//  MediMapApp
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasAcceptedDisclaimer") private var hasAcceptedDisclaimer: Bool = false
    @State private var showDisclaimer = false
    
    var body: some View {
        TabView {
            SymptomCheckerView()
                .tabItem {
                    Label("Symptoms", systemImage: "heart.text.square")
                }
            
            MedicalInfoView()
                .tabItem {
                    Label("Info", systemImage: "book")
                }
            
            NearbyClinicsView()
                .tabItem {
                    Label("Facilities", systemImage: "building.2")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .accentColor(Color(hex: "#f65505"))
        .onAppear {
            self.setupAppearance()
            if !hasAcceptedDisclaimer {
                showDisclaimer = true
            }
        }
        .sheet(isPresented: $showDisclaimer) {
            DisclaimerView()
        }
    }
    
    private func setupAppearance() {
        #if canImport(UIKit)
        UITabBar.appearance().backgroundColor = UIColor(hex: "#003265")
        UITabBar.appearance().unselectedItemTintColor = UIColor.white.withAlphaComponent(0.6)
        #endif
    }
}

#Preview {
    ContentView()
}

