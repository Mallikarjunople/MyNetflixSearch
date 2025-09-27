//
//  ContentView.swift
//  NetflixShowsDetails
//
//  Created by Mallikarjun Ople on 27/09/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var vm = DetailViewModel()
    @State private var query: String = ""

    var body: some View {
           NavigationView {
               VStack(spacing: 0) {

                   HStack {
                       Text("Netflix")
                           .font(.largeTitle)
                           .bold()
                           .foregroundColor(.red)
                           .padding([.top, .leading], 8)
                           .frame(alignment: .leading)

                   }


                   HStack {
                       TextField("Enter Video ID or Title", text: $query)
                           .textFieldStyle(.roundedBorder)
                           .disableAutocorrection(true)
                           .autocapitalization(.none)

                       Button("Fetch") {
                           Task { await vm.fetchMetadata(for: query) }
                       }
                       .buttonStyle(.borderedProminent)
                       .disabled(query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                   }
                   .padding()
                   .background(Color(.systemGray6))

                   Divider()

                   // Scrollable results below
                   ScrollView {
                       VStack(spacing: 16) {
                           if vm.isLoading {
                               ProgressView("Loading...")
                                   .padding()
                           }

                           if let error = vm.lastError {
                               Text(error)
                                   .foregroundColor(.red)
                                   .multilineTextAlignment(.center)
                                   .padding(.horizontal)
                           }

                           if let meta = vm.metadata {
                               VStack(alignment: .leading, spacing: 12) {
                                   if let url = meta.images?.first {
                                       AsyncImage(url: url) { image in
                                           image
                                               .resizable()
                                               .scaledToFit()
                                               .frame()
                                               .cornerRadius(8)
                                       } placeholder: {
                                           ProgressView()
                                       }
                                   }


                                   if let series = meta.series {
                                       Text("Series name: \(series)")
                                           .bold()
                                   }

                                   if let totalSeasons = meta.totalSeasons {
                                       Text("No. of Seasons: \(totalSeasons)")
                                           .fontWeight(.semibold)
                                   }


                                   if let season = meta.season {
                                       HStack {
                                           Text("Currently watching:")
                                               .bold()
                                           Text("S \(season) E \(meta.episode ?? 0)")
                                               .fontWeight(.semibold)
                                       }

                                   }
                                   if let releaseDate = meta.releaseDate {
                                       Text("Release Date: \(releaseDate)")
                                   }
                                   if let description = meta.description {
                                       Text(description)
                                           .font(.body)
                                   }
                               }
                               .padding()
                           }
                       }
                       .frame(maxWidth: .infinity, alignment: .top)
                   }
               }
           }
       }
}

// 70143830

#Preview {
    ContentView()
}
