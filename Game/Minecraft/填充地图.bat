dynmap fullrender 199101241230
dynmap fullrender resume 199101241230
dynmap updaterender 199101241230
wb shape round
wb 199101241230 set 10000 0 0
wb 199101241230_nether set 1250 0 0
wb 199101241230_the_end set 2000 0 0
wb list
wb fillautosave 5
wb 199101241230 fill
wb 199101241230_nether fill
wb 199101241230_the_end fill
wb fill confirm
stop

wb fill pause
wb fill cancel

chunky world yashi
chunky world yashi_nether
chunky world yashi_the_end
chunky shape circle
chunky center 0 0
chunky radius 10000
chunky radius 1250
chunky radius 2000
chunky selection
chunky start

plugins\dynmap\configuration.txt:
parallelrendercnt: 20
