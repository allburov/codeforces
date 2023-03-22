import math


def read_input():
    with open('input.txt') as input_:
        n, s = tuple(map(int, input_.readline().split()))
        orders = []
        for i in range(n):
            x, y = tuple(map(int, input_.readline().split()))
            orders.append((x, y))
    return orders, s

def find_orders(orders, s):
    return pairs


def main():
    args = read_input()
    orders = find_orders(*args)
    n = len(orders)
    print(n)
    print(orders)


if __name__ == "__main__":
    main()
