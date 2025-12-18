//
//  DisclaimerView.swift
//  MediMapApp
//

import SwiftUI

struct DisclaimerView: View {
    @AppStorage("hasAcceptedDisclaimer") private var hasAcceptedDisclaimer: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color(hex: "#003265")
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                // Icon
                Image(systemName: "exclamationmark.shield.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color(hex: "#f65505"))
                
                // Title
                Text("Medical Information Disclaimer")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                // Content
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        DisclaimerPoint(
                            icon: "stethoscope",
                            text: "This app provides general health information for educational purposes only. It is NOT a substitute for professional medical advice, diagnosis, or treatment."
                        )
                        
                        DisclaimerPoint(
                            icon: "doc.text.magnifyingglass",
                            text: "The information provided should NOT be used for diagnosing or treating health problems or diseases."
                        )
                        
                        DisclaimerPoint(
                            icon: "person.fill.questionmark",
                            text: "Always consult with a qualified healthcare provider for questions regarding any medical condition."
                        )
                        
                        DisclaimerPoint(
                            icon: "phone.fill.arrow.up.right",
                            text: "If you think you may have a medical emergency, call your doctor or emergency services immediately."
                        )
                        
                        DisclaimerPoint(
                            icon: "checkmark.shield.fill",
                            text: "All medical information in this app includes citations to reputable medical sources such as CDC, Mayo Clinic, NIH, and WHO."
                        )
                    }
                    .padding()
                }
                .frame(maxHeight: 400)
                .background(Color.white.opacity(0.1))
                .cornerRadius(20)
                .padding(.horizontal, 20)
                
                // Accept Button
                Button(action: {
                    hasAcceptedDisclaimer = true
                    dismiss()
                }) {
                    Text("I Understand and Accept")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "#f65505"))
                        .cornerRadius(15)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
            }
            .padding()
        }
        .interactiveDismissDisabled()
    }
}

struct DisclaimerPoint: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(Color(hex: "#f65505"))
                .frame(width: 30)
            
            Text(text)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(.white)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    DisclaimerView()
}

