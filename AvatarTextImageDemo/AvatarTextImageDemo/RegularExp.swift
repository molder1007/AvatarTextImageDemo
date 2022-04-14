//
//  RegularExp.swift
//  AvatarTextImageDemo
//
//  Created by Molder on 2022/4/14.
//

import Foundation

class RegularExp {
    
    private enum FormatPattern {
        case Chinese
        case English
        case Number
        case ChineseAndEnglish
        case ChineseAndNumber
        case EnglishAndNumber
        case ChineseAndEnglishAndNumber
    }
    
    private func checkStringOfRegExp(format: FormatPattern, name: String) -> Bool {
        var pattern = ""
        switch format {
        case .Chinese:
            pattern = "^[\u{4e00}-\u{9fa5}]+$"
        case .English:
            pattern = "^[a-zA-Z]+$"
        case .Number:
            pattern = "^[0-9]+$"
        case .ChineseAndEnglish:
            pattern = "^[\u{4e00}-\u{9fa5}_a-zA-Z]+$"
        case .ChineseAndNumber:
            pattern = "^[\u{4e00}-\u{9fa5}_0-9]+$"
        case .EnglishAndNumber:
            pattern = "^[a-zA-Z0-9]+$"
        case .ChineseAndEnglishAndNumber:
            pattern = "^[\u{4e00}-\u{9fa5}_a-zA-Z0-9]+$"
        }
        
        if name.isEmpty { return true }
        let firstStr = String(name.prefix(1))
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        if let matches = regex?.matches(in: firstStr, options: [],
                                        range: NSMakeRange(0, (firstStr as NSString).length)) {
            return matches.count > 0
        } else {
            return false
        }
    }
    
    func getRegExpName(firstName: String, lastName: String) -> String? {
        let fName = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
        let lName = lastName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !fName.isEmpty && !lName.isEmpty {
            // 只要任一個欄位第一位字元不為中英數文字，就不顯示
            if !checkStringOfRegExp(format: .ChineseAndEnglishAndNumber, name: fName) ||
                !checkStringOfRegExp(format: .ChineseAndEnglishAndNumber, name: lName) {
                return nil
            // 純中文輸入就顯示 last Name
            } else if checkStringOfRegExp(format: .Chinese, name: fName) &&
                        checkStringOfRegExp(format: .Chinese, name: lName) {
                return String(lName.prefix(1))
            } else {
                return String(lName.prefix(1)) + String(fName.prefix(1))
            }
        } else {
            // 其中有一個欄位為空白
            let isFirstNameEmpty = fName.isEmpty
            let name = isFirstNameEmpty ? lName : fName
            return String(name.prefix(1))
        }
    }
}
