//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Yusuf Burak on 02/11/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    @State private var questionNumber = 0
    
    @State private var scoreTitle = ""
    @State private var message = ""
    @State private var showingScore = false
    @State private var isGameOver = false
    
    var body: some View {
        ZStack {
//            RadialGradient(stops: [
//                .init(color: Color(red: 0.2, green: 0.4, blue: 0.7), location: 0.3),
//                .init(color: Color(red: 0.6, green: 0.2, blue: 0.2), location: 0.3)
//            ], center: .top, startRadius: 200, endRadius: 700)
            LinearGradient(colors: [.indigo, .cyan], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                
                Spacer()
                
                Text("Guess the Flag")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.white)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.secondary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                            
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score: \(score)/\(questionNumber)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(message)
        }
        .alert("Game Over!", isPresented: $isGameOver) {
            Button("New Game", action: newGame)
        } message: {
            Text(message)
        }
        
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
            message = "You got it right!\nYour current score is \(score)."
            
        } else {
            scoreTitle = "Wrong"
            message = "You got it wrong :(\nIt was \(countries[number])'s flag.\nYour current score is \(score)."
        }
        questionNumber += 1
        if questionNumber < 8 {
            showingScore = true
        } else {
            message = "Your final score is \(score)/8."
            isGameOver = true
        }
        
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func newGame() {
        score = 0
        questionNumber = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }

}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
