import itertools
import random


capacities = [10, 100]
num_items = [20, 50]

for n, c in itertools.product(num_items, capacities):
    item_sizes = [random.randint(0, c) for _ in range(n)]

    rel_path = f'./data/random_gen_insatnce_n_{n}_c_{c}.bpp'
    with open(rel_path, 'w') as file:
        bpp_data = [n ,c] + item_sizes
        file.write('\n'.join(str(item) for item in bpp_data))
        print(rel_path)
