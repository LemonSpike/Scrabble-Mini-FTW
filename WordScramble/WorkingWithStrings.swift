//
//  WorkingWithStrings.swift
//  WordScramble
//
//  Created by Pranav Kasetti on 11/04/2021.
//

import SwiftUI

struct WorkingWithStrings: View {

  var words: [String] {
    if let filePath = Bundle.main.url(forResource: "start", withExtension: "txt") {

      let string = try! String(contentsOf: filePath)
      let words = string.components(separatedBy: "\n")
      let word = words.randomElement()!
      let trimmed = word.trimmingCharacters(in: .whitespacesAndNewlines)

      let checker = UITextChecker()
      let range = NSRange(location: 0, length: word.utf16.count)
      let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
      let allGood = misspelledRange.location == NSNotFound
    }
    return []
  }

    var body: some View {
        Text("Hello, World!")
    }
}

struct WorkingWithStrings_Previews: PreviewProvider {
    static var previews: some View {
        WorkingWithStrings()
    }
}
