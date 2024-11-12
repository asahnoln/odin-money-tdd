package tests

import "../src/money"
import "core:testing"

@(test)
money_sum_reduced_to_value :: proc(t: ^testing.T) {
	m := money.Money{5, .USD}
	s := money.Sum{m, m}

	got := money.reduce(money.Rates{}, s, .USD)
	testing.expect_value(t, got, money.Money{10, .USD})
}

@(test)
diff_currencies_sum :: proc(t: ^testing.T) {
	usd := money.Money{3, .USD}
	tng := money.Money{2, .TNG}

	rates := #partial money.Rates {
		.USD = #partial{.TNG = 2},
	}

	got := money.reduce(rates, money.Sum{usd, tng}, .USD)
	testing.expect_value(t, got.amount, 4)

	got = money.reduce(rates, money.Sum{tng, usd}, .USD)
	testing.expect_value(t, got.amount, 4)
}
