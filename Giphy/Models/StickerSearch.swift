import Foundation

// MARK: - StickerSearch
struct StickerSearch: Codable, GifStickerCellConfigurable {
    var imageURL: String?
    
    var altText: String?
    
    var id: String?
    
    let data: [StickerDatum]?
    let meta: StickerMeta?
    let pagination: StickerPagination?
}
