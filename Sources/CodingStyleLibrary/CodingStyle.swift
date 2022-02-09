@propertyWrapper
public struct CodingStyle {
    var value: String
    let codingStyle: CodingStyleEnum
    
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
        case .camelCase:
            return { $0 + "camelCase" }
        case .snakeCase:
            return { $0 + "snakeCase" }
        case .kebabCase:
            return { $0 + "kebabCase" }
        }
    }
}
