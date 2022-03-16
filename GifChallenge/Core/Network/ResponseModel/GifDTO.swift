//
//  Models.swift
//  GifChallenge
//
//  Created by Mikalai on 10.03.2022.
//

import Foundation

// MARK: - GifModel
struct GifDTO: Decodable {
    let data: DataClass
    let meta: Meta
}

// MARK: - DataClass
struct DataClass: Codable {
    let type, id, url, slug, bitlyGIFURL, bitlyURL: String
    let embedURL, username, source, title, rating: String
    let contentURL, sourceTLD, sourcePostURL: String
    let isSticker: Int
    let importDatetime, trendingDatetime: String
    let images: Images
    let user: User

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
    }
}

// MARK: - Images
struct Images: Codable {
    let fixedWidthStill, previewGIF: TheFourWStill
    let fixedHeightDownsampled: FixedHeight
    let preview: DownsizedSmall
    let fixedHeightSmall: FixedHeight
    let downsized: TheFourWStill
    let fixedWidthDownsampled, fixedWidth: FixedHeight
    let downsizedStill, downsizedMedium: TheFourWStill
    let originalMp4: DownsizedSmall
    let downsizedLarge, previewWebp: TheFourWStill
    let original: FixedHeight
    let originalStill, fixedHeightSmallStill: TheFourWStill
    let fixedWidthSmall: FixedHeight
    let looping: Looping
    let downsizedSmall: DownsizedSmall
    let fixedWidthSmallStill, fixedHeightStill: TheFourWStill
    let fixedHeight: FixedHeight
    let the480WStill: TheFourWStill

    enum CodingKeys: String, CodingKey {
        case fixedWidthStill = "fixed_width_still"
        case previewGIF = "preview_gif"
        case fixedHeightDownsampled = "fixed_height_downsampled"
        case preview
        case fixedHeightSmall = "fixed_height_small"
        case downsized
        case fixedWidthDownsampled = "fixed_width_downsampled"
        case fixedWidth = "fixed_width"
        case downsizedStill = "downsized_still"
        case downsizedMedium = "downsized_medium"
        case originalMp4 = "original_mp4"
        case downsizedLarge = "downsized_large"
        case previewWebp = "preview_webp"
        case original
        case originalStill = "original_still"
        case fixedHeightSmallStill = "fixed_height_small_still"
        case fixedWidthSmall = "fixed_width_small"
        case looping
        case downsizedSmall = "downsized_small"
        case fixedWidthSmallStill = "fixed_width_small_still"
        case fixedHeightStill = "fixed_height_still"
        case fixedHeight = "fixed_height"
        case the480WStill = "480w_still"
    }
}

// MARK: - The480_WStill
struct TheFourWStill: Codable {
    let url: String
    let width, height: String
    let size: String?
}

// MARK: - DownsizedSmall
struct DownsizedSmall: Codable {
    let height: String
    let mp4: String
    let mp4Size, width: String

    enum CodingKeys: String, CodingKey {
        case height, mp4
        case mp4Size = "mp4_size"
        case width
    }
}

// MARK: - FixedHeight
struct FixedHeight: Codable {
    let height: String
    let mp4: String?
    let mp4Size: String?
    let size: String
    let url: String
    let webp: String
    let webpSize, width: String
    let frames, hash: String?

    enum CodingKeys: String, CodingKey {
        case height, mp4
        case mp4Size = "mp4_size"
        case size, url, webp
        case webpSize = "webp_size"
        case width, frames, hash
    }
}

// MARK: - Looping
struct Looping: Codable {
    let mp4: String
    let mp4Size: String

    enum CodingKeys: String, CodingKey {
        case mp4
        case mp4Size = "mp4_size"
    }
}

// MARK: - User
struct User: Codable {
    let avatarURL: String
    let bannerImage, bannerURL: String
    let profileURL: String
    let username, displayName, userDescription: String
    let isVerified: Bool
    let websiteURL, instagramURL: String

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case bannerImage = "banner_image"
        case bannerURL = "banner_url"
        case profileURL = "profile_url"
        case username
        case displayName = "display_name"
        case userDescription = "description"
        case isVerified = "is_verified"
        case websiteURL = "website_url"
        case instagramURL = "instagram_url"
    }
}

// MARK: - Meta
struct Meta: Codable {
    let msg: String
    let status: Int
    let responseID: String

    enum CodingKeys: String, CodingKey {
        case msg, status
        case responseID = "response_id"
    }
}
