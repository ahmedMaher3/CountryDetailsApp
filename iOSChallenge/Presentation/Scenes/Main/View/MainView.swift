//
//  MainView.swift
// iOS Chanllenge
//
//  Created by ahmed maher on 14/12/2024.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel: MainViewModel

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: SearchView(viewModel: viewModel)) {
                    Search()
                }
                List {
                    ForEach(viewModel.selectedCountries) { country in
                        NavigationLink(destination: CountryDetailView(country: country)) {
                            Text(country.name)
                                .font(.body)
                                .padding(.vertical, 10)
                        }
                    }
                    .onDelete(perform: deleteCountry)

                }
                .listStyle(PlainListStyle())

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationTitle("My Countries")
            .alert(isPresented: $viewModel.locationManager.showAlert) {
                     Alert(
                         title: Text("Location Access Denied"),
                         message: Text(viewModel.locationManager.alertMessage ?? ""),
                         primaryButton: .default(Text("Open Settings")) {
                             if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                                 UIApplication.shared.open(appSettings)
                             }
                         },
                         secondaryButton: .cancel()
                     )
                 }


        }
    }

    private func deleteCountry(at offsets: IndexSet) {
        viewModel.removeCountry(at: offsets)
    }
}



struct Search: View {
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            Text("Search countries...")
                .foregroundColor(.gray)
            Spacer()
        }
        .padding(10)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}


//#Preview {
//    MainView(viewModel: MainViewModel())
//}
