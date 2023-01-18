import PreciseDecimal
import XCTest

final class PreciseDecimalTests: XCTestCase {
    func testInit() throws {
        try assert("-", "0")
        try assert("+", "0")
        try assert("-NaN", "0")
        try assert("+NaN", "0")
        try assert("-abc", "0")
        try assert("+abc", "0")

        try assert("0")
        try assert("1")
        try assert("2")
        try assert("3")
        try assert("9")
        try assert("10")
        try assert("42")
        try assert("100")
        try assert("69420")

        try assert("0.0")
        try assert("0.2")
        try assert("0.5")
        try assert("0.7")
        try assert("1.0")
        try assert("1.2")
        try assert("1.5")
        try assert("420.6")
        try assert("42069.4")

        try assert("0.00")
        try assert("0.25")
        try assert("0.50")
        try assert("0.75")
        try assert("1.00")
        try assert("1.25")
        try assert("1.50")

        try assert("1.111")
        try assert("2.222")
        try assert("3.133")
        try assert("3.333")
        try assert("69.420")
        try assert("69.421")

        try assert("1234567890.0123456789")

        try assertNil("")
        try assertNil("abc")
        try assertNil("NaN")
    }

    func testZero() throws {
        try assert(PreciseDecimal("0"), "0")
        try assert(PreciseDecimal.zero, "0")
        XCTAssertEqual(PreciseDecimal.zero, PreciseDecimal("0"))
        try assert(PreciseDecimal.zero, Decimal(string: "0"))
        try assert(PreciseDecimal.zero, Decimal.zero)
    }

    func testAddition() throws {
        try assert(PreciseDecimal("1") + PreciseDecimal("1"), "2")
        try assert(PreciseDecimal("1") + PreciseDecimal("3"), "4")
        try assert(PreciseDecimal("3") + PreciseDecimal("1"), "4")
        try assert(PreciseDecimal("1") + PreciseDecimal("30"), "31")
        try assert(PreciseDecimal("1.12454") + PreciseDecimal("3.98389"), "5.10843")
        try assert(PreciseDecimal("19743.32") + PreciseDecimal("765.12873"), "20508.44873")
    }

    func testAdditionOfNegativeNumbers() throws {
        try assert(PreciseDecimal("-1") + PreciseDecimal("1"), "0")
        try assert(PreciseDecimal("-1") + PreciseDecimal("3"), "2")
        try assert(PreciseDecimal("-3") + PreciseDecimal("1"), "-2")
        try assert(PreciseDecimal("-1") + PreciseDecimal("30"), "29")
        try assert(PreciseDecimal("-1.12454") + PreciseDecimal("3.98389"), "2.85935")
        try assert(PreciseDecimal("-19743.32") + PreciseDecimal("765.12873"), "-18978.19127")
    }

    func testSubstraction() throws {
        try assert(PreciseDecimal("1") - PreciseDecimal("1"), "0")
        try assert(PreciseDecimal("1") - PreciseDecimal("3"), "-2")
        try assert(PreciseDecimal("3") - PreciseDecimal("1"), "2")
        try assert(PreciseDecimal("1") - PreciseDecimal("30"), "-29")
        try assert(PreciseDecimal("1.12454") - PreciseDecimal("3.98389"), "-2.85935")
        try assert(PreciseDecimal("19743.32") - PreciseDecimal("765.12873"), "18978.19127")
    }

    func testSubstractionOfNegativeNumbers() throws {
        try assert(PreciseDecimal("-1") - PreciseDecimal("1"), "-2")
        try assert(PreciseDecimal("-1") - PreciseDecimal("3"), "-4")
        try assert(PreciseDecimal("-3") - PreciseDecimal("1"), "-4")
        try assert(PreciseDecimal("-1") - PreciseDecimal("30"), "-31")
        try assert(PreciseDecimal("-1.12454") - PreciseDecimal("3.98389"), "-5.10843")
        try assert(PreciseDecimal("-19743.32") - PreciseDecimal("765.12873"), "-20508.44873")
    }

    func testMultiplication() throws {
        try assert(PreciseDecimal("1") * PreciseDecimal("0"), "0")
        try assert(PreciseDecimal("1") * PreciseDecimal("1"), "1")
        try assert(PreciseDecimal("1") * PreciseDecimal("3"), "3")
        try assert(PreciseDecimal("3") * PreciseDecimal("1"), "3")
        try assert(PreciseDecimal("2") * PreciseDecimal("30"), "60")
        try assert(PreciseDecimal("1.12454") * PreciseDecimal("3.98389"), "4.4800436606")
        try assert(PreciseDecimal("19743.32") * PreciseDecimal("765.12873"), "15106181.3575836")
    }

    func testMultiplicationOfNegativeNumbers() throws {
        try assert(PreciseDecimal("-1") * PreciseDecimal("0"), "0")
        try assert(PreciseDecimal("-1") * PreciseDecimal("1"), "-1")
        try assert(PreciseDecimal("-1") * PreciseDecimal("3"), "-3")
        try assert(PreciseDecimal("-3") * PreciseDecimal("1"), "-3")
        try assert(PreciseDecimal("-2") * PreciseDecimal("30"), "-60")
        try assert(PreciseDecimal("-1.12454") * PreciseDecimal("3.98389"), "-4.4800436606")
        try assert(PreciseDecimal("-19743.32") * PreciseDecimal("765.12873"), "-15106181.3575836")
    }

    // MARK: - Comparable

    func testLessThan() throws {
        XCTAssertFalse(PreciseDecimal("1") < PreciseDecimal("0"))
        XCTAssertFalse(PreciseDecimal("1") < PreciseDecimal("1"))
        XCTAssertTrue(PreciseDecimal("1") < PreciseDecimal("3"))
        XCTAssertFalse(PreciseDecimal("3") < PreciseDecimal("1"))
        XCTAssertTrue(PreciseDecimal("2") < PreciseDecimal("30"))
        XCTAssertTrue(PreciseDecimal("1.12454") < PreciseDecimal("3.98389"))
        XCTAssertFalse(PreciseDecimal("19743.32") < PreciseDecimal("765.12873"))
    }

    func testLessThanOrEqual() throws {
        XCTAssertFalse(PreciseDecimal("1") <= PreciseDecimal("0"))
        XCTAssertTrue(PreciseDecimal("1") <= PreciseDecimal("1"))
        XCTAssertTrue(PreciseDecimal("1") <= PreciseDecimal("3"))
        XCTAssertFalse(PreciseDecimal("3") <= PreciseDecimal("1"))
        XCTAssertTrue(PreciseDecimal("2") <= PreciseDecimal("30"))
        XCTAssertTrue(PreciseDecimal("1.12454") <= PreciseDecimal("3.98389"))
        XCTAssertFalse(PreciseDecimal("19743.32") <= PreciseDecimal("765.12873"))
        XCTAssertTrue(PreciseDecimal("8784.3276") <= PreciseDecimal("8784.3276"))
    }

    func testGreaterThan() throws {
        XCTAssertTrue(PreciseDecimal("1") > PreciseDecimal("0"))
        XCTAssertFalse(PreciseDecimal("1") > PreciseDecimal("1"))
        XCTAssertFalse(PreciseDecimal("1") > PreciseDecimal("3"))
        XCTAssertTrue(PreciseDecimal("3") > PreciseDecimal("1"))
        XCTAssertFalse(PreciseDecimal("2") > PreciseDecimal("30"))
        XCTAssertFalse(PreciseDecimal("1.12454") > PreciseDecimal("3.98389"))
        XCTAssertTrue(PreciseDecimal("19743.32") > PreciseDecimal("765.12873"))
    }

    func testGreaterThanOrEqual() throws {
        XCTAssertTrue(PreciseDecimal("1") >= PreciseDecimal("0"))
        XCTAssertTrue(PreciseDecimal("1") >= PreciseDecimal("1"))
        XCTAssertFalse(PreciseDecimal("1") >= PreciseDecimal("3"))
        XCTAssertTrue(PreciseDecimal("3") >= PreciseDecimal("1"))
        XCTAssertFalse(PreciseDecimal("2") >= PreciseDecimal("30"))
        XCTAssertFalse(PreciseDecimal("1.12454") >= PreciseDecimal("3.98389"))
        XCTAssertTrue(PreciseDecimal("19743.32") >= PreciseDecimal("765.12873"))
        XCTAssertTrue(PreciseDecimal("8784.3276") >= PreciseDecimal("8784.3276"))
    }
}

private extension PreciseDecimalTests {
    func assert(_ preciseDecimal: PreciseDecimal, _ expected: Decimal?, line: UInt = #line) throws {
        XCTAssertEqual(preciseDecimal.value, try XCTUnwrap(expected), line: line)
    }

    func assert(_ preciseDecimal: PreciseDecimal, _ expected: String, line: UInt = #line) throws {
        XCTAssertEqual(preciseDecimal.value, Decimal(string: expected), line: line)
    }

    func assert(_ sut: StringLiteralType, _ expected: String, line: UInt = #line) throws {
        let normalSUT = try XCTUnwrap(PreciseDecimal(string: sut))
        let literalSUT = PreciseDecimal(stringLiteral: sut)
        XCTAssertEqual(normalSUT.value, Decimal(string: expected), line: line)
        XCTAssertEqual(literalSUT.value, Decimal(string: expected), line: line)
    }

    func assert(_ sut: StringLiteralType, line: UInt = #line) throws {
        try assert(sut, sut, line: line)
    }

    func assertNil(_ sut: StringLiteralType, line: UInt = #line) throws {
        XCTAssertNil(PreciseDecimal(string: sut), line: line)
    }
}
