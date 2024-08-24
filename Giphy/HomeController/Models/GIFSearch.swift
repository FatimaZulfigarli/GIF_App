// MARK: - GIFSearch
struct GIFSearch: Codable {
    let data: [GIFDatum]?
    let meta: GIFMeta?
    let pagination: GIFPagination?
}

// MARK: - GIFDatum
struct GIFDatum: Codable, GifStickerCellConfigurable {
    var imageURL: String? {
        return images?.fixedHeight?.url
    }
    
    var altText: String?
    var id: String?
    
    let type: GIFTypeEnum?
    let url: String?
    let slug: String?
    let bitlyGIFURL, bitlyURL: String?
    let embedURL: String?
    let username: String?
    let source: String?
    let title: String?
    let rating: GIFRating? // Changed from Rating to GIFRating
    let contentURL, sourceTLD: String?
    let sourcePostURL: String?
    let isSticker: Int?
    let importDatetime, trendingDatetime: String?
    let images: GIFImages?
    let user: GIFUser?
    let analyticsResponsePayload: String?
    let analytics: GIFAnalytics?
    
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

// MARK: - GIFAnalytics
struct GIFAnalytics: Codable {
    let onload, onclick, onsent: GIFOnclick?
}

// MARK: - GIFOnclick
struct GIFOnclick: Codable {
    let url: String?
}

// MARK: - GIFImages
struct GIFImages: Codable {
    let original: GIFFixedHeight?
    let downsized, downsizedLarge, downsizedMedium: GIFThe480_WStill?
    let downsizedSmall: GIFDownsizedSmall?
    let downsizedStill: GIFThe480_WStill?
    let fixedHeight, fixedHeightDownsampled, fixedHeightSmall: GIFFixedHeight?
    let fixedHeightSmallStill, fixedHeightStill: GIFThe480_WStill?
    let fixedWidth, fixedWidthDownsampled, fixedWidthSmall: GIFFixedHeight?
    let fixedWidthSmallStill, fixedWidthStill: GIFThe480_WStill?
    let looping: GIFLooping?
    let originalStill: GIFThe480_WStill?
    let originalMp4, preview: GIFDownsizedSmall?
    let previewGIF, previewWebp, the480WStill: GIFThe480_WStill?
    let hd: GIFDownsizedSmall?

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
    }
}

// MARK: - GIFThe480_WStill
struct GIFThe480_WStill: Codable {
    let height, width, size: String?
    let url: String?
}

// MARK: - GIFDownsizedSmall
struct GIFDownsizedSmall: Codable {
    let height, width, mp4Size: String?
    let mp4: String?

    enum CodingKeys: String, CodingKey {
        case height, width
        case mp4Size = "mp4_size"
        case mp4
    }
}

// MARK: - GIFFixedHeight
struct GIFFixedHeight: Codable {
    let height, width, size: String?
    let url: String?
    let mp4Size: String?
    let mp4: String?
    let webpSize: String?
    let webp: String?
    let frames, hash: String?

    enum CodingKeys: String, CodingKey {
        case height, width, size, url
        case mp4Size = "mp4_size"
        case mp4
        case webpSize = "webp_size"
        case webp, frames, hash
    }
}

// MARK: - GIFLooping
struct GIFLooping: Codable {
    let mp4Size: String?
    let mp4: String?

    enum CodingKeys: String, CodingKey {
        case mp4Size = "mp4_size"
        case mp4
    }
}

// MARK: - GIFUser
struct GIFUser: Codable {
    let avatarURL: String?
    let bannerImage, bannerURL: String?
    let profileURL: String?
    let username: String?
    let displayName, description: String?
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

// MARK: - GIFMeta
struct GIFMeta: Codable {
    let status: Int?
    let msg, responseID: String?

    enum CodingKeys: String, CodingKey {
        case status, msg
        case responseID = "response_id"
    }
}

// MARK: - GIFPagination
struct GIFPagination: Codable {
    let totalCount, count, offset: Int?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case count, offset
    }
}

// MARK: - GIFTypeEnum
enum GIFTypeEnum: String, Codable {
    case gif = "gif"
}

// MARK: - GIFRating
// MARK: - GIFRating
enum GIFRating: String, Codable {
    case g = "g"
    case pg = "pg"
    case pg13 = "pg-13"
    case unknown // Added an unknown case

    // Custom initializer to handle invalid values
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = GIFRating(rawValue: rawValue) ?? .unknown
    }
}

