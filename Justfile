
deps:
    mix deps.get

gen year='2024':
    mix advent.gen -y{{year}}

test:
    mix test

solve day part year='2024':
    mix advent.solve -d {{day}} -p {{part}} -y {{year}}

bench day part year='2024':
    mix advent.solve -d {{day}} -p {{part}} -y {{year}} --bench

