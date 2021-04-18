//
//  ReadFromBundle.swift
//  WordScramble
//
//  Created by Pranav Kasetti on 11/04/2021.
//

import SwiftUI

struct ReadFromBundle: View {

  var words: [String] {
    if let filePath = Bundle.main.url(forResource: "start", withExtension: "txt") {
      let string = try! String(contentsOf: filePath)
      return string.components(separatedBy: "\n")
    }
    return []
  }

  var body: some View {
    List {
      ForEach(words, id: \.self) {
        Text($0)
      }
    }
  }
}

struct ReadFromBundle_Previews: PreviewProvider {
  static var previews: some View {
    ReadFromBundle()
  }
}
