//
//  GameSetupView.swift
//  Edutainment
//
//  Created by Thomas Schatton on 19.04.22.
//

import SwiftUI

struct GameSetupView: View {
    @State private var selectedTable = 6
    @State private var availableQuestionCounts = [5, 10, 15, 20, 25]
    @State private var selectedQuestionAmount = 15

    private var titleColors: [Color] = [.yellow, .orange, .red]
    private var callback: (Bool, Int, Int) -> Void
    
    init(_ callback: @escaping (Bool, Int, Int) -> Void) {
        self.callback = callback
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                Group {
                    Text("Welcome to")
                        .foregroundStyle(LinearGradient(colors: titleColors, startPoint: .bottomLeading, endPoint: .topTrailing))
                        .font(.title.weight(.semibold))
                    
                    Text("EDUTAINMENT")
                        .foregroundStyle(LinearGradient(colors: titleColors, startPoint: .bottomLeading, endPoint: .topTrailing))
                        .font(.largeTitle.weight(.heavy))
                }
                .shadow(color: .black, radius: 5)
                
                Spacer()
                
                Text("Which multiplication table would you like to practice?")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .font(.headline.weight(.semibold))
                    .shadow(color: .black, radius: 5)
                
                Stepper("\(selectedTable)-er Table", value: $selectedTable, in: 2...12)
                    .padding([.leading, .trailing], 25)
                    .foregroundStyle(.white)
                    .font(.title.weight(.semibold))
                    .shadow(color: .black, radius: 3)
                
                Spacer()
                
                Text("How many questions would you like to answer?")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .font(.headline.weight(.semibold))
                    .shadow(color: .black, radius: 5)
                
                Picker("QuestionCount", selection: $selectedQuestionAmount) {
                    ForEach(availableQuestionCounts, id: \.self) { number in
                        Text(String(number))
                    }
                }
                .pickerStyle(.segmented)
                .shadow(color: .black, radius: 1)
                
                Spacer()
                
                Button {
                    callback(false, selectedTable, selectedQuestionAmount)                    
                    // eventually reset to default values of selected table and selectedQuestionAmount
                    
                } label: {
                    Text("Start Game")
                        .foregroundStyle(LinearGradient(colors: titleColors, startPoint: .topLeading, endPoint: .bottomTrailing))
                        .font(.largeTitle.weight(.bold))
                        .shadow(color: .black, radius: 5, x: 2.5, y: 2.5)
                }
            }
            .padding(30)
        }
    }
    
}

//struct GameSetupView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameSetupView()
//    }
//}
