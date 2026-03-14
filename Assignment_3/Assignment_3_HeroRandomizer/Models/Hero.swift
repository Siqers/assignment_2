import Foundation

struct Hero: Codable, Identifiable {
    let id: Int
    let name: String
    let slug: String?
    let powerstats: Powerstats
    let appearance: Appearance
    let biography: Biography
    let work: Work
    let connections: Connections
    let images: HeroImages
}

struct Powerstats: Codable {
    let intelligence: Int?
    let strength: Int?
    let speed: Int?
    let durability: Int?
    let power: Int?
    let combat: Int?
}

struct Appearance: Codable {
    let gender: String?
    let race: String?
    let height: [String]?
    let weight: [String]?
    let eyeColor: String?
    let hairColor: String?

    enum CodingKeys: String, CodingKey {
        case gender
        case race
        case height
        case weight
        case eyeColor = "eyeColor"
        case hairColor = "hairColor"
    }
}

struct Biography: Codable {
    let fullName: String?
    let alterEgos: String?
    let aliases: [String]?
    let placeOfBirth: String?
    let firstAppearance: String?
    let publisher: String?
    let alignment: String?

    enum CodingKeys: String, CodingKey {
        case fullName = "fullName"
        case alterEgos = "alterEgos"
        case aliases
        case placeOfBirth = "placeOfBirth"
        case firstAppearance = "firstAppearance"
        case publisher
        case alignment
    }
}

struct Work: Codable {
    let occupation: String?
    let base: String?
}

struct Connections: Codable {
    let groupAffiliation: String?
    let relatives: String?

    enum CodingKeys: String, CodingKey {
        case groupAffiliation = "groupAffiliation"
        case relatives
    }
}

struct HeroImages: Codable {
    let xs: String?
    let sm: String?
    let md: String?
    let lg: String?
}
