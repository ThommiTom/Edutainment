//
//  ContentView.swift
//  Edutainment
//
//  Created by Thomas Schatton on 19.04.22.
//

import SwiftUI

struct ContentView: View {
    @State private var isSetup = true
    @State private var rotation = 0.0
    @State private var selectedTable: Int = 0
    @State private var selectedQuestionCount: Int = 0
    
    private var backgroundColors: [Color] = [.purple, .indigo, .blue, .cyan, .mint, .green]
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            LinearGradient(colors: backgroundColors, startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
                .animation(.default, value: rotation)
            
            Group {
                isSetup ? GameSetupView(getGameSetup).opacity(1.0) : GameSetupView(getGameSetup).opacity(0.0)
                isSetup ? GamingView(startNewGame, selectedTable: selectedTable, selectedQuestionCount: selectedQuestionCount).opacity(0.0) : GamingView(startNewGame, selectedTable: selectedTable, selectedQuestionCount: selectedQuestionCount).opacity(1.0)
//                if isSetup {
//                    isSetup ? GameSetupView(getGameSetup).opacity(1.0) : GameSetupView(getGameSetup).opacity(0.0)
//
//                } else {
//
//                    isSetup ? GamingView(startNewGame, selectedTable: selectedTable, selectedQuestionCount: selectedQuestionCount).opacity(0.0) :
//                    GamingView(startNewGame, selectedTable: selectedTable, selectedQuestionCount: selectedQuestionCount).opacity(1.0)
//                }
            }
            .animation(.default, value: isSetup)
        }
    }
    
    func getGameSetup(isSetup: Bool, selectedTable: Int, selectedQuestionCount: Int) {
        self.selectedTable = selectedTable
        self.selectedQuestionCount = selectedQuestionCount
        self.rotation = 180.0
        self.isSetup = isSetup
    }
    
    func startNewGame(startNewGame: Bool) {
        self.isSetup = startNewGame
        self.rotation = 0.0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
