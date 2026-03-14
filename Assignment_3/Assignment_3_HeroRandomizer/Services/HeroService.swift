import Foundation

enum HeroServiceError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid request URL."
        case .invalidResponse:
            return "Server returned an unexpected response."
        case .decodingFailed:
            return "Failed to decode hero data."
        }
    }
}

struct HeroService {
    private let baseURL = "https://akabab.github.io/superhero-api/api/id/"

    func fetchHero(id: Int) async throws -> Hero {
        guard let url = URL(string: "\(baseURL)\(id).json") else {
            throw HeroServiceError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw HeroServiceError.invalidResponse
        }

        do {
            return try JSONDecoder().decode(Hero.self, from: data)
        } catch {
            throw HeroServiceError.decodingFailed
        }
    }
}
