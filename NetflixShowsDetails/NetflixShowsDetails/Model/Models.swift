//
//  Models.swift
//  NetflixShowsDetails
//
//  Created by Mallikarjun Ople on 27/09/25.
//

import Foundation

// MARK: - Root Request
struct DetailModalRequest: Codable {
    let operationName: String
    let variables: Variables
    let extensions: Extensions

    struct Variables: Codable {
        let opaqueImageFormat: String
        let transparentImageFormat: String
        let videoMerchEnabled: Bool
        let fetchPromoVideoOverride: Bool
        let hasPromoVideoOverride: Bool
        let promoVideoId: Int
        let videoMerchContext: String
        let isLiveEpisodic: Bool
        let artworkContext: [String: String]
        let textEvidenceUiContext: String
        let unifiedEntityId: String
    }

    struct Extensions: Codable {
        let persistedQuery: PersistedQuery

        struct PersistedQuery: Codable {
            let id: String
            let version: Int
        }
    }
}

// MARK: - Reponse models
struct DetailModalResponse: Codable {
    let data: UnifiedEntitiesData?
}

struct UnifiedEntitiesData: Codable {
    let unifiedEntities: [UnifiedEntity]?
}

// Unified entity = Show/Movie/Episode
struct UnifiedEntity: Codable {
    let videoId: Int
    let title: String?
    let isAvailable: Bool?
    let broadcastInfo: BroadcastInfo?
    let contextualSynopsis: Synopsis?
    let synopsis: Synopsis?
    let boxart: ImageAsset?
    let boxartHighRes: ImageAsset?
    let storyArt: ImageAsset?
    let titleLogoBranded: ImageAsset?
    let titleLogoUnbranded: ImageAsset?
    let currentEpisode: Episode?
    let seasons: SeasonsConnection?

    func toVideoMetadata() -> VideoMetadata {
        let images = [boxart?.url, boxartHighRes?.url, storyArt?.url, titleLogoBranded?.url, titleLogoUnbranded?.url]
            .compactMap { $0 }
            .compactMap { URL(string: $0) }

        return VideoMetadata(
            id: videoId,
            title: title,
            description: contextualSynopsis?.text ?? synopsis?.text,
            series: title,
            season: currentEpisode?.parentSeason?.number,
            totalSeasons: seasons?.totalCount ?? 0,
            episode: currentEpisode?.number,
            releaseDate: broadcastInfo?.releaseDate,
            images: images
        )
    }
}

struct BroadcastInfo: Codable {
    let distributorName: String?
    let releaseDate: String?
}

struct Synopsis: Codable {
    let text: String?
}

struct ImageAsset: Codable {
    let url: String
}

struct Episode: Codable {
    let videoId: Int
    let number: Int?
    let title: String?
    let parentSeason: Season?
    let contextualSynopsis: Synopsis?
}

struct Season: Codable {
    let number: Int?
    let title: String?
    let episodes: EpisodesConnection?
}

struct EpisodesConnection: Codable {
    let totalCount: Int
}

struct SeasonsConnection: Codable {
    let totalCount: Int
}


