def read_input():
    with open('input.txt') as input_:
        url = input_.readline().strip("\n")
        port = int(input_.readline().strip("\n"))
        a = input_.readline().strip("\n")
        b = input_.readline().strip("\n")
    return url, port, a, b


import requests


def task(url, port, a, b):
    result = requests.get(url + ":" + str(port), params=dict(a=a, b=b))
    nums = result.json()
    nums = [num for num in  nums if num > 0]
    nums.sort(reverse=True)
    return nums


def main():
    args = read_input()
    res = task(*args)
    print("\n".join(map(str, res)))


if __name__ == "__main__":
    main()
