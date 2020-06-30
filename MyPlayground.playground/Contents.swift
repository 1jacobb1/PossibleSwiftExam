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

class VideoPlayer {
    var view: UIView!
    var isLandscape: Bool!
    
    var otherCamHeight: NSLayoutConstraint!
    var otherCamWidth: NSLayoutConstraint!
    var otherCamX: NSLayoutConstraint!
    var otherCamY: NSLayoutConstraint!
    
    var previewContentFrame: CGRect!
    var viewPeerPreviewContent: UIView!
    
    func setVideoPreviewSize(width: CGFloat = 0, height: CGFloat = 0, enableSettingPreviewContent: Bool = true) {
        let setWidth = width
        let setHeight = height
        let videoSize = CGSize(width: setWidth, height: setHeight)
        // device is portrait
        if !isLandscape {
            // - set new height and its width
            let height = computeFrameValue(baseWidth: setWidth, baseHeight: setHeight, width: self.view.bounds.width)
            self.otherCamHeight.constant = height
            self.otherCamWidth.constant = self.view.bounds.width
            
            // - height greater than width, means using device
            if setHeight > setWidth {
                // - set new frame
                let ratio: CGFloat = setWidth / setHeight
                let newHeight: CGFloat = self.view.bounds.height
                let newWidth: CGFloat = newHeight * ratio
                let newX: CGFloat = -((newWidth - self.view.bounds.width) / 2)
                let newY: CGFloat = 0

                // - apply new frame
                self.otherCamX.constant = newX
                self.otherCamY.constant = newY
                self.otherCamHeight.constant = newHeight
                self.otherCamWidth.constant = newWidth
            }

        // device is landscape
        } else {
            // - set new height and its width
            self.otherCamHeight.constant = self.view.bounds.height
            let width = self.computeFrameValue(baseWidth: setWidth, baseHeight: setHeight, height: self.view.bounds.height)
            self.otherCamWidth.constant = width
            
        }
        
        // - set new Y position
        self.otherCamY.constant = 0
        if self.view.bounds.height > self.otherCamHeight.constant {
            self.otherCamY.constant = (self.view.bounds.height / 2) - (self.otherCamHeight.constant / 2)
        }
        
        // - set new X position
        self.otherCamX.constant = 0
        if self.view.bounds.width > self.otherCamWidth.constant {
            self.otherCamX.constant = (self.view.bounds.width / 2) - (self.otherCamWidth.constant / 2)
        }
        
        // - apply layout, after updating the constraints
        self.view.layoutIfNeeded()
        
        if enableSettingPreviewContent {
            // - set media video size
            self.previewContentFrame = self.viewPeerPreviewContent.frame
        }
    }
    
    func computeFrameValue(baseWidth: CGFloat, baseHeight: CGFloat, width: CGFloat = 0, height: CGFloat = 0) -> CGFloat {
        var size: CGFloat = 0
        var baseWidthValue = baseWidth
        var baseHeightValue = baseHeight
        
        if baseWidthValue == 0 || baseHeightValue == 0 {
            if !isLandscape {
                baseHeightValue = 1280
                baseWidthValue = 720
            } else {
                baseHeightValue = 720
                baseWidthValue = 1280
            }
        }
        
        if height == 0 {
            size = (baseHeightValue / baseWidthValue) * width
        } else {
            size = (baseWidthValue / baseHeightValue) * height
        }
        
        return size
    }
}

enum PalindromeStatus: Int {
    case alreadyPalindrome = 0
    case possiblePalindrome = 1
    case notPalindrome = -1
}

var t = MyClass()
print(t.isPalindromePossible("hannah"))
