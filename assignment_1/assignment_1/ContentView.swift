import SwiftUI

struct ContentView: View {
    // MARK: - Parallel Arrays
    let itemNames = [
        "Cat",
        "Turtle",
        "Rabbit",
        "Parrot",
        "Ladybug",
        "Goldfish"
    ]
    
    let itemIcons = [
        "pawprint.fill",
        "tortoise.fill",
        "hare.fill",
        "bird.fill",
        "ladybug.fill",
        "fish.fill"
    ]
    
    let itemDescriptions = [
        "Cats are curious, independent, and somehow always act like they own the house.",
        "Turtles are calm and patient animals that carry their home everywhere they go.",
        "Rabbits are soft, fast, and full of energy, especially when they start hopping around.",
        "Parrots are colorful birds known for their intelligence and playful personality.",
        "Ladybugs are tiny insects that look adorable and are often seen as symbols of luck.",
        "Goldfish are peaceful pets with bright colors that make any aquarium feel alive."
    ]
    
    let itemRatings = [
        5,
        2,
        5,
        4,
        3,
        1
    ]
    
    // MARK: - State
    @State private var currentIndex = 0
    @State private var tapCount = 0
    
    // MARK: - Computed Properties
    var ratingText: String {
        let rating = itemRatings[currentIndex]
        return rating == 0 ? "Not rated yet" : String(repeating: "🐾", count: rating)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.teal.opacity(0.18),
                    Color.blue.opacity(0.12),
                    Color.mint.opacity(0.18)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(spacing: 18) {
                    Image(systemName: itemIcons[currentIndex])
                        .font(.system(size: 80))
                        .foregroundStyle(.teal)
                    
                    Text(itemNames[currentIndex])
                        .font(.title)
                        .bold()
                    
                    Divider()
                        .padding(.horizontal)
                    
                    Text(itemDescriptions[currentIndex])
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    VStack(spacing: 6) {
                        Text("Cuteness:")
                            .font(.headline)
                        
                        Text(ratingText)
                            .font(.title2)
                    }
                    
                    Button(action: showRandomCard) {
                        Label("Surprise Me!", systemImage: "dice.fill")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.teal)
                    
                    Text("Cards explored: \(tapCount)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.top, 4)
                }
                .padding(24)
                .frame(maxWidth: 340)
                .background(
                    RoundedRectangle(cornerRadius: 28, style: .continuous)
                        .fill(.white.opacity(0.85))
                )
                .shadow(color: .black.opacity(0.12), radius: 12, x: 0, y: 6)
                
                Spacer()
            }
            .padding()
        }
    }
    
    // MARK: - Random Selection Logic
    func showRandomCard() {
        var newIndex: Int
        repeat {
            newIndex = Int.random(in: 0..<itemNames.count)
        } while newIndex == currentIndex
        
        currentIndex = newIndex
        tapCount += 1
    }
}

#Preview {
    ContentView()
}
