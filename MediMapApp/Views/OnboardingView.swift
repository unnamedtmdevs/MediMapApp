//
//  OnboardingView.swift
//  MediMapApp
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("needsOnboarding") private var needsOnboarding: Bool = true
    @State private var currentPage = 0
    
    private let pages: [(title: String, description: String, icon: String)] = [
        ("Welcome to MostMap App", "Your personal health companion for symptom checking and finding nearby medical care", "heart.text.square.fill"),
        ("Check Symptoms", "Track your symptoms and get recommendations on when to seek medical attention", "list.clipboard"),
        ("Find Clinics", "Locate nearby clinics and hospitals with ratings, specialties, and contact information", "map.fill"),
        ("Medical Information", "Access a comprehensive database of medical conditions, symptoms, and treatments", "book.fill")
    ]

    var body: some View {
        ZStack {
            Color(hex: "#003265")
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Skip button
                HStack {
                    Spacer()
                    if currentPage < pages.count - 1 {
                        Button(action: {
                            self.needsOnboarding = false
                        }) {
                            Text("Skip")
                                .foregroundColor(.white)
                                .padding()
                        }
                    }
                }
                .padding(.top, 20)
                
                Spacer()
                
                // Content
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        VStack(spacing: 40) {
                            Image(systemName: pages[index].icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                                .foregroundColor(Color(hex: "#f65505"))
                            
                            VStack(spacing: 20) {
                                Text(pages[index].title)
                                    .font(.system(size: 32, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                
                                Text(pages[index].description)
                                    .font(.system(size: 18, weight: .regular, design: .rounded))
                                    .foregroundColor(.white.opacity(0.8))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 30)
                            }
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                
                Spacer()
                
                // Button
                Button(action: {
                    if currentPage < pages.count - 1 {
                        withAnimation {
                            currentPage += 1
                        }
                    } else {
                        self.needsOnboarding = false
                    }
                }) {
                    Text(currentPage < pages.count - 1 ? "Next" : "Get Started")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#f65505"))
                        .cornerRadius(15)
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    OnboardingView()
}

