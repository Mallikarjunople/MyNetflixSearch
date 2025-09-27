//
//  VideoDetailsDataService.swift
//  NetflixShowsDetails
//
//  Created by Mallikarjun Ople on 27/09/25.
//

import Foundation

final class VideoDetailsDataService {

    func buildDetailModalRequest(videoId: String) throws -> URLRequest {
        let url = URL(string: "https://web.prod.cloud.netflix.com/graphql")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(cookie, forHTTPHeaderField: "Cookie")
        let requestBody = getRequestBody(videoId: videoId)

        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(requestBody)

        return request
    }

    private func getRequestBody(videoId: String) -> DetailModalRequest {
        return DetailModalRequest(
            operationName: "DetailModal",
            variables: .init(
                opaqueImageFormat: "WEBP",
                transparentImageFormat: "WEBP",
                videoMerchEnabled: true,
                fetchPromoVideoOverride: false,
                hasPromoVideoOverride: false,
                promoVideoId: 0,
                videoMerchContext: "BROWSE",
                isLiveEpisodic: false,
                artworkContext: [:],
                textEvidenceUiContext: "ODP",
                unifiedEntityId: "Video:\(videoId)"
            ),
            extensions: .init(
                persistedQuery: .init(
                    id: "e0f86eeb-c2cd-4b7c-955f-5da5455124be",
                    version: 102
                )
            )
        )
    }

    var cookie: String {
        return "netflix-sans-normal-3-loaded=true; netflix-sans-bold-3-loaded=true; nfvdid=BQFmAAEBEMTQx_QAttLhIWbZum8kKjBgKahxflWMCbN6CGWnlxb7FgP1tFEf7kv28OfjnBfyxqjrnnLGizmkdT4UOz266lSLWwD7ff_S2QxzVpd4Yrwk3uvJQR9gwuvqwNS9CTflv4xllT5Hs2_el5FQVIGznE8i; profilesNewSession=0; flwssn=e19708e8-aeea-4493-807a-df0c38e8b92a; gsid=49f5bd3d-327c-4e9a-8bc4-30cfde0c341b; SecureNetflixId=v%3D3%26mac%3DAQEAEQABABQnq5ebRPspjDV9q4jGg0_hcW4483kbpQs.%26dt%3D1758914304998; NetflixId=v%3D3%26ct%3DBgjHlOvcAxL3Aogxxm0nIuJdEMeZENjnm7HDTIglrLylD2V8M32EQDWb3rfmHpx5HQWVsvy847biGYyUwn9meBHIVtED3Dg5v-r3SRoPs4JCT-T1x4bLyLdExdI2c72EIw64g-3Wo9Pmd5SwaFguSEPHkD3uB3NZaC89W1Lp5A1XrReT-g4F1E-0ud3VVyynyWX8KMX1EEHss3z_KC8o1MiePOJ25-fpndEqC7NGCRUGVHjnlau1xva6skcG6OELzkmtmmB1DbK_zmChdKBRzd4mlFVQr_7kHuHO-XLfQfxJ3DVIDD0O1chhyLLNNsaPLpfs57Xv90WlWTvFirapZEYergGcN_pLTU2lvR1_NbvsafqXT2Dn5H2L_3JjW2LBwrGN6JiCQ5jCNCRejRlFcQR4jLY66FmuLdnTnWlb8AsJtrVZtLjUHvBpej0pIe2LQXXMiwoqQTdoFsgn6xsTz7hnTI3-PoFCESShgM9RbfdARatTMP2aBmZxD1kSof__HRgGIg4KDAhqh9E5TqwU7L7wvg..%26pg%3DU3OYR6IUGREU3LUGIP6V22V5MQ%26ch%3DAQEAEAABABREjthBDoPFIwbaOcba7m6lz4cL5X_XQms.; OptanonConsent=isGpcEnabled=0&datestamp=Sat+Sep+27+2025+00%3A48%3A27+GMT%2B0530+(India+Standard+Time)&version=202508.1.0&browserGpcFlag=0&isIABGlobal=false&hosts=&consentId=9f1341d1-14c7-4ccf-8d55-128746d3d3da&interactionCount=0&isAnonUser=1&landingPath=NotLandingPage&groups=C0001%3A1%2CC0002%3A1%2CC0003%3A1%2CC0004%3A1&AwaitingReconsent=false"
    }
}
