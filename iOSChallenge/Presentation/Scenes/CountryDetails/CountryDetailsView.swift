//
//  CountryDetailsView.swift
//  iOSChallenge
//
//  Created by ahmed maher on 11/01/2025.
//

import SwiftUI

struct CountryDetailView: View {
    let country: Country

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text(country.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.top)

                // Capital Section
                SectionView(title: "Capital", content: country.capital ?? "Unknown", icon: "building.2.fill", iconColor: .blue)

                // Currency Section
                SectionView(title: "Currency", content: "\(country.currencies?.first?.name ?? "Unknown") (\(country.currencies?.first?.code ?? "N/A"))", icon: "dollarsign.circle.fill", iconColor: .green)

                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle(country.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
struct SectionView: View {
    let title: String
    let content: String
    let icon: String
    let iconColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)

            HStack {
                Image(systemName: icon)
                    .foregroundColor(iconColor)
                    .font(.title2)
                Text(content)
                    .font(.title3)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(10)
        }
        .padding(.bottom)
    }
}
