//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Maverick Brazill on 7/18/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("highScore") var highScore = 0
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State var score = 0
    @State var wrong = false
    @State var wording = ""
    
    ///functions
    func check(number: Int){
        if number == correctAnswer{
            score += 1
            wording = "still"
            shuffle()
        }else{
            if (score > highScore){
                highScore = score
                wording = "now"
            }
            wrong = true
            
        }
        
    }
    
    func shuffle(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    ///
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.cyan, .purple], startPoint: .topTrailing, endPoint: .bottomLeading).ignoresSafeArea()
                //VStack{
                VStack{
                    Spacer()
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                        Text("\(countries[correctAnswer])")
                            .fontWeight(.black)
                            .font(.title)
                        
                        ForEach(0..<3) { number in
                            Button {
                                check(number: number)
                            } label: {
                                Image(countries[number])
                                    .renderingMode(.original)
                                    .clipShape(Capsule())
                                    .padding(.bottom, 50)
                                    .shadow(radius: 15)
                            }.alert("Wrong!\nYour highscore is \(wording) \(highScore)", isPresented: $wrong){
                                Button("Try Again"){
                                    score = 0
                                    shuffle()
                                }
                            }
                        }
                    }.background{
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(.ultraThinMaterial)
                            .padding(.all, -10)
                    }
                    Spacer()
                }
                .toolbar{
                    ToolbarItem(placement: .principal){
                        VStack{
                            Text("Current Score: \(score)")
                                .font(.title)
                            Text("High Score: \(highScore)")
                        }.padding(.top, 10)
                    }
                }
                //}
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
