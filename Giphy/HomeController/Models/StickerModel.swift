//
//  StickerModel.swift
//  Giphy
//
//  Created by Fatya on 01.08.24.
//

// StickerModel.swift

import Foundation

// MARK: - StickerModel
struct StickerModel: Codable {
    let data: [StickerDatum]?
    let meta: StickerMeta?
    let pagination: StickerPagination?
}

// MARK: - StickerDatum
struct StickerDatum: Codable, GifStickerCellConfigurable {
    let type: StickerTypeEnum?
    let id: String?
    let url: String?
    let slug: String?
    let bitlyGIFURL: String?
    let bitlyURL: String?
    let embedURL: String?
    let username: String?
    let source: String?
    let title: String?
    let rating: StickerRating?
    let contentURL: String?
    let sourceTLD: String?
    let sourcePostURL: String?
    let isSticker: Int?
    let importDatetime: String?
    let trendingDatetime: String?
    let images: StickerImages?
    let user: StickerUser?
    let analyticsResponsePayload: String?
    let analytics: StickerAnalytics?
    let altText: String?

    var imageURL: String? {
        return images?.fixedHeight?.url
    }

    enum CodingKeys: String, CodingKey {
        case type, id, url, slug
        case bitlyGIFURL = "bitly_gif_url"
        case bitlyURL = "bitly_url"
        case embedURL = "embed_url"
        case username, source, title, rating
        case contentURL = "content_url"
        case sourceTLD = "source_tld"
        case sourcePostURL = "source_post_url"
        case isSticker = "is_sticker"
        case importDatetime = "import_datetime"
        case trendingDatetime = "trending_datetime"
        case images, user
        case analyticsResponsePayload = "analytics_response_payload"
        case analytics
        case altText = "alt_text"
    }
}

// MARK: - StickerAnalytics
struct StickerAnalytics: Codable {
    let onload: StickerOnclick?
    let onclick: StickerOnclick?
    let onsent: StickerOnclick?
}

// MARK: - StickerOnclick
struct StickerOnclick: Codable {
    let url: String?
}

// MARK: - StickerImages
struct StickerImages: Codable {
    let original: StickerFixedHeight?
    let downsized: Sticker480WStill?
    let downsizedLarge: Sticker480WStill?
    let downsizedMedium: Sticker480WStill?
    let downsizedSmall: Sticker4K?
    let downsizedStill: Sticker480WStill?
    let fixedHeight: StickerFixedHeight?
    let fixedHeightDownsampled: StickerFixedHeight?
    let fixedHeightSmall: StickerFixedHeight?
    let fixedHeightSmallStill: Sticker480WStill?
    let fixedHeightStill: Sticker480WStill?
    let fixedWidth: StickerFixedHeight?
    let fixedWidthDownsampled: StickerFixedHeight?
    let fixedWidthSmall: StickerFixedHeight?
    let fixedWidthSmallStill: Sticker480WStill?
    let fixedWidthStill: Sticker480WStill?
    let looping: StickerLooping?
    let originalStill: Sticker480WStill?
    let originalMp4: Sticker4K?
    let preview: Sticker4K?
    let previewGIF: Sticker480WStill?
    let previewWebp: Sticker480WStill?
    let hd: Sticker4K?
    let the480WStill: Sticker480WStill?
    let the4K: Sticker4K?

    enum CodingKeys: String, CodingKey {
        case original, downsized
        case downsizedLarge = "downsized_large"
        case downsizedMedium = "downsized_medium"
        case downsizedSmall = "downsized_small"
        case downsizedStill = "downsized_still"
        case fixedHeight = "fixed_height"
        case fixedHeightDownsampled = "fixed_height_downsampled"
        case fixedHeightSmall = "fixed_height_small"
        case fixedHeightSmallStill = "fixed_height_small_still"
        case fixedHeightStill = "fixed_height_still"
        case fixedWidth = "fixed_width"
        case fixedWidthDownsampled = "fixed_width_downsampled"
        case fixedWidthSmall = "fixed_width_small"
        case fixedWidthSmallStill = "fixed_width_small_still"
        case fixedWidthStill = "fixed_width_still"
        case looping
        case originalStill = "original_still"
        case originalMp4 = "original_mp4"
        case preview
        case previewGIF = "preview_gif"
        case previewWebp = "preview_webp"
        case the480WStill = "480w_still"
        case hd
        case the4K = "4k"
    }
}

// MARK: - Sticker480WStill
struct Sticker480WStill: Codable {
    let height: String?
    let width: String?
    let size: String?
    let url: String?
}

// MARK: - Sticker4K
struct Sticker4K: Codable {
    let height: String?
    let width: String?
    let mp4Size: String?
    let mp4: String?

    enum CodingKeys: String, CodingKey {
        case height, width
        case mp4Size = "mp4_size"
        case mp4
    }
}

// MARK: - StickerFixedHeight
struct StickerFixedHeight: Codable {
    let height: String?
    let width: String?
    let size: String?
    let url: String?
    let mp4Size: String?
    let mp4: String?
    let webpSize: String?
    let webp: String?
    let frames: String?
    let hash: String?

    enum CodingKeys: String, CodingKey {
        case height, width, size, url
        case mp4Size = "mp4_size"
        case mp4
        case webpSize = "webp_size"
        case webp, frames, hash
    }
}

// MARK: - StickerLooping
struct StickerLooping: Codable {
    let mp4Size: String?
    let mp4: String?

    enum CodingKeys: String, CodingKey {
        case mp4Size = "mp4_size"
        case mp4
    }
}

enum StickerRating: String, Codable {
    case g = "g"
    case pg = "pg"
}

enum StickerTypeEnum: String, Codable {
    case sticker = "sticker"
    case text = "text"
    case emoji = "emoji"
    case unknown

    init(from decoder: Decoder) throws {
        self = try StickerTypeEnum(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
    }
}

// MARK: - StickerUser
struct StickerUser: Codable {
    let avatarURL: String?
    let bannerImage: String?
    let bannerURL: String?
    let profileURL: String?
    let username: String?
    let displayName: String?
    let description: String?
    let instagramURL: String?
    let websiteURL: String?
    let isVerified: Bool?

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case bannerImage = "banner_image"
        case bannerURL = "banner_url"
        case profileURL = "profile_url"
        case username
        case displayName = "display_name"
        case description
        case instagramURL = "instagram_url"
        case websiteURL = "website_url"
        case isVerified = "is_verified"
    }
}

// MARK: - StickerMeta
struct StickerMeta: Codable {
    let status: Int?
    let msg: String?
    let responseID: String?

    enum CodingKeys: String, CodingKey {
        case status, msg
        case responseID = "response_id"
    }
}

// MARK: - StickerPagination
struct StickerPagination: Codable {
    let totalCount: Int?
    let count: Int?
    let offset: Int?

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case count, offset
    }
}
