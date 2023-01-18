import Foundation

public struct PreciseDecimal: Hashable, Numeric, Comparable {
    public typealias Magnitude = Decimal.Magnitude
    public typealias IntegerLiteralType = Int

    public static var zero = PreciseDecimal("0")

    public var value: Decimal

    public var magnitude: Decimal.Magnitude {
        value.magnitude
    }

    public init?(string: String) {
        guard let decimal = Decimal(string: string) else {
            return nil
        }
        self.value = decimal
    }

    public init(integerLiteral value: Int) {
        self.value = Decimal(integerLiteral: value)
    }

    public init?<T>(exactly source: T) where T: BinaryInteger {
        self.init(string: String(describing: source))
    }

    public static func + (lhs: Self, rhs: Self) -> Self {
        var result = Self.zero
        result.value = lhs.value + rhs.value
        return result
    }

    public static func - (lhs: Self, rhs: Self) -> Self {
        var result = Self.zero
        result.value = lhs.value - rhs.value
        return result
    }

    public static func * (lhs: PreciseDecimal, rhs: PreciseDecimal) -> PreciseDecimal {
        var result = Self.zero
        result.value = lhs.value * rhs.value
        return result
    }

    public static func *= (lhs: inout PreciseDecimal, rhs: PreciseDecimal) {
        lhs.value = lhs.value * rhs.value
    }

    // MARK: - Comparable

    public static func < (lhs: PreciseDecimal, rhs: PreciseDecimal) -> Bool {
        lhs.value < rhs.value
    }
}
