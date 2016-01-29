import Foundation

/// A Nimble matcher that succeeds when the actual value is nil.
public func beNil<T>() -> MatcherFunc<T> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.postfixMessage = "be nil"
        let actualValue = try actualExpression.evaluate()
        return actualValue == nil
    }
}

public func beVoid() -> MatcherFunc<Void> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.postfixMessage = "equal ()"
        
        let actualValue: Void? = try actualExpression.evaluate()
        switch actualValue {
        case ()?: return true
        default: return false
        }
    }
}

#if _runtime(_ObjC)
extension NMBObjCMatcher {
    public class func beNilMatcher() -> NMBObjCMatcher {
        return NMBObjCMatcher { actualExpression, failureMessage in
            return try! beNil().matches(actualExpression, failureMessage: failureMessage)
        }
    }
}

//extension NMBObjCMatcher {
//    public class func beVoidMatcher() -> NMBObjCMatcher {
//        return NMBObjCMatcher { actualExpression, failureMessage in
//            return try! beVoid().matches(actualExpression, failureMessage: failureMessage)
//        }
//    }
//}
#endif
