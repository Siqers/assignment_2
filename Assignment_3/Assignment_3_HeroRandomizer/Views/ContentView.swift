import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HeroViewModel()

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                LinearGradient(
                    colors: [
                        Color(red: 0.16, green: 0.23, blue: 0.45),
                        Color(red: 0.08, green: 0.10, blue: 0.22),
                        Color(red: 0.03, green: 0.04, blue: 0.10)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                ScrollView {
                    LazyVStack(spacing: 18) {
                        if let errorMessage = viewModel.errorMessage {
                            ErrorBannerView(message: errorMessage)
                        }

                        if viewModel.isLoading && viewModel.hero == nil {
                            LoadingCardView()
                        }

                        if let hero = viewModel.hero {
                            HeroHeaderView(hero: hero, viewModel: viewModel)

                            SectionCard(title: "Powerstats") {
                                VStack(spacing: 14) {
                                    PowerStatRow(
                                        title: "Intelligence",
                                        value: viewModel.statText(hero.powerstats.intelligence),
                                        progress: viewModel.progressValue(for: hero.powerstats.intelligence)
                                    )

                                    PowerStatRow(
                                        title: "Strength",
                                        value: viewModel.statText(hero.powerstats.strength),
                                        progress: viewModel.progressValue(for: hero.powerstats.strength)
                                    )

                                    PowerStatRow(
                                        title: "Speed",
                                        value: viewModel.statText(hero.powerstats.speed),
                                        progress: viewModel.progressValue(for: hero.powerstats.speed)
                                    )

                                    PowerStatRow(
                                        title: "Durability",
                                        value: viewModel.statText(hero.powerstats.durability),
                                        progress: viewModel.progressValue(for: hero.powerstats.durability)
                                    )

                                    PowerStatRow(
                                        title: "Power",
                                        value: viewModel.statText(hero.powerstats.power),
                                        progress: viewModel.progressValue(for: hero.powerstats.power)
                                    )

                                    PowerStatRow(
                                        title: "Combat",
                                        value: viewModel.statText(hero.powerstats.combat),
                                        progress: viewModel.progressValue(for: hero.powerstats.combat)
                                    )
                                }
                            }

                            SectionCard(title: "Biography") {
                                VStack(spacing: 12) {
                                    DetailRow(title: "Full Name", value: viewModel.display(hero.biography.fullName))
                                    DetailRow(title: "Publisher", value: viewModel.display(hero.biography.publisher))
                                    DetailRow(title: "Alignment", value: viewModel.display(hero.biography.alignment).capitalized)
                                    DetailRow(title: "Place of Birth", value: viewModel.display(hero.biography.placeOfBirth))
                                    DetailRow(title: "First Appearance", value: viewModel.display(hero.biography.firstAppearance))
                                }
                            }

                            SectionCard(title: "Appearance") {
                                VStack(spacing: 12) {
                                    DetailRow(title: "Gender", value: viewModel.display(hero.appearance.gender))
                                    DetailRow(title: "Race", value: viewModel.display(hero.appearance.race))
                                    DetailRow(title: "Height", value: viewModel.display(list: hero.appearance.height))
                                    DetailRow(title: "Weight", value: viewModel.display(list: hero.appearance.weight))
                                    DetailRow(title: "Eye Color", value: viewModel.display(hero.appearance.eyeColor))
                                    DetailRow(title: "Hair Color", value: viewModel.display(hero.appearance.hairColor))
                                }
                            }

                            SectionCard(title: "Work & Connections") {
                                VStack(spacing: 12) {
                                    DetailRow(title: "Occupation", value: viewModel.display(hero.work.occupation))
                                    DetailRow(title: "Base", value: viewModel.display(hero.work.base))
                                    DetailRow(title: "Group", value: viewModel.display(hero.connections.groupAffiliation))
                                    DetailRow(title: "Relatives", value: viewModel.display(hero.connections.relatives))
                                }
                            }
                        }

                        Spacer(minLength: 110)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                }

                RandomizeButton(
                    isLoading: viewModel.isLoading,
                    action: {
                        Task {
                            await viewModel.fetchRandomHero()
                        }
                    }
                )
                .padding(.horizontal, 16)
                .padding(.bottom, 14)
            }
            .navigationTitle("HeroRandomizer")
            .task {
                if viewModel.hero == nil {
                    await viewModel.fetchRandomHero()
                }
            }
        }
    }
}

// MARK: - Header

struct HeroHeaderView: View {
    let hero: Hero
    let viewModel: HeroViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .fill(.ultraThinMaterial)

                AsyncImage(url: URL(string: hero.images.lg ?? "")) { phase in
                    switch phase {
                    case .empty:
                        ZStack {
                            RoundedRectangle(cornerRadius: 28, style: .continuous)
                                .fill(Color.white.opacity(0.08))

                            ProgressView()
                                .tint(.white)
                        }

                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()

                    case .failure:
                        ZStack {
                            RoundedRectangle(cornerRadius: 28, style: .continuous)
                                .fill(Color.white.opacity(0.08))

                            VStack(spacing: 10) {
                                Image(systemName: "photo")
                                    .font(.system(size: 42))
                                Text("Image unavailable")
                                    .font(.subheadline)
                            }
                            .foregroundStyle(.white.opacity(0.85))
                        }

                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(height: 330)
                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                .overlay(
                    LinearGradient(
                        colors: [.clear, .black.opacity(0.7)],
                        startPoint: .center,
                        endPoint: .bottom
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                )

                VStack(alignment: .leading, spacing: 8) {
                    Text(hero.name)
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)

                    HStack(spacing: 8) {
                        HeroTag(text: "#\(hero.id)")
                        HeroTag(text: viewModel.display(hero.biography.publisher))
                        HeroTag(text: viewModel.display(hero.biography.alignment).capitalized)
                    }
                }
                .padding(18)
            }
        }
    }
}

// MARK: - Reusable Views

struct SectionCard<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title3.bold())
                .foregroundStyle(.white)

            content
        }
        .padding(18)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(Color.white.opacity(0.12), lineWidth: 1)
        )
    }
}

struct DetailRow: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.65))

            Text(value)
                .font(.body.weight(.semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)

            Divider()
                .overlay(Color.white.opacity(0.15))
        }
    }
}

struct PowerStatRow: View {
    let title: String
    let value: String
    let progress: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white)

                Spacer()

                Text(value)
                    .font(.subheadline.bold())
                    .foregroundStyle(.white.opacity(0.9))
            }

            ProgressView(value: progress)
                .tint(.cyan)
                .scaleEffect(x: 1, y: 1.4, anchor: .center)
        }
    }
}

struct HeroTag: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Color.white.opacity(0.16))
            .clipShape(Capsule())
            .foregroundStyle(.white)
    }
}

struct ErrorBannerView: View {
    let message: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "exclamationmark.triangle.fill")
            Text(message)
                .font(.subheadline.weight(.semibold))
                .multilineTextAlignment(.leading)
        }
        .foregroundStyle(.white)
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.red.opacity(0.8), in: RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}

struct LoadingCardView: View {
    var body: some View {
        VStack(spacing: 14) {
            ProgressView()
                .tint(.white)
                .scaleEffect(1.2)

            Text("Loading random hero...")
                .font(.headline)
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(40)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
}

struct RandomizeButton: View {
    let isLoading: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Image(systemName: "shuffle")
                        .font(.headline)
                }

                Text(isLoading ? "Loading..." : "Get Random Hero")
                    .font(.headline)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(
                LinearGradient(
                    colors: [Color.purple, Color.blue],
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                in: RoundedRectangle(cornerRadius: 22, style: .continuous)
            )
            .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 6)
        }
        .disabled(isLoading)
        .opacity(isLoading ? 0.85 : 1)
    }
}

#Preview {
    ContentView()
}
