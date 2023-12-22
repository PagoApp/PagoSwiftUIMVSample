public struct ValidationRuleModel: Model {

    public var validation: (String?) -> Bool
    public var error: String
    public var type: ValidationRuleType = .regular
    
    public init(validation: @escaping (String?) -> Bool, error: String, type: ValidationRuleType = .regular) {
        
        self.validation = validation
        self.error = error
        self.type = type
    }
}

/**
 Defines the logic that dictates the application of the validation rule
 */
public enum ValidationRuleType {
    /**
     It is applied on shouldReturn or didEndEditing
     */
    case regular
    /**
    Intercepts and blocks typing if the rule is not met; validation applies on the
     newly typed in chars
     */
    case blocksTypingNewText
    /**
    Intercepts and blocks typing if the rule is not met; validation applies on the
     whole text in the field (including the new typed in chars)
     */
    case blocksTypingAllText
    /**
     The rule is applied as the user types but does not block typing
     */
    case onTyping
}

public enum ValidationErrorShouldBeDisplayedType {
    /**
     Will display error regardless of the rule type
     Used for didEndEditing, for example, or whenever error display enforcing is needed
     */
    case always
    /**
     Will check the rules and display the error message only for those that it applies
     */
    case byRule
}