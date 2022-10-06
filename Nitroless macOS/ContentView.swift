//
//  ContentView.swift
//  Nitroless macOS
//
//  Created by Lakhan Lothiyi on 06/10/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var selection = 20
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    Button {
                        selection = 20
                    } label: {
                        Text("20")
                    }
                    
                    Button {
                        selection = 40
                    } label: {
                        Text("40")
                    }
                    
                    Button {
                        selection = 80
                    } label: {
                        Text("80")
                    }
                    
                    Button {
                        selection = 120
                    } label: {
                        Text("120")
                    }
                }
                .padding(5)
            }
            .frame(height: 40)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 30))]) {
                ForEach(0...selection, id: \.self) { i in
                    let str = "\(i)"
                    Text(str)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
