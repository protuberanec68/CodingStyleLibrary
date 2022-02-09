@propertyWrapper
public struct CodingStyleLibrary {
    var value: String
    let codingStyle: CodingStyle
    
    public init(wrappedValue: String, with codingStyle: CodingStyle) {
        self.value = wrappedValue
        self.codingStyle = codingStyle
    }
    
    private func getValue() -> String{
        return value
    }
    
    private mutating func setValue(newValue: String){
        let method = codingMethod()
        self.value = method(newValue)
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
        case .camelCase:
            return { $0 + "camelCase" }
        case .snakeCase:
            return { $0 + "snakeCase" }
        case .kebabCase:
            return { $0 + "kebabCase" }
        }
    }
}
