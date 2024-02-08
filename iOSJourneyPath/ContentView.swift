//
//  ContentView.swift
//  Memory
//
//  Created by alejandro fajardo on 2024-01-29.
//

import SwiftUI

struct ContentView: View {
    let emojis:[String] = ["👻","🎃", "💀","🦴","🕷️","😈","👺","👽","☠️","👁️","🧠"]
    @State var cardCount: Int = 2
    
    var body: some View {
        VStack{
            ScrollView{
                cards
            }
            Spacer()
            cardCountAdjuster
                .foregroundColor(.blue)
                .imageScale(.large)
                .font(.largeTitle)
        }
        .imageScale(.large)
        .padding()
    }
    
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]){
            ForEach(0..<cardCount, id: \.self){ index in cardView(content: emojis[index])}
                .foregroundColor(.orange)
                .aspectRatio(2/3, contentMode: .fit)
        }
    }
    
    
    var cardCountAdjuster: some View {
        HStack{
            cardRemover
            Spacer()
            cardAdder
        }
    }
    
    
    func cardCountAdjuster (by offset: Int, symbol: String) -> some View {
        Button (action: {cardCount += offset}, label: {Image(systemName: symbol)})
            .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    
    var cardRemover: some View {
            cardCountAdjuster(by: -1, symbol: "rectangle.stack.fill.badge.minus")
    }
    
    
    var cardAdder: some View {
            cardCountAdjuster(by: +1, symbol: "rectangle.stack.fill.badge.plus")
    }
}


struct cardView : View {
    let content: String
    @State var isFaceUp = true //See Note 2)
    var body: some View{
        
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group{
                base.fill(.white)
                base.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
            
        }
        
        
        .onTapGesture {
            isFaceUp.toggle()
            print("tapped")
        }
    }
}




















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


/**********************************************************************************
 Notes and learnings
 1) View Struct does not have in its scope For loop but, it has ForEach. That is why we use ForEach
 instead of a ForLoop
 
 2) @State creates a pointer that point to isFaceUp so we can change de value
 down below inside function .onTapGesture. Otherwise the compiler wont let us
 change it. That is the nature of ViewStruct: immutability
 
 3) When using a function, it is possible to not use "Return" when it is just a single line of code. That is called implicit return.
 
 With Control + i, all the text will be autoindented
 *******************************************************************************************************************************/
