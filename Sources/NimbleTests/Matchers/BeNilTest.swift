import XCTest
import Nimble

class BeNilTest: XCTestCase, XCTestCaseProvider {
    var allTests: [(String, () -> Void)] {
        return [
            ("testBeNil", testBeNil),
            ("testBeVoid", testBeVoid),
        ]
    }

    func producesNil() -> Array<Int>? {
        return nil
    }

    func testBeNil() {
        expect(nil as Int?).to(beNil())
        expect(1 as Int?).toNot(beNil())
        expect(self.producesNil()).to(beNil())

        failsWithErrorMessage("expected to not be nil, got <nil>") {
            expect(nil as Int?).toNot(beNil())
        }

        failsWithErrorMessage("expected to be nil, got <1>") {
            expect(1 as Int?).to(beNil())
        }
    }

    func testBeVoid() {
        expect(Void()).to(beVoid())

        failsWithErrorMessage("expected to not equal (), got <()>") {
            expect(Void()).notTo(beVoid())
        }

        failsWithErrorMessage("expected to equal (), got <5>") {
            let v = { return 1 }
            expect(v()).to(beVoid())
        }
    }
}
