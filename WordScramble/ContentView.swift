//
//  ContentView.swift
//  WordScramble
//
//  Created by Pranav Kasetti on 11/04/2021.
//

import SwiftUI

struct ContentView: View {

  @State var alertShowing = false
  let people = ["Finn", "Leia", "Luke", "Rey"]

  var body: some View {
    List {
      Section(header: Text("He is everywhere")) {
        Text("Welcome Brahman")
        Text("Welcome Brahman")
        Text("Welcome Brahman")
      }
      Section(footer: Text("Don't believe?")) {
        ForEach(0..<5) {
          Text("Number of believers: \($0)")
        }
      }

      List(people, id: \.self) {
        Text($0)
      }

      Section(header: Button("So") {}, footer: Button("Yo") {
        alertShowing = true
      }) {
        Text("Slipknot")
      }
      .alert(isPresented: $alertShowing, content: {
        Alert(title: Text("Hey"))
      })
    }.listStyle(GroupedListStyle())
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContentView()
      ContentView()
    }
  }
}
