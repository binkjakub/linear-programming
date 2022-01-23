import random


capacities = [10, 50, 100]
num_items = 20

for c in capacities:
    item_sizes = [random.randint(0, c) for _ in range(num_items)]

    with open(f'./insatnce_n_{num_items}_c_{c}.bpp', 'w') as file:
        bpp_data = [num_items ,c] + item_sizes
        file.write('\n'.join(str(item) for item in bpp_data))
