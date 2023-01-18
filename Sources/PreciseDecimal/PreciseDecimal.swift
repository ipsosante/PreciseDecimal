import Foundation

public struct PreciseDecimal: Hashable, Numeric, Comparable {
    public typealias Magnitude = Decimal.Magnitude
    public typealias IntegerLiteralType = Int

    public static var zero = PreciseDecimal("0")

    public private(set) var value: Decimal

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

    /// This is a dangerous initializer. If `value` has been initialized incorrectly the loss in precision will
    /// trickle down to this object too.
    public init(value: Decimal) {
        self.value = value
    }

    /// This is a dangerous initializer. If `significand` has been initialized incorrectly the loss in precision will
    /// trickle down to this object too.
    public init(sign: FloatingPointSign, exponent: Int, significand: Int) {
        self.value = Decimal(sign: sign, exponent: exponent, significand: Decimal(significand))
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
