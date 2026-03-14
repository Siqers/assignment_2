import Foundation

@MainActor
final class HeroViewModel: ObservableObject {
    @Published private(set) var hero: Hero?
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?

    private let service: HeroService

    init(service: HeroService = HeroService()) {
        self.service = service
    }

    func fetchRandomHero() async {
        var randomID: Int

        repeat {
            randomID = Int.random(in: 1...731)
        } while randomID == hero?.id

        await fetchHero(id: randomID)
    }

    func fetchHero(id: Int) async {
        isLoading = true
        errorMessage = nil

        do {
            let fetchedHero = try await service.fetchHero(id: id)
            hero = fetchedHero
        } catch let error as HeroServiceError {
            errorMessage = error.localizedDescription
        } catch {
            errorMessage = "Something went wrong. Please try again."
        }

        isLoading = false
    }

    func display(_ value: String?) -> String {
        sanitized(value) ?? "Unknown"
    }

    func display(list: [String]?) -> String {
        let values = (list ?? []).compactMap { sanitized($0) }
        return values.isEmpty ? "Unknown" : values.joined(separator: " / ")
    }

    func progressValue(for stat: Int?) -> Double {
        Double(clampedStat(stat)) / 100.0
    }

    func statText(_ stat: Int?) -> String {
        "\(clampedStat(stat))"
    }

    private func clampedStat(_ stat: Int?) -> Int {
        max(0, min(100, stat ?? 0))
    }

    private func sanitized(_ value: String?) -> String? {
        guard let value else { return nil }

        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmed.isEmpty,
              trimmed != "-",
              trimmed.lowercased() != "null" else {
            return nil
        }

        return trimmed
    }
}
