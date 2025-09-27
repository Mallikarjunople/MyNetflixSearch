//
//  VideoDetailsViewModel.swift
//  NetflixShowsDetails
//
//  Created by Mallikarjun Ople on 27/09/25.
//

import SwiftUI

struct VideoMetadata: Identifiable {
    let id: Int
    let title: String?
    let description: String?
    let series: String?
    let season: Int?
    let totalSeasons: Int?
    let episode: Int?
    let releaseDate: String?
    let images: [URL]?
}

@MainActor
final class DetailViewModel: ObservableObject {
    @Published var metadata: VideoMetadata?
    @Published var isLoading = false
    @Published var lastError: String?
    var dataService = VideoDetailsDataService()

    func fetchMetadata(for videoIdOrTitle: String) async {
        lastError = nil
        isLoading = true
        defer { isLoading = false }

        do {
            let request = try dataService.buildDetailModalRequest(videoId: videoIdOrTitle)
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                lastError = "HTTP error"
                return
            }

            // Decode response
            do {
                let decoded = try JSONDecoder().decode(DetailModalResponse.self, from: data)
                if let entity = decoded.data?.unifiedEntities?.first {
                    metadata = entity.toVideoMetadata()
//                    print("Parsed metadata:", metadata)

                }
            } catch {
                print("Decode error:", error)
            }

        } catch {
            lastError = "Failed: \(error.localizedDescription)"
        }
    }
}
