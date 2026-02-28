import SwiftUI

// MARK: - Data Model

struct FavoriteItem: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let subtitle: String
    let isEmoji: Bool
}

// MARK: - Row View

struct FavoriteRowView: View {
    let item: FavoriteItem

    var body: some View {
        HStack(spacing: 14) {
            if item.isEmoji {
                Text(item.imageName)
                    .font(.system(size: 38))
                    .frame(width: 54, height: 54)
                    .background(Color.white.opacity(0.05))
                    .clipShape(Circle())
            } else {
                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .padding(8)
                    .frame(width: 54, height: 54)
                    .background(Color(red: 0.22, green: 0.22, blue: 0.25))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.08), lineWidth: 1)
                    )
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                Text(item.subtitle)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(Color(red: 0.13, green: 0.13, blue: 0.15))
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color.white.opacity(0.07), lineWidth: 1)
        )
        .padding(.horizontal, 12)
        .padding(.vertical, 4)
    }
}

// MARK: - Section Header View

struct SectionHeaderView: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.system(size: 13, weight: .bold))
            .foregroundColor(.gray)
            .textCase(.uppercase)
            .padding(.horizontal, 16)
            .padding(.top, 10)
    }
}

// MARK: - Content View

struct ContentView: View {

    // MARK: Leagues
    @State private var leagues: [FavoriteItem] = [
        FavoriteItem(imageName: "england",    title: "Premier League",   subtitle: "England • Founded in 1992",      isEmoji: false),
        FavoriteItem(imageName: "spain",      title: "La Liga",          subtitle: "Spain • Founded in 1929",        isEmoji: false),
        FavoriteItem(imageName: "germany",    title: "Bundesliga",       subtitle: "Germany • Founded in 1963",      isEmoji: false),
        FavoriteItem(imageName: "italy",      title: "Serie A",          subtitle: "Italy • Founded in 1898",        isEmoji: false),
        FavoriteItem(imageName: "france",     title: "Ligue 1",          subtitle: "France • Founded in 1932",       isEmoji: false),
        FavoriteItem(imageName: "portugal",   title: "Primeira Liga",    subtitle: "Portugal • Founded in 1934",     isEmoji: false),
        FavoriteItem(imageName: "netherland", title: "Eredivisie",       subtitle: "Netherlands • Founded in 1956",  isEmoji: false),
        FavoriteItem(imageName: "champions",  title: "Champions League", subtitle: "UEFA • Founded in 1955",         isEmoji: false),
        FavoriteItem(imageName: "europe",     title: "Europa League",    subtitle: "UEFA • Founded in 1971",         isEmoji: false),
        FavoriteItem(imageName: "USA",        title: "MLS",              subtitle: "USA • Founded in 1993",          isEmoji: false)
    ]

    // MARK: Clubs
    @State private var clubs: [FavoriteItem] = [
        FavoriteItem(imageName: "man_city",    title: "Manchester City",   subtitle: "England • Etihad Stadium",        isEmoji: false),
        FavoriteItem(imageName: "Arsenal",     title: "Arsenal",           subtitle: "England • Emirates Stadium",      isEmoji: false),
        FavoriteItem(imageName: "Real_Madrid", title: "Real Madrid",       subtitle: "Spain • Santiago Bernabeu",       isEmoji: false),
        FavoriteItem(imageName: "Barca",       title: "Barcelona",         subtitle: "Spain • Camp Nou",                isEmoji: false),
        FavoriteItem(imageName: "Bayern",      title: "Bayern Munich",     subtitle: "Germany • Allianz Arena",         isEmoji: false),
        FavoriteItem(imageName: "Borusia",     title: "Borussia Dortmund", subtitle: "Germany • Signal Iduna Park",     isEmoji: false),
        FavoriteItem(imageName: "Inter",       title: "Inter Milan",       subtitle: "Italy • San Siro",                isEmoji: false),
        FavoriteItem(imageName: "PSG",         title: "PSG",               subtitle: "France • Parc des Princes",       isEmoji: false),
        FavoriteItem(imageName: "Benfica",     title: "Benfica",           subtitle: "Portugal • Estadio da Luz",       isEmoji: false),
        FavoriteItem(imageName: "Ajax",        title: "Ajax",              subtitle: "Netherlands • Johan Cruyff Arena", isEmoji: false)
    ]

    // MARK: Players
    @State private var players: [FavoriteItem] = [
        FavoriteItem(imageName: "🇦🇷", title: "Lionel Messi",       subtitle: "Argentina • Forward",    isEmoji: true),
        FavoriteItem(imageName: "🇵🇹", title: "Cristiano Ronaldo",  subtitle: "Portugal • Forward",     isEmoji: true),
        FavoriteItem(imageName: "🇫🇷", title: "Kylian Mbappe",      subtitle: "France • Forward",       isEmoji: true),
        FavoriteItem(imageName: "🇳🇴", title: "Erling Haaland",     subtitle: "Norway • Forward",       isEmoji: true),
        FavoriteItem(imageName: "🇧🇷", title: "Vinicius Junior",    subtitle: "Brazil • Winger",        isEmoji: true),
        FavoriteItem(imageName: "🇪🇸", title: "Pedri",              subtitle: "Spain • Midfielder",     isEmoji: true),
        FavoriteItem(imageName: "🇧🇪", title: "Kevin De Bruyne",    subtitle: "Belgium • Midfielder",   isEmoji: true),
        FavoriteItem(imageName: "🇪🇬", title: "Mohamed Salah",      subtitle: "Egypt • Winger",         isEmoji: true),
        FavoriteItem(imageName: "🇪🇸", title: "Rodri",              subtitle: "Spain • Midfielder",     isEmoji: true),
        FavoriteItem(imageName: "🇸🇳", title: "Sadio Mane",         subtitle: "Senegal • Forward",      isEmoji: true)
    ]

    // MARK: National Teams
    @State private var nationalTeams: [FavoriteItem] = [
        FavoriteItem(imageName: "🇦🇷", title: "Argentina",    subtitle: "World Champion 2022",            isEmoji: true),
        FavoriteItem(imageName: "🇫🇷", title: "France",       subtitle: "World Champion 2018",            isEmoji: true),
        FavoriteItem(imageName: "🇧🇷", title: "Brazil",       subtitle: "5x World Champion",              isEmoji: true),
        FavoriteItem(imageName: "🏴󠁧󠁢󠁥󠁮󠁧󠁿", title: "England",    subtitle: "World Champion 1966",            isEmoji: true),
        FavoriteItem(imageName: "🇪🇸", title: "Spain",        subtitle: "World Champion 2010",            isEmoji: true),
        FavoriteItem(imageName: "🇩🇪", title: "Germany",      subtitle: "4x World Champion",              isEmoji: true),
        FavoriteItem(imageName: "🇵🇹", title: "Portugal",     subtitle: "Euro Champion 2016",             isEmoji: true),
        FavoriteItem(imageName: "🇳🇱", title: "Netherlands",  subtitle: "World Cup Finalist 3x",          isEmoji: true),
        FavoriteItem(imageName: "🇮🇹", title: "Italy",        subtitle: "World Champion 2006",            isEmoji: true),
        FavoriteItem(imageName: "🇧🇪", title: "Belgium",      subtitle: "#1 FIFA Ranking (2018)",         isEmoji: true)
    ]

    // MARK: Body
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.08, green: 0.08, blue: 0.1)
                    .ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {

                        // MARK: Section 1 - Leagues
                        SectionHeaderView(title: "🏆 Leagues")
                        ForEach(leagues) { item in
                            FavoriteRowView(item: item)
                        }

                        // MARK: Section 2 - Clubs
                        SectionHeaderView(title: "⚽ Clubs")
                        ForEach(clubs) { item in
                            FavoriteRowView(item: item)
                        }

                        // MARK: Section 3 - Players
                        SectionHeaderView(title: "👤 Players")
                        ForEach(players) { item in
                            FavoriteRowView(item: item)
                        }

                        // MARK: Section 4 - National Teams
                        SectionHeaderView(title: "🌍 National Teams")
                        ForEach(nationalTeams) { item in
                            FavoriteRowView(item: item)
                        }

                        Spacer(minLength: 30)
                    }
                }
            }
            .navigationTitle("My Football ⚽")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color(red: 0.08, green: 0.08, blue: 0.1), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
