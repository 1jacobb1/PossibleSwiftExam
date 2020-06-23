import UIKit

class MyClass {
    func isPalindromePossible(_ string: String) -> Int {
    
        var index = 0
        var dictionary = [String: Int]()
        var alreadyPalindrome = true
        var palindromeStatus: Int = PalindromeStatus.alreadyPalindrome.rawValue
        
        // - get middle string
        if (string.count % 2 == 1) {
            let startingIndex = string.index(string.startIndex, offsetBy: string.count/2)
            let frontString = string[startingIndex]
            dictionary = checkFromDictionaryAndAdd(character: "\(frontString)", container: dictionary)
        }
        
        while(index < (string.count/2)) {
            let startingIndex = string.index(string.startIndex, offsetBy: index)
            let endingIndex = string.index(string.endIndex, offsetBy: (index * -1) - 1)
    
            let frontString = string[startingIndex]
            let endString = string[endingIndex]
    
            dictionary = checkFromDictionaryAndAdd(character: "\(frontString)", container: dictionary)
            
            // - add ending string if startingIndex and endingIndex not the same
            if (startingIndex != endingIndex) {
                dictionary = checkFromDictionaryAndAdd(character: "\(endString)", container: dictionary)
            }
    
            if frontString != endString, alreadyPalindrome {
                alreadyPalindrome = false
            }
    
            index += 1
        }
    
        // - already palindrome
        if alreadyPalindrome {
            palindromeStatus = PalindromeStatus.alreadyPalindrome.rawValue
        
            
        // - check if possiblePalindrome
        } else {
            var canBePalindrome = true
            var moduloBy1Detected = false
            for (_, value) in dictionary.enumerated() {
                if (value.value % 2 == 1) {
                    if !moduloBy1Detected {
                        moduloBy1Detected = true
                    } else {
                        canBePalindrome = false
                        break
                    }
                }
            }
            
            if canBePalindrome {
                palindromeStatus = PalindromeStatus.possiblePalindrome.rawValue
            } else {
                palindromeStatus = PalindromeStatus.notPalindrome.rawValue
            }
        }
        return palindromeStatus
    }
    
    func checkFromDictionaryAndAdd(character: String, container: [String: Int]) -> [String: Int] {
        var con = container
    
        if let count = con[character] {
            con[character] = count + 1
        } else {
            con[character] = 1
        }
        return con
    }
}

enum PalindromeStatus: Int {
    case alreadyPalindrome = 0
    case possiblePalindrome = 1
    case notPalindrome = -1
}

var t = MyClass()
print(t.isPalindromePossible("hannah"))
