# クロック制約
create_clock -name clock_50MHz -period 20.000 [get_ports clock]
derive_clock_uncertainty
