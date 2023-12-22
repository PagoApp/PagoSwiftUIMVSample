/**
 Formats the text input from the user on keypress
 */
public struct FormattingRuleModel: Model {

    public var formatting: (String?) -> String?
    public var type: FormattingRuleType = .keyTyped

    public init(formatting: @escaping (String?) -> String?, type: FormattingRuleType = .keyTyped) {

        self.formatting = formatting
        self.type = type
    }
}

/**
 Defines the area of applicability of the rule
 */
public enum FormattingRuleType {
    /**
     It is applied on the typed in key/char
     */
    case keyTyped
    /**
     It is applied on the whole text
     */
    case allText
}