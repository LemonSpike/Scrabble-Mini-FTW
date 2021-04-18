//
//  AppLaunchesCode.swift
//  WordScramble
//
//  Created by Pranav Kasetti on 11/04/2021.
//

import SwiftUI

struct AppLaunchesCode: View {

  @State var rootWord = ""

  var body: some View {
    Text(rootWord).onAppear(perform: startGame)
  }

  func startGame() {
    // 1. Find the URL for start.txt in our app bundle
    if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
      // 2. Load start.txt into a string
      if let startWords = try? String(contentsOf: startWordsURL) {
        // 3. Split the string up into an array of strings, splitting on line breaks
        let allWords = startWords.components(separatedBy: "\n")

        // 4. Pick one random word, or use "silkworm" as a sensible default
        rootWord = allWords.randomElement() ?? "silkworm"

        // If we are here everything has worked, so we can exit
        return
      }
    }

    // If were are *here* then there was a problem – trigger a crash and report the error
    fatalError("Could not load start.txt from bundle.")
  }
}

struct AppLaunchesCode_Previews: PreviewProvider {
  static var previews: some View {
    AppLaunchesCode()
  }
}
