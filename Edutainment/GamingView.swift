//
//  GamingView.swift
//  Edutainment
//
//  Created by Thomas Schatton on 19.04.22.
//

import SwiftUI

struct ButtonStyle: View {
    private let item: Int
    @State private var colors: [Color] = [.red, .green, .blue, .yellow, .purple, .indigo, .pink, .mint, .orange, .cyan]
    
    init(item: Int) {
        self.item = item
    }
    
    var body: some View {
        Text("\(item)")
            .frame(width: 90, height: 90, alignment: .center)
            .foregroundStyle(.black)
            .font(.title.weight(.semibold))
            .background(LinearGradient(colors: colors.shuffled(), startPoint: .topTrailing, endPoint: .bottomLeading))
            .clipShape(Circle())
            .shadow(color: .black, radius: 5)
    }
}


struct GamingView: View {
    private var startNewGame: (Bool) -> Void
    private var selectedTable: Int!
    private var selectedQuestionCount: Int!
    
    @State private var currentQuestionCount = 0
    @State private var possibleAnswers = [Int]()
    @State private var multiplier: Int
    @State private var isNewGameButtonDisabled = true
    @State private var playerMessage = """
            
            
            
            """
    
    private let maxAnswerCount = 3
    
    let column = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100))
    ]
    
    init(_ callback: @escaping (Bool) -> Void, selectedTable: Int, selectedQuestionCount: Int) {
        self.startNewGame = callback
        self.selectedTable = selectedTable
        self.selectedQuestionCount = selectedQuestionCount
        multiplier = Int.random(in: 0...12)
    }
    
    var body: some View {
        VStack {
            Spacer()
            Group {
                VStack(spacing: 50) {
                    Text("What is \(selectedTable) x \(multiplier)?")
                        .foregroundStyle(.black)
                        .font(.title.weight(.semibold))
                    
                    LazyVGrid(columns: column, spacing: 20) {
                        ForEach(0..<possibleAnswers.count, id: \.self) { item in
                            Button {
                                checkAnswer(answer: item)
                            } label: {
                                ButtonStyle(item: possibleAnswers[item])
                            }
                        }
                    }
                    .padding()
                    .animation(.spring(), value: possibleAnswers)
                }
                
                Text(playerMessage)
            }
            .opacity(isNewGameButtonDisabled ? 1.0 : 0.0)
            .animation(.default, value: isNewGameButtonDisabled)
            
            Spacer()
            
            Button {
                startNewGame(true)
            } label: {
                Text("New Game")
                    .foregroundStyle(.black)
                    .font(.headline.weight(.bold))
            }
            .padding(50)
            .background(LinearGradient(colors: [.red, .orange, .yellow], startPoint: .top, endPoint: .bottom))
            .clipShape(Circle())
            .shadow(color: .black, radius: 5)
            .disabled(isNewGameButtonDisabled)
            .opacity(isNewGameButtonDisabled ? 0.0 : 1.0)
            .animation(.default, value: isNewGameButtonDisabled)
        }
        .onAppear(perform: createPossibleAnswers)
    }
    
    func createPossibleAnswers() {
        possibleAnswers.removeAll()
        possibleAnswers.append(selectedTable * multiplier)
        
        for _ in 1...maxAnswerCount {
            let randomResult = Int.random(in: 0...(selectedTable * 12))
            possibleAnswers.append(randomResult)
        }
        
        possibleAnswers.shuffle()
    }
    
    func checkAnswer(answer: Int) {
        currentQuestionCount += 1
        if possibleAnswers[answer] == selectedTable * multiplier {
            playerMessage = """
                \(possibleAnswers[answer]) is correct!
            
                You answered \(currentQuestionCount) of \(selectedQuestionCount ?? 0) questions.
            """
        } else {
            playerMessage = """
                \(possibleAnswers[answer]) is wrong!
                The correct answert is \(selectedTable * multiplier).
                You answered \(currentQuestionCount) of \(selectedQuestionCount ?? 0) questions.
            """
        }
        
        if currentQuestionCount == selectedQuestionCount {
            isNewGameButtonDisabled = false
        } else {
            createNewQuestion()
        }
    }
    
    func createNewQuestion() {
        multiplier = Int.random(in: 0...12)
        createPossibleAnswers()
    }
}

struct GamingView_Previews: PreviewProvider {
    static var previews: some View {
        GamingView({ isSetup in
            
        }, selectedTable: 6, selectedQuestionCount: 5)
    }
}
