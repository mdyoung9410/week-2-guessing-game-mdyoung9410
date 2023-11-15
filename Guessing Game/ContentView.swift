//
//  ContentView.swift
//  Guessing Game
//
//  Created by Montrel D. Young
//

import SwiftUI

struct ContentView: View {
    
    @State private var birds = ["Blue Pita", "Chatham Albatross", "Dunlin", "Eurasian Griffon", "Great Gray Owl", "Inca Tern", "Piping Plover", "Zitting Cristicola"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var animatedGradient: Bool = false
    @State var levelStatus = 0
  
    
    var body: some View {
        
        ZStack {
            Color.red.opacity(0.9).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .ignoresSafeArea()
            VStack {
                VStack(spacing: 20) {
                    Image(systemName: "bird")
                        .font(.system(size: 72, weight: .light))
                        .padding(.top, 70)
                        .padding(.bottom, 64)
                    
                    Button {
                    } label: {
                        Image(systemName: "arrow.right")
                    }
                    .frame(width: 50, height: 50)
                    .background(Color.red)
                    .cornerRadius(25)
                    .padding(5)
                    .overlay {
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 1))
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                
                    .multilineTextAlignment(.center)
                    .background {
                        LinearGradient(colors: [.red, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                            .edgesIgnoringSafeArea(.all)
                            .hueRotation(.degrees(animatedGradient ? 45 : 0))
                            .onAppear {
                                withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) { animatedGradient.toggle()
                                }
                            }
                    }
                    Text("Which bird is the")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                    Text(birds[correctAnswer])
                        .foregroundStyle(.black)
                        .font(.custom(
                        "AmericanTypeWriter", fixedSize: 35))
                    
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(birds[number])
                        }
                    }
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestions)
        } message: {
            Text("Your score is ???")
        }
    }
    
    //MARK: Methods
    
    func askQuestions() {
        birds.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct 100 Points"
        } else {
            scoreTitle = "Wrong Answer"
        }
        showingScore = true
    }
}

#Preview {
    ContentView()
}
