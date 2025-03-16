//
//  SearchView.swift
//  iOSChallenge
//
//  Created by ahmed maher on 11/01/2025.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var searchText = ""

    var body: some View {
        VStack {
            SearchBar(text: $searchText)

            List(viewModel.filteredCountries(searchText: searchText)) { country in
                HStack {
                    VStack(alignment: .leading) {
                        Text(country.name)
                            .font(.headline)
                        Text("Capital: \(country.capital ?? "Unknown")")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("Currency: \(country.currencies?.first?.code ?? "Unknown")")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    if !viewModel.selectedCountries.contains(where: { $0.name == country.name }) {
                        Button(action: {
                            viewModel.addCountry(country)
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                                .font(.title2)
                        }
                        .disabled(viewModel.selectedCountries.count >= 5)
                    } else {
                        Text("Added")
                            .padding(6)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(8)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.vertical, 4)
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle("Search Countries")
    }
}

