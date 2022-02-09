import Foundation

@propertyWrapper
public struct CodingStyle {
    var value: String
    let codingStyle: CodingStyleEnum
    
//    private let symbols: [Character] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    public init(wrappedValue: String, with codingStyle: CodingStyleEnum) {
        self.value = wrappedValue
        self.codingStyle = codingStyle
    }
    
    private func getValue() -> String{
        let method = codingMethod()
        return method(value)
    }
    
    private mutating func setValue(newValue: String){
        self.value = newValue
    }
    
    public var wrappedValue: String {
        get {
            getValue()
        }
        set {
            setValue(newValue: newValue)
        }
    }
    
    private func codingMethod() -> ((String) -> String){
        switch codingStyle {
        case .camelCase: //need camelCase
            return {
                var splitedNew = $0.split(separator: "_")
                var joinedNew = joinAndUppercasedFirstChars(subStrings: splitedNew)
                
                splitedNew = joinedNew.split(separator: "-")
                joinedNew = joinAndUppercasedFirstChars(subStrings: splitedNew)
                
                return joinedNew
            }
        case .snakeCase: //need snake_case
            return {
                let new = $0.replacingOccurrences(of: "-", with: "_")
                
                let pattern = "([a-z0-9])([A-Z])"
                let regex = try? NSRegularExpression(pattern: pattern, options: [])
                let range = NSRange(location: 0, length: new.count)
                return regex?.stringByReplacingMatches(in: new, options: [], range: range, withTemplate: "$1_$2").lowercased() ?? new
            }
            
        case .kebabCase: //need kebab-case
            return {
                let new = $0.replacingOccurrences(of: "_", with: "-")
                let pattern = "([a-z0-9])([A-Z])"
                let regex = try? NSRegularExpression(pattern: pattern, options: [])
                let range = NSRange(location: 0, length: new.count)
                return regex?.stringByReplacingMatches(in: new, options: [], range: range, withTemplate: "$1-$2").lowercased() ?? new
            }
        }
    }
    
    private func joinAndUppercasedFirstChars(subStrings:[String.SubSequence]) -> String{
        var strings = subStrings
        if strings.count >= 2 {
            for i in 1..<strings.count{
                strings[i] = strings[i].prefix(1).uppercased() + strings[i].dropFirst()
            }
        }
        let joinedString = strings.reduce("", +)
        return joinedString
    }
}
