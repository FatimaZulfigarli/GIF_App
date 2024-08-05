////
////  EmojiModel.swift
////  Giphy
////
////  Created by Fatya on 05.08.24.
////
//
//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let emojiModel = try? JSONDecoder().decode(EmojiModel.self, from: jsonData)
//
////
////  EmojiModel.swift
////  Giphy
////
////  Created by Fatya on 05.08.24.
////
//
//
//
//import Foundation
//
//// MARK: - EmojiModel
//struct EmojiModel: Codable {
//    let data: [EmojiDatum]?
//    let meta: EmojiMeta?
//    let pagination: EmojiPagination?
//}
//
//// MARK: - EmojiDatum
//struct EmojiDatum: Codable, GifStickerCellConfigurable {
//    let type: EmojiTypeEnum?
//    let id: String?
//    let url: String?
//    let slug: String?
//    let bitlyGIFURL, bitlyURL, embedURL: String?
//    let username: String?
//    let source: String?
//    let title: String?
//    let rating: EmojiRating?
//    let contentURL: String?
//    let sourceTLD: String?
//    let sourcePostURL: String?
//    let isSticker: Int?
//    let importDatetime, trendingDatetime: String?
//    let images: EmojiImages?
//    let user: EmojiUser?
//    let analyticsResponsePayload: String?
//    let analytics: EmojiAnalytics?
//    let altText: String?
//    let emojiGroupID: Int?
//    let variation: EmojiVariation?
//    let variationCount: Int?
//
//    var imageURL: String? {
//        return images?.original?.url
//    }
//
//    enum CodingKeys: String, CodingKey {
//        case type, id, url, slug
//        case bitlyGIFURL = "bitly_gif_url"
//        case bitlyURL = "bitly_url"
//        case embedURL = "embed_url"
//        case username, source, title, rating
//        case contentURL = "content_url"
//        case sourceTLD = "source_tld"
//        case sourcePostURL = "source_post_url"
//        case isSticker = "is_sticker"
//        case importDatetime = "import_datetime"
//        case trendingDatetime = "trending_datetime"
//        case images, user
//        case analyticsResponsePayload = "analytics_response_payload"
//        case analytics
//        case altText = "alt_text"
//        case emojiGroupID = "emoji_group_id"
//        case variation
//        case variationCount = "variation_count"
//    }
//}
//
//// MARK: - EmojiAnalytics
//struct EmojiAnalytics: Codable {
//    let onload: EmojiOnclick?
//    let onclick: EmojiOnclick?
//    let onsent: EmojiOnclick?
//}
//
//// MARK: - EmojiOnclick
//struct EmojiOnclick: Codable {
//    let url: String?
//}
//
//// MARK: - EmojiImages
//struct EmojiImages: Codable {
//    let original: EmojiFixedHeight?
//    let downsized, downsizedLarge, downsizedMedium: Emoji480WStill?
//    let downsizedSmall: Emoji4K?
//    let downsizedStill: Emoji480WStill?
//    let fixedHeight, fixedHeightDownsampled, fixedHeightSmall: EmojiFixedHeight?
//    let fixedHeightSmallStill, fixedHeightStill: Emoji480WStill?
//    let fixedWidth, fixedWidthDownsampled, fixedWidthSmall: EmojiFixedHeight?
//    let fixedWidthSmallStill, fixedWidthStill: Emoji480WStill?
//    let looping: EmojiLooping?
//    let originalStill: Emoji480WStill?
//    let originalMp4, preview: Emoji4K?
//    let previewGIF, previewWebp: Emoji480WStill?
//    let hd: Emoji4K?
//    let the480WStill: Emoji480WStill?
//
//    enum CodingKeys: String, CodingKey {
//        case original, downsized
//        case downsizedLarge = "downsized_large"
//        case downsizedMedium = "downsized_medium"
//        case downsizedSmall = "downsized_small"
//        case downsizedStill = "downsized_still"
//        case fixedHeight = "fixed_height"
//        case fixedHeightDownsampled = "fixed_height_downsampled"
//        case fixedHeightSmall = "fixed_height_small"
//        case fixedHeightSmallStill = "fixed_height_small_still"
//        case fixedHeightStill = "fixed_height_still"
//        case fixedWidth = "fixed_width"
//        case fixedWidthDownsampled = "fixed_width_downsampled"
//        case fixedWidthSmall = "fixed_width_small"
//        case fixedWidthSmallStill = "fixed_width_small_still"
//        case fixedWidthStill = "fixed_width_still"
//        case looping
//        case originalStill = "original_still"
//        case originalMp4 = "original_mp4"
//        case preview
//        case previewGIF = "preview_gif"
//        case previewWebp = "preview_webp"
//        case hd
//        case the480WStill = "480w_still"
//    }
//}
//
//// MARK: - Emoji480WStill
//struct Emoji480WStill: Codable {
//    let height, width, size: String?
//    let url: String?
//}
//
//// MARK: - Emoji4K
//struct Emoji4K: Codable {
//    let height, width, mp4Size: String?
//    let mp4: String?
//
//    enum CodingKeys: String, CodingKey {
//        case height, width
//        case mp4Size = "mp4_size"
//        case mp4
//    }
//}
//
//// MARK: - EmojiFixedHeight
//struct EmojiFixedHeight: Codable {
//    let height, width, size: String?
//    let url: String?
//    let mp4Size: String?
//    let mp4: String?
//    let webpSize: String?
//    let webp: String?
//    let frames: String?
//    let hash: String?
//
//    enum CodingKeys: String, CodingKey {
//        case height, width, size, url
//        case mp4Size = "mp4_size"
//        case mp4
//        case webpSize = "webp_size"
//        case webp, frames, hash
//    }
//}
//
//// MARK: - EmojiLooping
//struct EmojiLooping: Codable {
//    let mp4Size: String?
//    let mp4: String?
//
//    enum CodingKeys: String, CodingKey {
//        case mp4Size = "mp4_size"
//        case mp4
//    }
//}
//
//enum EmojiRating: String, Codable {
//    case g = "g"
//    case pg = "pg"
//}
//
//enum EmojiTypeEnum: String, Codable {
//    case emoji = "emoji"
//    case text = "text"
//    case sticker = "sticker"
//    case unknown
//
//    init(from decoder: Decoder) throws {
//        self = try EmojiTypeEnum(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
//    }
//}
//
//// MARK: - EmojiUser
//struct EmojiUser: Codable {
//    let avatarURL: String?
//    let bannerImage: String?
//    let bannerURL: String?
//    let profileURL: String?
//    let username: String?
//    let displayName: String?
//    let description: String?
//    let instagramURL: String?
//    let websiteURL: String?
//    let isVerified: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case avatarURL = "avatar_url"
//        case bannerImage = "banner_image"
//        case bannerURL = "banner_url"
//        case profileURL = "profile_url"
//        case username
//        case displayName = "display_name"
//        case description
//        case instagramURL = "instagram_url"
//        case websiteURL = "website_url"
//        case isVerified = "is_verified"
//    }
//}
//
//// MARK: - EmojiMeta
//struct EmojiMeta: Codable {
//    let status: Int?
//    let msg: String?
//    let responseID: String?
//
//    enum CodingKeys: String, CodingKey {
//        case status, msg
//        case responseID = "response_id"
//    }
//}
//
//// MARK: - EmojiPagination
//struct EmojiPagination: Codable {
//    let totalCount: Int?
//    let count: Int?
//    let offset: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case totalCount = "total_count"
//        case count, offset
//    }
//}
//
//// MARK: - EmojiVariation
//struct EmojiVariation: Codable {
//    let id: Int?
//    let url: String?
//}

import Foundation

// MARK: - EmojiModel
struct EmojiModel: Codable {
    let data: [EmojiDatum]?
    let meta: EmojiMeta?
    let pagination: EmojiPagination?
}

// MARK: - EmojiDatum
struct EmojiDatum: Codable, GifStickerCellConfigurable {
    let type: EmojiTypeEnum?
    let id: String?
    let url: String?
    let slug: String?
    let bitlyGIFURL, bitlyURL, embedURL: String?
    let username: String?
    let source: String?
    let title: String?
    let rating: EmojiRating?
    let contentURL: String?
    let sourceTLD: String?
    let sourcePostURL: String?
    let isSticker: Int?
    let importDatetime, trendingDatetime: String?
    let images: EmojiImages?
    let user: EmojiUser?
    let analyticsResponsePayload: String?
    let analytics: EmojiAnalytics?
    let altText: String?
    let emojiGroupID: Int?
    let variation: EmojiVariation?
    let variationCount: Int?

    var imageURL: String? {
        return images?.original?.url
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
        case emojiGroupID = "emoji_group_id"
        case variation
        case variationCount = "variation_count"
    }
}

// MARK: - EmojiAnalytics
struct EmojiAnalytics: Codable {
    let onload: EmojiOnclick?
    let onclick: EmojiOnclick?
    let onsent: EmojiOnclick?
}

// MARK: - EmojiOnclick
struct EmojiOnclick: Codable {
    let url: String?
}

// MARK: - EmojiImages
struct EmojiImages: Codable {
    let original: EmojiFixedHeight?
    let downsized, downsizedLarge, downsizedMedium: Emoji480WStill?
    let downsizedSmall: Emoji4K?
    let downsizedStill: Emoji480WStill?
    let fixedHeight, fixedHeightDownsampled, fixedHeightSmall: EmojiFixedHeight?
    let fixedHeightSmallStill, fixedHeightStill: Emoji480WStill?
    let fixedWidth, fixedWidthDownsampled, fixedWidthSmall: EmojiFixedHeight?
    let fixedWidthSmallStill, fixedWidthStill: Emoji480WStill?
    let looping: EmojiLooping?
    let originalStill: Emoji480WStill?
    let originalMp4, preview: Emoji4K?
    let previewGIF, previewWebp: Emoji480WStill?
    let hd: Emoji4K?
    let the480WStill: Emoji480WStill?

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
        case hd
        case the480WStill = "480w_still"
    }
}

// MARK: - Emoji480WStill
struct Emoji480WStill: Codable {
    let height, width, size: String?
    let url: String?
}

// MARK: - Emoji4K
struct Emoji4K: Codable {
    let height, width, mp4Size: String?
    let mp4: String?

    enum CodingKeys: String, CodingKey {
        case height, width
        case mp4Size = "mp4_size"
        case mp4
    }
}

// MARK: - EmojiFixedHeight
struct EmojiFixedHeight: Codable {
    let height, width, size: String?
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

// MARK: - EmojiLooping
struct EmojiLooping: Codable {
    let mp4Size: String?
    let mp4: String?

    enum CodingKeys: String, CodingKey {
        case mp4Size = "mp4_size"
        case mp4
    }
}

enum EmojiRating: String, Codable {
    case g = "g"
    case pg = "pg"
}

enum EmojiTypeEnum: String, Codable {
    case emoji = "emoji"
    case text = "text"
    case sticker = "sticker"
    case unknown

    init(from decoder: Decoder) throws {
        self = try EmojiTypeEnum(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
    }
}

// MARK: - EmojiUser
struct EmojiUser: Codable {
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

// MARK: - EmojiMeta
struct EmojiMeta: Codable {
    let status: Int?
    let msg: String?
    let responseID: String?

    enum CodingKeys: String, CodingKey {
        case status, msg
        case responseID = "response_id"
    }
}

// MARK: - EmojiPagination
struct EmojiPagination: Codable {
    let totalCount: Int?
    let count: Int?
    let offset: Int?

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case count, offset
    }
}

// MARK: - EmojiVariation
struct EmojiVariation: Codable {
    let id: Int?
    let url: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let stringValue = try? container.decode(String.self) {
            // If it's a string, set default values
            self.id = nil
            self.url = stringValue
        } else {
            // If it's a dictionary, decode as normal
            let nestedContainer = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try nestedContainer.decodeIfPresent(Int.self, forKey: .id)
            self.url = try nestedContainer.decodeIfPresent(String.self, forKey: .url)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, url
    }
}
