package money

Rates :: [Currency][Currency]Decimal

Decimal :: f64

Currency :: enum {
	USD,
	TNG,
}

Money :: struct {
	amount:   Decimal,
	currency: Currency,
}

Sum :: struct {
	augend, addend: Money,
}

reduce :: proc {
	reduce_sum,
	reduce_money,
}

reduce_sum :: proc(rates: Rates, s: Sum, to: Currency) -> Money {
	return Money {
		amount = reduce(rates, s.augend, to).amount + reduce(rates, s.addend, to).amount,
		currency = to,
	}
}

reduce_money :: proc(rates: Rates, m: Money, to: Currency) -> Money {
	if (m.currency == to) {
		return m
	}

	return Money{m.amount / rates[to][m.currency], to}
}
