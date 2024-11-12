package money

// FIX: int type for value

Rates :: map[Currency]map[Currency]int

Currency :: enum {
	USD,
	TNG,
}

Money :: struct {
	amount:   int,
	currency: Currency,
}

Sum :: struct {
	augend, addend: Money,
}

reduce :: proc(rates: Rates, s: Sum, to: Currency) -> Money {
	return Money{convert(rates, s.augend, to) + convert(rates, s.addend, to), to}
}

convert :: proc(rates: Rates, m: Money, to: Currency) -> int {
	reduced_val := m.amount
	if (m.currency != to) {
		reduced_val = m.amount / rates[to][m.currency]
	}

	return reduced_val
}
